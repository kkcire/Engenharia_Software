#include <stdio.h>

int factorial(int num)
{
    int result = 1;
    
    for (int i = 1; i <= num; i++)
    {
        result = result * i;
    }

    return result;
}

int main()
{
    int num;

    printf("Digite um número inteiro para resultar em seu fatorial: ");
    scanf("%i", &num);

    printf("\n%i! = %i", num, factorial(num));
}