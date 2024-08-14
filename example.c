#include <stdio.h>

int add(int x, int y) {
    return x + y;
}

int sum_array(int *arr, int n) {
    int sum = 0;
    for (int i = 0; i < n; i++) {
        sum = add(sum, arr[i]);
    }
    return sum;
}
