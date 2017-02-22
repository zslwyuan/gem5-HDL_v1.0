/*
+--------------------------------------------------------------------------+
| CHStone : a suite of benchmark programs for C-based High-Level Synthesis |
| ======================================================================== |
|                                                                          |
| * Collected and Modified : Y. Hara, H. Tomiyama, S. Honda,               |
|                            H. Takada and K. Ishii                        |
|                            Nagoya University, Japan                      |
|                                                                          |
| * Remark :                                                               |
|    1. This source code is modified to unify the formats of the benchmark |
|       programs in CHStone.                                               |
|    2. Test vectors are added for CHStone.                                |
|    3. If "main_result" is 0 at the end of the program, the program is    |
|       correctly executed.                                                |
|    4. Please follow the copyright of each benchmark program.             |
+--------------------------------------------------------------------------+
*/
/*************************************************************************/
/*                                                                       */
/*   SNU-RT Benchmark Suite for Worst Case Timing Analysis               */
/*   =====================================================               */
/*                              Collected and Modified by S.-S. Lim      */
/*                                           sslim@archi.snu.ac.kr       */
/*                                         Real-Time Research Group      */
/*                                        Seoul National University      */
/*                                                                       */
/*                                                                       */
/*        < Features > - restrictions for our experimental environment   */
/*                                                                       */
/*          1. Completely structured.                                    */
/*               - There are no unconditional jumps.                     */
/*               - There are no exit from loop bodies.                   */
/*                 (There are no 'break' or 'return' in loop bodies)     */
/*          2. No 'switch' statements.                                   */
/*          3. No 'do..while' statements.                                */
/*          4. Expressions are restricted.                               */
/*               - There are no multiple expressions joined by 'or',     */
/*                'and' operations.                                      */
/*          5. No library calls.                                         */
/*               - All the functions needed are implemented in the       */
/*                 source file.                                          */
/*                                                                       */
/*                                                                       */
/*************************************************************************/
/*                                                                       */
/*  FILE: adpcm.c                                                        */
/*  SOURCE : C Algorithms for Real-Time DSP by P. M. Embree              */
/*                                                                       */
/*  DESCRIPTION :                                                        */
/*                                                                       */
/*     CCITT G.722 ADPCM (Adaptive Differential Pulse Code Modulation)   */
/*     algorithm.                                                        */
/*     16khz sample rate data is stored in the array test_data[SIZE].    */
/*     Results are stored in the array compressed[SIZE] and result[SIZE].*/
/*     Execution time is determined by the constant SIZE (default value  */
/*     is 2000).                                                         */
/*                                                                       */
/*  REMARK :                                                             */
/*                                                                       */
/*  EXECUTION TIME :                                                     */
/*                                                                       */
/*                                                                       */
/*************************************************************************/
#include <stdio.h>
#include "com.h"
#include <new>
#include <unistd.h>
using namespace std;
unsigned long long* p0;

const int wl_code_table[16] = {
  -60, 3042, 1198, 538, 334, 172, 58, -30,
  3042, 1198, 538, 334, 172, 58, -30, -60
};

const int ilb_table[32] = {
  2048, 2093, 2139, 2186, 2233, 2282, 2332, 2383,
  2435, 2489, 2543, 2599, 2656, 2714, 2774, 2834,
  2896, 2960, 3025, 3091, 3158, 3228, 3298, 3371,
  3444, 3520, 3597, 3676, 3756, 3838, 3922, 4008
};

const int decis_levl[30] = {
  280, 576, 880, 1200, 1520, 1864, 2208, 2584,
  2960, 3376, 3784, 4240, 4696, 5200, 5712, 6288,
  6864, 7520, 8184, 8968, 9752, 10712, 11664, 12896,
  14120, 15840, 17560, 20456, 23352, 32767
};


const int quant26bt_pos[31] = {
  61, 60, 59, 58, 57, 56, 55, 54,
  53, 52, 51, 50, 49, 48, 47, 46,
  45, 44, 43, 42, 41, 40, 39, 38,
  37, 36, 35, 34, 33, 32, 32
};

/* quantization table 31 long to make quantl look-up easier,
last entry is for mil=30 case when wd is max */
const int quant26bt_neg[31] = {
  63, 62, 31, 30, 29, 28, 27, 26,
  25, 24, 23, 22, 21, 20, 19, 18,
  17, 16, 15, 14, 13, 12, 11, 10,
  9, 8, 7, 6, 5, 4, 4
};

const int wh_code_table[4] = {
  798, -214, 798, -214
};


int
filtez (int *bpl, int *dlt)
{
  int i;
  long int zl;
  zl = (long) (*bpl++) * (*dlt++);
  filtez_label5:for (i = 1; i < 6; i++)
    zl += (long) (*bpl++) * (*dlt++);

  return ((int) (zl >> 14));	/* x2 here */
}

/* filtep - compute predictor output signal (pole section) */
/* input rlt1-2 and al1-2, output spl */

int
filtep (int rlt1, int al1, int rlt2, int al2)
{
  long int pl, pl2;
  pl = 2 * rlt1;
  pl = (long) al1 *pl;
  pl2 = 2 * rlt2;
  pl += (long) al2 *pl2;
  return ((int) (pl >> 15));
}



int
abs (int n)
{
  int m;

  if (n >= 0)
    m = n;
  else
    m = -n;
  return m;
}

/* quantl - quantize the difference signal in the lower sub-band */
int
quantl (int el, int detl)
{
  int ril, mil;
  long int wd, decis;

/* abs of difference signal */
  wd = abs (el);
/* determine mil based on decision levels and detl gain */
  quantl_label9:for (mil = 0; mil < 30; mil++)
    {
      decis = (decis_levl[mil] * (long) detl) >> 15L;
      if (wd <= decis)
	break;
    }
/* if mil=30 then wd is less than all decision levels */
  if (el >= 0)
    ril = quant26bt_pos[mil];
  else
    ril = quant26bt_neg[mil];
  return (ril);
}

/* logscl - update log quantizer scale factor in lower sub-band */
/* note that nbl is passed and returned */

int
logscl (int il, int nbl)
{
  long int wd;
  wd = ((long) nbl * 127L) >> 7L;	/* leak factor 127/128 */
  nbl = (int) wd + wl_code_table[il >> 2];
  if (nbl < 0)
    nbl = 0;
  if (nbl > 18432)
    nbl = 18432;
  return (nbl);
}

/* scalel: compute quantizer scale factor in lower or upper sub-band*/

int
scalel (int nbl, int shift_constant)
{
  int wd1, wd2, wd3;
  wd1 = (nbl >> 6) & 31;
  wd2 = nbl >> 11;
  wd3 = ilb_table[wd1] >> (shift_constant + 1 - wd2);
  return (wd3 << 3);
}

/* upzero - inputs: dlt, dlti[0-5], bli[0-5], outputs: updated bli[0-5] */
/* also implements delay of bli and update of dlti from dlt */

void
upzero (int dlt, int *dlti, int *bli)
{
  int i, wd2, wd3;
/*if dlt is zero, then no sum into bli */
  if (dlt == 0)
    {
      upzero_label5:for (i = 0; i < 6; i++)
	{
	  bli[i] = (int) ((255L * bli[i]) >> 8L);	/* leak factor of 255/256 */
	}
    }
  else
    {
      upzero_label8:for (i = 0; i < 6; i++)
	{
	  if ((long) dlt * dlti[i] >= 0)
	    wd2 = 128;
	  else
	    wd2 = -128;
	  wd3 = (int) ((255L * bli[i]) >> 8L);	/* leak factor of 255/256 */
	  bli[i] = wd2 + wd3;
	}
    }
/* implement delay line for dlt */
  dlti[5] = dlti[4];
  dlti[4] = dlti[3];
  dlti[3] = dlti[2];
  dlti[2] = dlti[1];
  dlti[1] = dlti[0];
  dlti[0] = dlt;
}

/* uppol2 - update second predictor coefficient (pole section) */
/* inputs: al1, al2, plt, plt1, plt2. outputs: apl2 */

int
uppol2 (int al1, int al2, int plt, int plt1, int plt2)
{
  long int wd2, wd4;
  int apl2;
  wd2 = 4L * (long) al1;
  if ((long) plt * plt1 >= 0L)
    wd2 = -wd2;			/* check same sign */
  wd2 = wd2 >> 7;		/* gain of 1/128 */
  if ((long) plt * plt2 >= 0L)
    {
      wd4 = wd2 + 128;		/* same sign case */
    }
  else
    {
      wd4 = wd2 - 128;
    }
  apl2 = wd4 + (127L * (long) al2 >> 7L);	/* leak factor of 127/128 */

/* apl2 is limited to +-.75 */
  if (apl2 > 12288)
    apl2 = 12288;
  if (apl2 < -12288)
    apl2 = -12288;
  return (apl2);
}

/* uppol1 - update first predictor coefficient (pole section) */
/* inputs: al1, apl2, plt, plt1. outputs: apl1 */

int
uppol1 (int al1, int apl2, int plt, int plt1)
{
  long int wd2;
  int wd3, apl1;
  wd2 = ((long) al1 * 255L) >> 8L;	/* leak factor of 255/256 */
  if ((long) plt * plt1 >= 0L)
    {
      apl1 = (int) wd2 + 192;	/* same sign case */
    }
  else
    {
      apl1 = (int) wd2 - 192;
    }
/* note: wd3= .9375-.75 is always positive */
  wd3 = 15360 - apl2;		/* limit value */
  if (apl1 > wd3)
    apl1 = wd3;
  if (apl1 < -wd3)
    apl1 = -wd3;
  return (apl1);
}

/* logsch - update log quantizer scale factor in higher sub-band */
/* note that nbh is passed and returned */

int
logsch (int ih, int nbh)
{
  int wd;
  wd = ((long) nbh * 127L) >> 7L;	/* leak factor 127/128 */
  nbh = wd + wh_code_table[ih];
  if (nbh < 0)
    nbh = 0;
  if (nbh > 22528)
    nbh = 22528;
  return (nbh);
}
void decode (int);

void reset ();

/* G722 C code */

/* variables for transimit quadrature mirror filter here */
int tqmf[24];

/* QMF filter coefficients:
scaled by a factor of 4 compared to G722 CCITT recomendation */




/* variables for receive quadrature mirror filter here */
int accumc[11], accumd[11];

/* outputs of decode() */
int xout1, xout2;

int xs, xd;

/* variables for encoder (hi and lo) here */

int il;




const int qq6_code6_table[64] = {
  -136, -136, -136, -136, -24808, -21904, -19008, -16704,
  -14984, -13512, -12280, -11192, -10232, -9360, -8576, -7856,
  -7192, -6576, -6000, -5456, -4944, -4464, -4008, -3576,
  -3168, -2776, -2400, -2032, -1688, -1360, -1040, -728,
  24808, 21904, 19008, 16704, 14984, 13512, 12280, 11192,
  10232, 9360, 8576, 7856, 7192, 6576, 6000, 5456,
  4944, 4464, 4008, 3576, 3168, 2776, 2400, 2032,
  1688, 1360, 1040, 728, 432, 136, -432, -136
};

const int qq4_code4_table[16] = {
  0, -20456, -12896, -8968, -6288, -4240, -2584, -1200,
  20456, 12896, 8968, 6288, 4240, 2584, 1200, 0
};


const int h[24] = {
  12, -44, -44, 212, 48, -624, 128, 1448,
  -840, -3220, 3804, 15504, 15504, 3804, -3220, -840,
  1448, 128, -624, 48, 212, -44, -44, 12
};

const int qq2_code2_table[4] = {
  -7408, -1616, 7408, 1616
};

int delay_bpl[6];

int delay_dltx[6];



int nbl;			/* delay line */
int al1, al2;
int plt1, plt2;
int rlt1, rlt2;

/* decision levels - pre-multiplied by 8, 0 to indicate end */

int detl;

/* quantization table 31 long to make quantl look-up easier,
last entry is for mil=30 case when wd is max */


int deth;


int dh, ih;


int nbh;



int delay_dhx[6];

int delay_bph[6];

int ah1, ah2;
int ph1, ph2;
int rh1, rh2;

int rh;
/* variables for decoder here */
int ilr, rl;
int dec_deth, dec_detl, dec_dlt;

int dec_del_bpl[6];

int dec_del_dltx[6];

int dec_plt, dec_plt1, dec_plt2;
int dec_szl, dec_spl, dec_sl;
int dec_rlt1, dec_rlt2, dec_rlt;
int dec_al1, dec_al2;
int dl;
int dec_nbl, dec_dh, dec_nbh;

/* variables used in filtez */
int dec_del_bph[6];

int dec_del_dhx[6];

int dec_szh;
/* variables used in filtep */
int dec_rh1, dec_rh2;
int dec_ah1, dec_ah2;
int dec_ph, dec_sph;

int dec_sh;

int dec_ph1, dec_ph2;

/* G722 encode function two ints in, one 8 bit output */

/* put input samples in xin1 = first value, xin2 = second value */
/* returns il and ih stored together */



/* decode function, result in xout1 and xout2 */

void
decode (int input)
{
  int i;
  long int xa1, xa2;		/* qmf accumulators */
  const int *h_ptr;
  int *ac_ptr, *ac_ptr1, *ad_ptr, *ad_ptr1;

/* split transmitted word from input into ilr and ih */
  ilr = input & 0x3f;
  ih = input >> 6;

/* LOWER SUB_BAND DECODER */

/* filtez: compute predictor output for zero section */
  dec_szl = filtez (dec_del_bpl, dec_del_dltx);

/* filtep: compute predictor output signal for pole section */
  dec_spl = filtep (dec_rlt1, dec_al1, dec_rlt2, dec_al2);

  dec_sl = dec_spl + dec_szl;

/* compute quantized difference signal for adaptive predic */
  dec_dlt = ((long) dec_detl * qq4_code4_table[ilr >> 2]) >> 15;

/* compute quantized difference signal for decoder output */
  dl = ((long) dec_detl * qq6_code6_table[il]) >> 15;

  rl = dl + dec_sl;

/* logscl: quantizer scale factor adaptation in the lower sub-band */
  dec_nbl = logscl (ilr, dec_nbl);

/* scalel: computes quantizer scale factor in the lower sub band */
  dec_detl = scalel (dec_nbl, 8);

/* parrec - add pole predictor output to quantized diff. signal */
/* for partially reconstructed signal */
  dec_plt = dec_dlt + dec_szl;

/* upzero: update zero section predictor coefficients */
  upzero (dec_dlt, dec_del_dltx, dec_del_bpl);

/* uppol2: update second predictor coefficient apl2 and delay it as al2 */
  dec_al2 = uppol2 (dec_al1, dec_al2, dec_plt, dec_plt1, dec_plt2);

/* uppol1: update first predictor coef. (pole setion) */
  dec_al1 = uppol1 (dec_al1, dec_al2, dec_plt, dec_plt1);

/* recons : compute recontructed signal for adaptive predictor */
  dec_rlt = dec_sl + dec_dlt;

/* done with lower sub band decoder, implement delays for next time */
  dec_rlt2 = dec_rlt1;
  dec_rlt1 = dec_rlt;
  dec_plt2 = dec_plt1;
  dec_plt1 = dec_plt;

/* HIGH SUB-BAND DECODER */

/* filtez: compute predictor output for zero section */
  dec_szh = filtez (dec_del_bph, dec_del_dhx);

/* filtep: compute predictor output signal for pole section */
  dec_sph = filtep (dec_rh1, dec_ah1, dec_rh2, dec_ah2);

/* predic:compute the predictor output value in the higher sub_band decoder */
  dec_sh = dec_sph + dec_szh;

/* in-place compute the quantized difference signal */
  dec_dh = ((long) dec_deth * qq2_code2_table[ih]) >> 15L;

/* logsch: update logarithmic quantizer scale factor in hi sub band */
  dec_nbh = logsch (ih, dec_nbh);

/* scalel: compute the quantizer scale factor in the higher sub band */
  dec_deth = scalel (dec_nbh, 10);

/* parrec: compute partially recontructed signal */
  dec_ph = dec_dh + dec_szh;

/* upzero: update zero section predictor coefficients */
  upzero (dec_dh, dec_del_dhx, dec_del_bph);

/* uppol2: update second predictor coefficient aph2 and delay it as ah2 */
  dec_ah2 = uppol2 (dec_ah1, dec_ah2, dec_ph, dec_ph1, dec_ph2);

/* uppol1: update first predictor coef. (pole setion) */
  dec_ah1 = uppol1 (dec_ah1, dec_ah2, dec_ph, dec_ph1);

/* recons : compute recontructed signal for adaptive predictor */
  rh = dec_sh + dec_dh;

/* done with high band decode, implementing delays for next time here */
  dec_rh2 = dec_rh1;
  dec_rh1 = rh;
  dec_ph2 = dec_ph1;
  dec_ph1 = dec_ph;

/* end of higher sub_band decoder */

/* end with receive quadrature mirror filters */
  xd = rl - rh;
  xs = rl + rh;

/* receive quadrature mirror filters implemented here */
  h_ptr = h;
  ac_ptr = accumc;
  ad_ptr = accumd;
  xa1 = (long) xd *(*h_ptr++);
  xa2 = (long) xs *(*h_ptr++);
/* main multiply accumulate loop for samples and coefficients */
  for (i = 0; i < 10; i++)
    {
      xa1 += (long) (*ac_ptr++) * (*h_ptr++);
      xa2 += (long) (*ad_ptr++) * (*h_ptr++);
    }
/* final mult/accumulate */
  xa1 += (long) (*ac_ptr) * (*h_ptr++);
  xa2 += (long) (*ad_ptr) * (*h_ptr++);

/* scale by 2^14 */
  xout1 = xa1 >> 14;
  xout2 = xa2 >> 14;

/* update delay lines */
  ac_ptr1 = ac_ptr - 1;
  ad_ptr1 = ad_ptr - 1;
  for (i = 0; i < 10; i++)
    {
      *ac_ptr-- = *ac_ptr1--;
      *ad_ptr-- = *ad_ptr1--;
    }
  *ac_ptr = xd;
  *ad_ptr = xs;
}

/* clear all storage locations */

void
reset ()
{
  int i;

  detl = dec_detl = 32;		/* reset to min scale factor */
  deth = dec_deth = 8;
  nbl = al1 = al2 = plt1 = plt2 = rlt1 = rlt2 = 0;
  nbh = ah1 = ah2 = ph1 = ph2 = rh1 = rh2 = 0;
  dec_nbl = dec_al1 = dec_al2 = dec_plt1 = dec_plt2 = dec_rlt1 = dec_rlt2 = 0;
  dec_nbh = dec_ah1 = dec_ah2 = dec_ph1 = dec_ph2 = dec_rh1 = dec_rh2 = 0;

  for (i = 0; i < 6; i++)
    {
      delay_dltx[i] = 0;
      delay_dhx[i] = 0;
      dec_del_dltx[i] = 0;
      dec_del_dhx[i] = 0;
    }

  for (i = 0; i < 6; i++)
    {
      delay_bpl[i] = 0;
      delay_bph[i] = 0;
      dec_del_bpl[i] = 0;
      dec_del_bph[i] = 0;
    }

  for (i = 0; i < 24; i++)
    tqmf[i] = 0;		// i<23

  for (i = 0; i < 11; i++)
    {
      accumc[i] = 0;
      accumd[i] = 0;
    }
}

/* filtez - compute predictor output signal (zero section) */
/* input: bpl1-6 and dlt1-6, output: szl */



/*
+--------------------------------------------------------------------------+
| * Test Vectors (added for CHStone)                                       |
|     test_data : input data                                               |
|     test_compressed : expected output data for "encode"                  |
|     test_result : expected output data for "decode"                      |
+--------------------------------------------------------------------------+
*/

#define SIZE 100
#define IN_END 100

const int test_data[SIZE] = {
  0x44, 0x44, 0x44, 0x44, 0x44,
  0x44, 0x44, 0x44, 0x44, 0x44,
  0x44, 0x44, 0x44, 0x44, 0x44,
  0x44, 0x44, 0x43, 0x43, 0x43,
  0x43, 0x43, 0x43, 0x43, 0x42,
  0x42, 0x42, 0x42, 0x42, 0x42,
  0x41, 0x41, 0x41, 0x41, 0x41,
  0x40, 0x40, 0x40, 0x40, 0x40,
  0x40, 0x40, 0x40, 0x3f, 0x3f,
  0x3f, 0x3f, 0x3f, 0x3e, 0x3e,
  0x3e, 0x3e, 0x3e, 0x3e, 0x3d,
  0x3d, 0x3d, 0x3d, 0x3d, 0x3d,
  0x3c, 0x3c, 0x3c, 0x3c, 0x3c,
  0x3c, 0x3c, 0x3c, 0x3c, 0x3b,
  0x3b, 0x3b, 0x3b, 0x3b, 0x3b,
  0x3b, 0x3b, 0x3b, 0x3b, 0x3b,
  0x3b, 0x3b, 0x3b, 0x3b, 0x3b,
  0x3b, 0x3b, 0x3b, 0x3b, 0x3b,
  0x3b, 0x3b, 0x3c, 0x3c, 0x3c,
  0x3c, 0x3c, 0x3c, 0x3c, 0x3c
};
int compressed[SIZE], result[SIZE];
const int test_compressed[SIZE] = {
  0xfd, 0xde, 0x77, 0xba, 0xf2, 
  0x90, 0x20, 0xa0, 0xec, 0xed, 
  0xef, 0xf1, 0xf3, 0xf4, 0xf5, 
  0xf5, 0xf5, 0xf5, 0xf6, 0xf6, 
  0xf6, 0xf7, 0xf8, 0xf7, 0xf8, 
  0xf7, 0xf9, 0xf8, 0xf7, 0xf9, 
  0xf8, 0xf8, 0xf6, 0xf8, 0xf8, 
  0xf7, 0xf9, 0xf9, 0xf9, 0xf8, 
  0xf7, 0xfa, 0xf8, 0xf8, 0xf7, 
  0xfb, 0xfa, 0xf9, 0xf8, 0xf8
};
const int test_result[SIZE] = {
  0, 0xffffffff, 0xffffffff, 0, 0, 
  0xffffffff, 0, 0, 0xffffffff, 0xffffffff, 
  0, 0, 0x1, 0x1, 0, 
  0xfffffffe, 0xffffffff, 0xfffffffe, 0, 0xfffffffc, 
  0x1, 0x1, 0x1, 0xfffffffb, 0x2, 
  0x2, 0x3, 0xb, 0x14, 0x14, 
  0x16, 0x18, 0x20, 0x21, 0x26, 
  0x27, 0x2e, 0x2f, 0x33, 0x32, 
  0x35, 0x33, 0x36, 0x34, 0x37, 
  0x34, 0x37, 0x35, 0x38, 0x36, 
  0x39, 0x38, 0x3b, 0x3a, 0x3f, 
  0x3f, 0x40, 0x3a, 0x3d, 0x3e, 
  0x41, 0x3c, 0x3e, 0x3f, 0x42, 
  0x3e, 0x3b, 0x37, 0x3b, 0x3e, 
  0x41, 0x3b, 0x3b, 0x3a, 0x3b, 
  0x36, 0x39, 0x3b, 0x3f, 0x3c, 
  0x3b, 0x37, 0x3b, 0x3d, 0x41, 
  0x3d, 0x3e, 0x3c, 0x3e, 0x3b, 
  0x3a, 0x37, 0x3b, 0x3e, 0x41, 
  0x3c, 0x3b, 0x39, 0x3a, 0x36
};

void
adpcm_main ()
{
  int i, j;
int buff[67];
      p0[1] = (unsigned long long)buff;//ReadBase
	  p0[2] = (unsigned long long)buff;//WriteBase
/* reset, initialize required memory */
  reset ();
  j = 10;
  for (i=0;i<24;i++)
	buff[i] = tqmf[i];
  for(i=0;i<6;i++)
    buff[24+i] = delay_dhx[i];
  for(i=0;i<6;i++)
    buff[30+i] = delay_bph[i];
  for(i=0;i<6;i++)
	buff[36+i] = delay_bpl[i];
  for (i=0;i<6;i++)
	buff[42+i] = delay_dltx[i];
	buff[48] = il;
	buff[49] = nbl;
	buff[50] = al1;buff[51]= al2;
	buff[52]= plt1;buff[53]= plt2;
	buff[54]= rlt1;buff[55]= rlt2;
	buff[56]= detl;
	buff[57]= nbh;
	buff[58]= deth;
	buff[59]= ah1;buff[60]= ah2;
	buff[61]= ph1;buff[62]= ph2;
	buff[63]= rh1;buff[64]= rh2;

  for (i = 0; i < IN_END; i += 2)
    { buff[65] = test_data[i];
      buff[66] = test_data[i + 1];
	//  printf("(%llx) %d %d\n ",(unsigned long long)buff, buff[65], buff[66]);
	  p0[6]=0;
	  p0[6]=1;
	  while (p0[6]);
      compressed[i / 2] = p0[9];//printf("act-%d\n",compressed[i / 2]);
	 // for (int j=0;j<67;j++) printf("%d ",buff[j]);printf("\n");
    }

  for (i=0;i<24;i++)
    tqmf[i]=buff[i] ;
  for(i=0;i<6;i++)
    delay_dhx[i]=buff[24+i];
  for(i=0;i<6;i++)
    delay_bph[i] = buff[30+i];
  for(i=0;i<6;i++)
    delay_bpl[i] = buff[36+i];
  for (i=0;i<6;i++)
	delay_dltx[i] = buff[42+i];
    il = buff[48];
    nbl = buff[49];
	al1=buff[50]; al2=buff[51];
	plt1=buff[52]; plt2=buff[53];
	rlt1=buff[54]; rlt2=buff[55];
	detl=buff[56];
	nbh=buff[57];
    deth = buff[58];
    ah1 = buff[59]; ah2=buff[60];
    ph1 = buff[61]; ph2=buff[62];
    rh1 = buff[63]; rh2=buff[64];

  for (i = 0; i < IN_END; i += 2)
    {
      decode (compressed[i / 2]);
      result[i] = xout1;
      result[i + 1] = xout2;
    }
}

int
main ()
{
  int i;
  int main_result;
	p0 =(unsigned long long *) new((unsigned long long *)0xc0000000) unsigned long long[10];//Contro Port
	//printf("111111");
	p0[0] = 81;	
	p0[8] = 1;
	p0[3] = 9;//CurrentThreadID
	p0[4] = 67;//Memory Range
	p0[5] = 4;//MemorySize
	p0[7] = 0;//Terminat
	//printf("22222");
	
      main_result = 0;
      adpcm_main ();
      for (i = 0; i < IN_END / 2; i++)
	{
	  if (compressed[i] != test_compressed[i])
	    {
	      main_result += 1;
	    }
	}
      for (i = 0; i < IN_END; i++)
	{
	  if (result[i] != test_result[i])
	    {
	      main_result += 1;
	    }
	}
      printf ("%d\n", main_result);p0[8] = 0; 
      return main_result;
    }
