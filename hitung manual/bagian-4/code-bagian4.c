#include <stdio.h>

int main()
{
    float beta, gamma, R0;

    printf("=====================================\n");
    printf(" MODEL SIR - BILANGAN REPRODUKSI DASAR\n");
    printf("=====================================\n\n");

    printf("Masukkan nilai beta  : ");
    scanf("%f", &beta);

    printf("Masukkan nilai gamma : ");
    scanf("%f", &gamma);

    R0 = beta / gamma;

    printf("\nNilai R0 = %.2f\n", R0);

    if(R0 < 1)
    {
        printf("\nAnalisis:\n");
        printf("R0 < 1\n");
        printf("Penyakit akan punah.\n");
        printf("lim I(t) -> 0 saat t -> tak hingga.\n");
    }
    else if(R0 > 1)
    {
        printf("\nAnalisis:\n");
        printf("R0 > 1\n");
        printf("Terjadi epidemi.\n");
        printf("Jumlah penderita meningkat.\n");
    }
    else
    {
        printf("\nAnalisis:\n");
        printf("R0 = 1\n");
        printf("Kondisi ambang epidemi.\n");
        printf("Jumlah penderita relatif tetap.\n");
    }

    printf("\n=====================================\n");
    printf("Kesimpulan:\n");
    printf("R0 = %.2f\n", R0);
    printf("=====================================\n");

    return 0;
}