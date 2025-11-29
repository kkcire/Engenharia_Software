#include <stdio.h>

void calc_esfera(float r, float* area, float* volume)
{
    *area = 4 * r * 2;
    *volume = 4 * r * 3 / 3;
}

int main()
{
    float r, area, volume;

    printf("Digite o valor de r: ");
    scanf("%f", &r);

    calc_esfera(r, &area, &volume);

    printf("\nÁrea da esfera:\t\t%.2f\nVolume da esfera:\t%.2f\n", area, volume);
}