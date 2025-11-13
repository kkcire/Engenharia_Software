#include <stdio.h>

int read_var()
{
    int X;
    
    printf("Digite o valor de X: ");
    scanf("%i", &X);

    return X;
}

void print_var(int X)
{
    printf("O valor de X é: %i\n", X);
}

int main() {
    
    int X = read_var();
    print_var(X);

}
