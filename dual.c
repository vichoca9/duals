#include <stdio.h>
#include <math.h>
#include <dual.h>

typedef struct dual_num {
	float real;
	float dual;
} dual_num;

dual_num dl_add(dual_num dl1, dual_num dl2){
	dual_num dl3;
	dl3.real=dl1.real + dl2.real;
	dl3.dual=dl2.dual + dl2.dual;
	return dl3;
}

dual_num dl_sub(dual_num dl1, dual_num dl2){
	dual_num dl3;
	dl3.real=dl1.real - dl2.real;
	dl3.dual=dl2.dual - dl2.dual;
	return dl3;
}

dual_num dl_conj(dual_num dl){
	dual_num dl2;
	dl2.real=dl.real;
	dl2.dual= -1.0f *dl.dual;
	return dl2;
}

dual_num dl_mul(dual_num dl1, dual_num dl2){
	dual_num dl3;
	dl3.real=dl1.real * dl2.real;
	dl3.dual=dl1.real * dl2.dual + dl2.real * dl1.dual;
	return dl3;
}

dual_num dl_kmul(dual_num dl1, float k){
	dual_num dl2;
	dl2.real=dl1.real*k;
	dl2.dual=dl1.dual*k;
	return dl2;
}

dual_num dl_div(dual_num dl1, dual_num dl2){
	return dl_kmul(dl_mul(dl1,dl_conj(dl2)),1.0f/(dl2.real*dl2.real));
}
