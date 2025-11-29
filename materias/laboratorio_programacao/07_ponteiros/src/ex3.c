#include <stdio.h>

void soma_prod (int a, int b, int *s, int *p)
{
    *s = a + b;
    *p = a * b;
}

int read_num(const char *msg)
{
    int temp;
    printf("%s", msg);
    scanf("%d", &temp);
    return temp;
}

int main()
{
    int a, b, s, p;

    a = read_num("Digite um primeiro número inteiro: ");
    b = read_num("Digite um segundo número inteiro: ");

    soma_prod(a, b, &s, &p);

    printf(
        "\nSOMA:\t\t%d + %d = %d\n"
        "PRODUTO:\t%d * %d = %d\n",
        a, b, s, a, b, p
    );
}