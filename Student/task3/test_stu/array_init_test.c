#include <stdio.h>
int main() {
    int a[2][2][2] = {1,{2,{3}}};
    for(int i = 0; i < 3; i++)
        for(int j = 0; j < 3; j++)
            for(int k = 0; k < 2; k++)
                printf("%d ", a[i][j][k]);
    return a[0][1][0];
}