#include <stdio.h>

int validation(int num)
{
    if (num % 2 == 0)
        return 1;
    else
        return 2;
}

int main()
{
    int num;

    printf("Digite um número inteiro: ");
    scanf("%i", &num);
    validation(num);

    printf("Valor retornado: %i", validation(num));
}