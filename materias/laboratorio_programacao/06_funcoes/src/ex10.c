#include <stdio.h>

void check(int num)
{
    if (num >= 0)
        printf("Positivo");
    else
        printf("Negativo");
}

int main()
{
    int num;

    printf("Digite um número inteiro: ");
    scanf("%i", &num);

    check(num);
}