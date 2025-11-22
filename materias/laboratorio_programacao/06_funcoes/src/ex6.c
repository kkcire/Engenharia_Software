#include <stdio.h>

int sum(int num)
{
    int result = num * (num + 1) / 2;
    return result;
}

int main()
{
    int num;

    printf("Informe um número inteiro positivo: ");
    scanf("%i", &num);

    sum(num);

    printf("\n%d", 1);
    for (int i = 2; i <= num; i++)
        printf(" + %d", i);

    printf(" = %i\n", sum(num));

    printf("\nO somatório de %i é: %i\n", num, sum(num));
}