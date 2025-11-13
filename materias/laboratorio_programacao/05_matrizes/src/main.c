#include <stdio.h>

#define column 15
#define line 20

int main(void) {

    int mtz[line][column], x, y, count = 0, sum = 0;

    printf("\n");

    for (x = 0; x < line; x++)
    {
        for (y = 0; y < column; y++)
        {
            mtz[x][y] = count++;
            printf("[%i] ", mtz[x][y]);

            if (x % 2 == 0)
            {
                sum += mtz[x][y];
            }
        }

        printf("\n");
    }

    printf("\n");
    printf("Soma total das linhas pares: %i", sum);
}