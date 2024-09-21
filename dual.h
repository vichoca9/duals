#include <math.h>

#include <stdio.h>
#include <math.h>
#include <dual.h>

typedef struct dual_num {
	float real;
	float dual;
} dual_num;

dual_num dl_add(dual_num dl1, dual_num dl2);
dual_num dl_sub(dual_num dl1, dual_num dl2);
dual_num dl_conj(dual_num dl);
dual_num dl_mul(dual_num dl1, dual_num dl2);
dual_num dl_kmul(dual_num dl1, float k);
dual_num dl_div(dual_num dl1, dual_num dl2);
dual_num dl_sin(dual_num dl1);
dual_num dl_cos(dual_num dl1);
dual_num dl_tan(dual_num dl1);
dual_num dl_exp(dual_num dl1);
dual_num dl_log(dual_num dl1);
dual_num dl_sinh(dual_num dl1);
dual_num dl_cosh(dual_num dl1);
dual_num dl_tanh(dual_num dl1);
dual_num dl_asin(dual_num dl1);
dual_num dl_acos(dual_num dl1);
dual_num dl_atan(dual_num dl1);
dual_num dl_asinh(dual_num dl1);
dual_num dl_acosh(dual_num dl1);
dual_num dl_atanh(dual_num dl1);
