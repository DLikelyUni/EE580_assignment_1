#include "data.h"
#include <stdio.h>


#define SIG_LEN 900
#define SIG_PERIOD 9
/**
 * main.c
 */
int main(void)
{
  int i;
  int stu_num_element;
  float x1[SIG_LEN];
  float x2[SIG_LEN];
  float mean_x1 = 0;
  float mean_x2 = 0;

  for (i = 0; i < SIG_PERIOD; i++){
    mean_x1 += (float) u_1[i];
    mean_x2 += (float) u_2[i];
  }
  mean_x1 = (float) mean_x1 / SIG_PERIOD;
  mean_x2 = (float) mean_x2 / SIG_PERIOD;

    for (i = 0; i < SIG_LEN; i++){
      stu_num_element = i % SIG_PERIOD;
      x1[i] = (float) u_1[stu_num_element] - mean_x1;
      x2[i] = (float) u_2[stu_num_element] - mean_x2;
    }
	return 0;
}
