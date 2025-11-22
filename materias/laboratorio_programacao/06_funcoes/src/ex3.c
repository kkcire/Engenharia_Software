#include <stdio.h>

void read_num(int num, int *highest, int *lowest)
{
    if (num > *highest)
        *highest = num;
    else if (num < *lowest)
        *lowest = num;
}

int main()
{
    int num;
    int highest, lowest;

    for (int i = 0; i < 50; i++)
    {
        printf("Digite um número inteiro: ");
        scanf("%i", &num);

        if (i == 0)
        {
            highest = num;
            lowest = num;
        }
        else
        {
            read_num(num, &highest, &lowest);
        }
    }

    printf("Maior número: %i\n", highest);
    printf("Menor número: %i\n", lowest);
}