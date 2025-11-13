#include <stdio.h>

int div(int N)
{
    int i, count = 0;
    for (i = 1; i <= N; i++)
    {
        if (N % i == 0)
        {
            count++;
        }
    }
    return count;
}

int main()
{
    int N;
    printf("Digite um número inteiro positivo: ");
    scanf("%d", &N);

    if (N <= 0)
    {
        printf("\nDigite um número inteiro positivo.\n\n");
        return 1;
    }
    else 
    {
        printf("\nO número %d possui %d divisores.\n", N, div(N));
        return 0;
    }
}