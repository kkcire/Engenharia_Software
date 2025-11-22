#include <stdio.h>

void category(int num)
{
    if (num >= 5 && num <= 7)
        printf("Categoria:\t Infantil A");
    else if (num >= 8 && num <= 10)
        printf("Categoria:\t Infantil B");
    else if (num >= 11 && num <= 13)
        printf("Categoria:\t Juvenil A");
    else if (num >= 14 && num <= 17)
        printf("Categoria:\t Juvenil B");
    else if (num >= 18)
        printf("Categoria:\t Adulto");
    else
        printf("Idade inválida ou indisponível para categorias.");
}

int main()
{   
    int num;

    printf("Informe a idade do nadador: ");
    scanf("%i", &num);

    category(num);
}