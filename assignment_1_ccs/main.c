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
  //float buffer[7] = {0};  //Buffer initialisation for 4 sample convolution example
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
    /*
     * Convolution using a circular buffer
     * New samples inserted at buff_index
     * for each convolution step de-increments from buff_index to 0th element
     * then deincrements from Nth element to buff_index
     */
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
    i++;                            //increment timestep
  } while (i-1 < N);
  return;
}

int main(void)
{

  //variable and array initilisation
  float x1[SIG_LEN] = {0};
  float x2[SIG_LEN] = {0};
  float y1[SIG_LEN] = {0};
  float y2[SIG_LEN] = {0};
  float mean_x1;
  float mean_x2;
  int sum_x1 = 0;
  int sum_x2 = 0;

  //pointer setup for file operations
  FILE *y1_txt;
  FILE *y2_txt;

  //calculate mean for x1, x2
  int i = 0;
  do {
    sum_x1 += u_1[i];
    sum_x2 += u_2[i];
    i++;
  } while (i < SIG_PERIOD);
  mean_x1 = (float)sum_x1 / SIG_PERIOD;
  mean_x2 = (float)sum_x2 / SIG_PERIOD;


  //Propagate student numbers to 900 sample array, subtract mean from each sample for zero mean signal
  i = 0;
  do {
      i++; // increment index first to avoid undefined behaviour with %
      x1[i-1] = u_1[i%9] - mean_x1;
      x2[i-1] = u_2[i%9] - mean_x2;
    } while(i < SIG_LEN);

  //pass array pointers to function to perform convolution
  conv(x1, y1, hd1, N_HD_1, SIG_LEN);
  conv(x2, y2, hd2, N_HD_2, SIG_LEN);

  //write signals to file
  y1_txt = fopen("y1.txt", "w");
  i = 0;
  do {	//loop over all samples of filtered signal
      fprintf(y1_txt, "%f\n", y1[i]);	//write sample at loop index to txt file and create new line
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

  /*    Code for 4 sample convolution example
  float x_example[] = {1, 3, 5, 2};
  float h_example[] = {4, 5, 2, 6};
  float y_example[7] = {0};
  conv(x_example, y_example, h_example, EX_LEN, 7);
  */
	return 0;
}
