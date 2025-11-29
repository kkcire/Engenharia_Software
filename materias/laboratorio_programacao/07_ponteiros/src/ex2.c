#include <stdio.h>

void media_pond(float n1, float p1, float n2, float p2, float *media)
{
    *media = ((n1 * p1) + (n2 * p2)) / (p1 + p2);
}

float read_num(const char *msg)
{
    float temp;
    printf("%s", msg);
    scanf("%f", &temp);
    return temp;
}

int main()
{
    float n1, n2, p1, p2, media;

    n1 = read_num("Digite o valor da 1ª nota: ");
    p1 = read_num("Digite o peso da 1ª nota: ");

    n2 = read_num("\nDigite o valor da 2ª nota: ");
    p2 = read_num("Digite o peso da 2ª nota: ");

    media_pond(n1, p1, n2, p2, &media);

    printf("\nMédia final:\t%.2f\n", media);
}