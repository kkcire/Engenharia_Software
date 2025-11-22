#include <stdio.h>

void tab(int N)
{
    for (int i = 0; i <= N; i++)
    {
        printf("%i x %i = %i\n", N, i, N * i);
    }
}

int main()
{
    int N;

    printf("Digite um número inteiro: ");
    scanf("%i", &N);
    printf("\n");
    tab(N);
}