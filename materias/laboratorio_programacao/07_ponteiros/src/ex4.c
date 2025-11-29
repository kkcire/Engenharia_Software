#include <stdio.h>

void media_arit(float a, float b, float c, float *media)
{
    *media = (a + b + c) / 3;
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
    float a, b, c, media;

    a = read_num("Informe a primeira nota: ");
    b = read_num("Informe a segunda nota: ");
    c = read_num("Informe a terceira nota: ");

    media_arit(a, b, c, &media);

    printf("\nMÉDIA:\t\t%.2f\n",media);
}