#include "data.h"
#include <stdio.h>


#define SIG_LEN 900
#define SIG_PERIOD 9
/**
 * main.c
 */
int main(void)
{

  volatile int stu_num_element = 0;
  float x1[SIG_LEN] = {0};
  float x2[SIG_LEN] = {0};
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
  mean_x1 = sum_x1 / SIG_PERIOD;
  mean_x2 = sum_x2 / SIG_PERIOD;
  int test;
  i = 0;
  do {
      i++; // increment index first to avoid undefined behaviour with %
      x1[i-1] = u_1[i%9] - mean_x1;
      x2[i-1] = u_2[i%9] - mean_x2;
      test = x1[i-1]+x2[i-1];
    } while(i < SIG_LEN);
	return 0;
}
