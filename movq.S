.file "movq.S"
.section        .note.GNU-stack,"",@progbits
.text


/* mask registers */
#define K0  (0)
#define K1  (8)
#define K2  (16)
#define K3  (24)
#define K4  (32)
#define K5  (40)
#define K6  (48)
#define K7  (56)

/* AVX-512 registers */
#define ZMM0 (64)
#define ZMM1 (128)
#define ZMM2 (192)
#define ZMM3 (256)
#define ZMM4 (320)
#define ZMM5 (384)
#define ZMM6 (448)
#define ZMM7 (512)
#define ZMM8 (576)
#define ZMM9 (640)
#define ZMM10 (704)
#define ZMM11 (768)
#define ZMM12 (832)
#define ZMM13 (896)
#define ZMM14 (960)
#define ZMM15 (1024)
#define ZMM16 (1088)
#define ZMM17 (1152)
#define ZMM18 (1216)
#define ZMM19 (1280)
#define ZMM20 (1344)
#define ZMM21 (1408)
#define ZMM22 (1472)
#define ZMM23 (1536)
#define ZMM24 (1600)
#define ZMM25 (1664)
#define ZMM26 (1728)
#define ZMM27 (1792)
#define ZMM28 (1856)
#define ZMM29 (1920)
#define ZMM30 (1984)
#define ZMM31 (2048)


.align 16
.globl movq_save_restore
.type movq_save_restore, @function
movq_save_restore:
	kmovq   %k0, K0(%rdi)
	kmovq   %k1, K1(%rdi)
	kmovq   %k2, K2(%rdi)
	kmovq   %k3, K3(%rdi)
	kmovq   %k4, K4(%rdi)
	kmovq   %k5, K5(%rdi)
	kmovq   %k6, K6(%rdi)
	kmovq   %k7, K7(%rdi)

	VMOVDQA64 %zmm0,  ZMM0(%rdi)  
	VMOVDQA64 %zmm1,  ZMM1(%rdi)
	VMOVDQA64 %zmm2,  ZMM2(%rdi)
	VMOVDQA64 %zmm3,  ZMM3(%rdi)
	VMOVDQA64 %zmm4,  ZMM4(%rdi)
	VMOVDQA64 %zmm5,  ZMM5(%rdi)
	VMOVDQA64 %zmm6,  ZMM6(%rdi)
	VMOVDQA64 %zmm7,  ZMM7(%rdi)
	VMOVDQA64 %zmm8,  ZMM8(%rdi)
	VMOVDQA64 %zmm9,  ZMM9(%rdi)
	VMOVDQA64 %zmm10, ZMM10(%rdi)
	VMOVDQA64 %zmm11, ZMM11(%rdi)
	VMOVDQA64 %zmm12, ZMM12(%rdi)
	VMOVDQA64 %zmm13, ZMM13(%rdi)
	VMOVDQA64 %zmm14, ZMM14(%rdi)
	VMOVDQA64 %zmm15, ZMM15(%rdi)

	VMOVDQA64 %zmm16, ZMM16(%rdi) 
	VMOVDQA64 %zmm17, ZMM17(%rdi) 
	VMOVDQA64 %zmm18, ZMM18(%rdi) 
	VMOVDQA64 %zmm19, ZMM19(%rdi) 
	VMOVDQA64 %zmm20, ZMM20(%rdi)
	VMOVDQA64 %zmm21, ZMM21(%rdi)
	VMOVDQA64 %zmm22, ZMM22(%rdi)
	VMOVDQA64 %zmm23, ZMM23(%rdi)
	VMOVDQA64 %zmm24, ZMM24(%rdi)
	VMOVDQA64 %zmm25, ZMM25(%rdi)
	VMOVDQA64 %zmm26, ZMM26(%rdi)
	VMOVDQA64 %zmm27, ZMM27(%rdi)
	VMOVDQA64 %zmm28, ZMM28(%rdi)
	VMOVDQA64 %zmm29, ZMM29(%rdi)
	VMOVDQA64 %zmm30, ZMM30(%rdi)
	VMOVDQA64 %zmm31, ZMM31(%rdi)

	nop

	kmovq   K0(%rdi), %k0
	kmovq   K1(%rdi), %k1
	kmovq   K2(%rdi), %k2
	kmovq   K3(%rdi), %k3
	kmovq   K4(%rdi), %k4
	kmovq   K5(%rdi), %k5
	kmovq   K6(%rdi), %k6
	kmovq   K7(%rdi), %k7

	VMOVDQA64 ZMM0(%rdi),  %zmm0
	VMOVDQA64 ZMM1(%rdi),  %zmm1
	VMOVDQA64 ZMM2(%rdi),  %zmm2
	VMOVDQA64 ZMM3(%rdi),  %zmm3
	VMOVDQA64 ZMM4(%rdi),  %zmm4
	VMOVDQA64 ZMM5(%rdi),  %zmm5
	VMOVDQA64 ZMM6(%rdi),  %zmm6
	VMOVDQA64 ZMM7(%rdi),  %zmm7
	VMOVDQA64 ZMM8(%rdi),  %zmm8
	VMOVDQA64 ZMM9(%rdi),  %zmm9
	VMOVDQA64 ZMM10(%rdi), %zmm10
	VMOVDQA64 ZMM11(%rdi), %zmm11
	VMOVDQA64 ZMM12(%rdi), %zmm12
	VMOVDQA64 ZMM13(%rdi), %zmm13
	VMOVDQA64 ZMM14(%rdi), %zmm14
	VMOVDQA64 ZMM15(%rdi), %zmm15

	VMOVDQA64 ZMM16(%rdi), %zmm16
	VMOVDQA64 ZMM17(%rdi), %zmm17
	VMOVDQA64 ZMM18(%rdi), %zmm18
	VMOVDQA64 ZMM19(%rdi), %zmm19
	VMOVDQA64 ZMM20(%rdi), %zmm20
	VMOVDQA64 ZMM21(%rdi), %zmm21
	VMOVDQA64 ZMM22(%rdi), %zmm22
	VMOVDQA64 ZMM23(%rdi), %zmm23
	VMOVDQA64 ZMM24(%rdi), %zmm24
	VMOVDQA64 ZMM25(%rdi), %zmm25
	VMOVDQA64 ZMM26(%rdi), %zmm26
	VMOVDQA64 ZMM27(%rdi), %zmm27
	VMOVDQA64 ZMM28(%rdi), %zmm28
	VMOVDQA64 ZMM29(%rdi), %zmm29
	VMOVDQA64 ZMM30(%rdi), %zmm30
	VMOVDQA64 ZMM31(%rdi), %zmm31

    ret
