#include "data.h"
#include <stdio.h>


#define SIG_LEN 900
#define SIG_PERIOD 9
#define EX_LEN 4
/**
 * main.c
 */
inline void conv(float *x, float *y, float *h, int n_coef, int N){
  float buffer[N_HD_1] = {0};
  int i = 0;
  int j = 0;
  int buff_index = 0;
  float tmp;
  buffer[0] = x[0];
  i++;
  do {
    tmp = 0;
    j = 0;
    do {
      if ((buff_index-j) >= 0){
        tmp += buffer[buff_index-j]*h[j];
      } else {
        tmp += buffer[buff_index+n_coef-j]*h[j];
      }
      j++;
    } while (j < n_coef);
    buff_index = i % n_coef;
    buffer[buff_index] = x[i];
    y[i-1] = tmp;
    i++;

  } while (i < SIG_LEN);
  return;
}

int main(void)
{

  volatile int stu_num_element = 0;
  float x1[SIG_LEN] = {0};
  float x2[SIG_LEN] = {0};
  float y1[SIG_LEN] = {0};
  float y2[SIG_LEN] = {0};
  float mean_x1;
  float mean_x2;
  int sum_x1 = 0;
  int sum_x2 = 0;

  int i = 0;
  do {
    sum_x1 += u_1[i];
    sum_x2 += u_2[i];
    i++;
  } while (i < SIG_PERIOD);
  mean_x1 = (float)sum_x1 / SIG_PERIOD;
  mean_x2 = (float)sum_x2 / SIG_PERIOD;
  int test;
  i = 0;
  do {
      i++; // increment index first to avoid undefined behaviour with %
      x1[i-1] = u_1[i%9] - mean_x1;
      x2[i-1] = u_2[i%9] - mean_x2;
      test = x1[i-1]+x2[i-1];
    } while(i < SIG_LEN);
  test = 0;
  conv(x1, y1, hd1, N_HD_1, SIG_LEN);
  conv(x2, y2, hd2, N_HD_2, SIG_LEN);


	return 0;
}
