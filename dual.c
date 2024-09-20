#include <stdio.h>
#include <math.h>
#include <dual.h>

typedef struct dual_num {
	float real;
	float dual;
} dual_num;

dual_num dl_add(dual_num dl1, dual_num dl2) {
	dual_num dl3;
	dl3.real = dl1.real + dl2.real;
	dl3.dual = dl2.dual + dl2.dual;
	return dl3;
}

dual_num dl_sub(dual_num dl1, dual_num dl2) {
	dual_num dl3;
	dl3.real = dl1.real - dl2.real;
	dl3.dual = dl2.dual - dl2.dual;
	return dl3;
}

dual_num dl_conj(dual_num dl) {
	dual_num dl2;
	dl2.real = dl.real;
	dl2.dual = -1.0f * dl.dual;
	return dl2;
}

dual_num dl_mul(dual_num dl1, dual_num dl2) {
	dual_num dl3;
	dl3.real = dl1.real * dl2.real;
	dl3.dual = dl1.real * dl2.dual + dl2.real * dl1.dual;
	return dl3;
}

dual_num dl_kmul(dual_num dl1, float k) {
	dual_num dl2;
	dl2.real = dl1.real * k;
	dl2.dual = dl1.dual * k;
	return dl2;
}

dual_num dl_div(dual_num dl1, dual_num dl2) {
	return dl_kmul(dl_mul(dl1, dl_conj(dl2)), 1.0f / (dl2.real * dl2.real));
}

dual_num dl_sin(dual_num dl1) {
	dual_num dl2;
	dl2.real = sinf(dl1.real);
	dl2.dual = dl1.dual * cosf(dl1.real);
	return dl2;
}

dual_num dl_cos(dual_num dl1) {
	dual_num dl2;
	dl2.real = cosf(dl1.real);
	dl2.dual = -1.0f * dl1.dual * sinf(dl1.real);
	return dl2;
}

dual_num dl_tan(dual_num dl1) {
	dual_num dl2;
	dl2.real = tanf(dl1.real);
	dl2.dual = dl1.dual * (dl2.real * dl2.real + 1.0f);
	return dl2;
}

dual_num dl_exp(dual_num dl1) {
	dual_num dl2;
	dl2.real = expf(dl1.real);
	dl2.dual = dl1.dual * dl2.real;
	return dl2;
}

dual_num dl_log(dual_num dl1) {
	dual_num dl2;
	dl2.real = logf(dl1.real);
	dl2.dual = dl1.dual / dl1.real;
	return dl2;
}

dual_num dl_sinh(dual_num dl1) {
	dual_num dl2;
	dl2.real = sinhf(dl1.real);
	dl2.dual = dl1.dual * coshf(dl1.real);
	return dl2;
}

dual_num dl_cosh(dual_num dl1) {
	dual_num dl2;
	dl2.real = coshf(dl1.real);
	dl2.dual = dl1.dual * coshf(dl1.real);
	return dl2;
}

dual_num dl_tanh(dual_num dl1) {
	dual_num dl2;
	dl2.real = tanhf(dl1.real);
	dl2.dual = dl1.dual * (1.0f - dl2.real * dl2.real);
	return dl2;
}

dual_num dl_asin(dual_num dl1) {
	dual_num dl2;
	dl2.real = asinf(dl1.real);
	dl2.dual = dl1.dual / sqrtf(1.0f - dl1.real * dl1.real);
	return dl2;
}

dual_num dl_acos(dual_num dl1) {
	dual_num dl2;
	dl2.real = acosf(dl1.real);
	dl2.dual = -1.0f * dl1.dual / sqrtf(1.0f - dl1.real * dl1.real);
	return dl2;
}

dual_num dl_atan(dual_num dl1) {
	dual_num dl2;
	dl2.real = atanf(dl1.real);
	dl2.dual = dl1.dual / (1.0f + dl1.real * dl1.real);
	return dl2;
}

dual_num dl_asinh(dual_num dl1) {
	dual_num dl2;
	dl2.real = asinhf(dl1.real);
	dl2.dual = dl1.dual / sqrtf(1.0f + dl1.real * dl1.real);
	return dl2;
}

dual_num dl_acosh(dual_num dl1) {
	dual_num dl2;
	dl2.real = acoshf(dl1.real);
	dl2.dual = dl1.dual / sqrtf(dl1.real * dl1.real - 1.0f);
	return dl2;
}

dual_num dl_atanh(dual_num dl1) {
	dual_num dl2;
	dl2.real = atanhf(dl1.real);
	dl2.dual = dl1.dual / (1.0f - dl1.real * dl1.real);
	return dl2;
}
