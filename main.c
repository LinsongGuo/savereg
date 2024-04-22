#include <stdio.h>
#include <stdlib.h>
#include <stdint.h>
#include <unistd.h>
#include <string.h>
#include <immintrin.h>
#include <sys/syscall.h>
#include <asm/prctl.h>
#include <features.h>
#include <x86intrin.h>

struct cpuid_info {
	unsigned int eax, ebx, ecx, edx;
};

// extern void zero(void);

static inline void cpuid(int leaf, int subleaf, struct cpuid_info *regs)
{
	asm volatile("cpuid" : "=a" (regs->eax), "=b" (regs->ebx),
		     "=c" (regs->ecx), "=d" (regs->edx) : "a" (leaf),
		     "c"(subleaf));
}

#define align_up(x, align)			\
	({	\
	 (((x) - 1) | ((typeof(x))(align) - 1)) + 1;})

struct xstate_header {
  uint64_t xstate_bv;
  uint64_t xcomp_bv;
  uint64_t reserved[6];
};

struct fpstate_64 {
  uint16_t cwd;
  uint16_t swd;
  /* Note this is not the same as the 32-bit/x87/FSAVE twd: */
  uint16_t twd;
  uint16_t fop;
  uint64_t rip;
  uint64_t rdp;
  uint32_t mxcsr;
  uint32_t mxcsr_mask;
  uint32_t st_space[32];  /*  8x  FP registers, 16 bytes each */
  uint32_t xmm_space[64]; /* 16x XMM registers, 16 bytes each */
  uint32_t reserved2[12];
  uint64_t sw_reserved[6];
};

struct xstate {
  struct fpstate_64 fpstate;
  struct xstate_header xstate_hdr;
  unsigned char xsave_area[];
};

#define N 10000

void test_xsate() {
    
    // asm volatile ("VZEROALL"); 
    // zero();
    
    size_t xsave_max_size;

	struct cpuid_info regs;

	cpuid(0xd, 0, &regs);
	xsave_max_size = regs.ecx;
    // printf("xsave_max_size: %ld\n", xsave_max_size);

    unsigned char* xsave_area = (unsigned char*) alloca(xsave_max_size + 64);
    xsave_area = (unsigned char *)align_up((uintptr_t)xsave_area, 64);
    struct xstate *x = (struct xstate*)xsave_area;

    int i;
    unsigned long long start1 = __rdtsc();
    for (i = 0; i < N; ++i) {        
        /* zero xsave header */
        __builtin_memset(&x->xstate_hdr, 0, sizeof(x->xstate_hdr));

        uint64_t xinuse = __builtin_ia32_xgetbv(1);
        // printf("xinuse: %lx\n", xinuse);

        /* save state */
        __builtin_ia32_xsavec64(xsave_area, xinuse);

        asm volatile ("nop");

        /* restore */
        __builtin_ia32_xrstor64(xsave_area, xinuse);
    }
    unsigned long long end1 = __rdtsc();


    unsigned long long start2 = __rdtsc();
    for (i = 0; i < N; ++i) {
        asm volatile ("nop");
    }
    unsigned long long end2 = __rdtsc();

    unsigned long long diff = (end1 - start1) - (end2 - start2);
    
    printf("xsavec: %llu cycles\n", diff / N);
}


#define OPMASK_SIZE 64
#define AVX512_SIZE 2048
void test_movq() {
    unsigned char* area = (unsigned char*) alloca(OPMASK_SIZE + AVX512_SIZE + 64);
    area = (unsigned char *)align_up((uintptr_t)area, 64);
    
    int i;
    unsigned long long start1 = __rdtsc();
    for (i = 0; i < N; ++i) {
        movq_save_restore(area); // This function is defined in movq.S.
    }
    unsigned long long end1 = __rdtsc();

    unsigned long long start2 = __rdtsc();
    for (i = 0; i < N; ++i) {
        asm volatile ("nop");
    }
    unsigned long long end2 = __rdtsc();

    unsigned long long diff = (end1 - start1) - (end2 - start2);

    printf("movq: %llu cycles\n", diff / N);
}

int main() {
   
    test_xsate();
    
    test_movq();
    
    return 0;
}