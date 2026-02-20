#include "data.h"
#include <stdio.h>


#define SIG_LEN 900
#define SIG_PERIOD 9
#define EX_LEN 4
/**
 * main.c
 */
inline void conv(float *x, float *y, float *h, int n_coef, int N){
  float buffer[SIG_LEN] = {0};
  int i = 0;
  int j = 0;
  int buff_index = 0;
  float tmp;

  
  // assign and increment before do while, avoid mod of zero errors
  buffer[0] = x[0];
  i++;

  do {
    tmp = 0;
    j = 0;
    do {        //loop implemening difference equation
      if ((buff_index-j) >= 0){ //matches buffer element to corresponding coefficient -> buff_index place of newest element
        tmp += buffer[buff_index-j]*h[j];
      } else {
        tmp += buffer[buff_index+n_coef-j]*h[j];
      }
      j++;
    } while (j < n_coef);
    buff_index = i % n_coef;        //updates index of newest data element
    if (i < N){            //checks i is within bounds of x
        buffer[buff_index] = x[i];  //
    } else {                        //else adds zero padding to buffer
        buffer[buff_index] = 0;
    }
    y[i-1] = tmp;                   //writes conv data to output array
    //fprintf(fptr, "%f\n", tmp);
    i++;                            //increment timestep
  } while (i-1 < N);
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

  FILE *y1_txt;
  FILE *y2_txt;

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

  //y1_txt = fopen("y1.txt", "w");
  conv(x1, y1, hd1, N_HD_1, SIG_LEN);
  //fclose(y1_txt);

  //y2_txt = fopen("y2.txt","w");
  conv(x2, y2, hd2, N_HD_2, SIG_LEN);
  //fclose(y2_txt);
  y1_txt = fopen("y1.txt", "w");
  i = 0;
  do {
      fprintf(y1_txt, "%f\n", y1[i]);
      i++;
  } while (i < SIG_LEN);
  fclose(y1_txt);

  y2_txt = fopen("y2.txt", "w");
    i = 0;
    do {
        fprintf(y2_txt, "%f\n", y2[i]);
        i++;
    } while (i < SIG_LEN);
    fclose(y2_txt);

  /*
  float x_example[] = {1, 3, 5, 2};
  float h_example[] = {4, 5, 2, 6};
  float y_example[7] = {0};
  conv(x_example, y_example, h_example, EX_LEN, 7);
  */
	return 0;
}
