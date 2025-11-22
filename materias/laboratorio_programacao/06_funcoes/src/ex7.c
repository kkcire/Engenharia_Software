#include <stdio.h>

int converter(int age)
{
    float days_age = age * 365.25;

    return days_age;
}

int main()
{
    int age;

    printf("Digite a idade de uma pessoa: ");
    scanf("%i", &age);

    printf("\nEssa pessoa tem %i dias de vida.", converter(age));
}