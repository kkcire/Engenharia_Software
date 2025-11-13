#include <stdio.h>
#define MAX 10

/* Função FIFO (First In First Out) */
int fifo(int refs[], int n, int capacity) 
{
    int frames[MAX], next = 0, faults = 0;
    for (int i = 0; i < capacity; i++) frames[i] = -1;

    for (int i = 0; i < n; i++) 
    {
        int ref = refs[i], hit = 0;
        for (int j = 0; j < capacity; j++) if (frames[j] == ref) hit = 1;
        if (!hit) 
        {
            frames[next] = ref;
            next = (next + 1) % capacity;
            faults++;
        }
    }
    return faults;
}

/* Função LRU (Least Recently Used) */
int lru(int refs[], int n, int capacity) 
{
    int frames[MAX], lastUsed[MAX], faults = 0;
    for (int i = 0; i < capacity; i++) frames[i] = -1;

    for (int i = 0; i < n; i++) 
    {
        int ref = refs[i], hit = 0;
        for (int j = 0; j < capacity; j++) 
        {
            if (frames[j] == ref) 
            {
                hit = 1;
                lastUsed[j] = i;
                break;
            }
        }
        if (!hit) 
        {
            int pos = -1;
            if (i < capacity) pos = i;
            else 
            {
                int min = 9999;
                for (int j = 0; j < capacity; j++)
                    if (lastUsed[j] < min) { min = lastUsed[j]; pos = j; }
            }
            frames[pos] = ref;
            lastUsed[pos] = i;
            faults++;
        }
    }
    return faults;
}

int main(void) 
{
    int refs[] = {2, 3, 5, 2, 4, 1, 2};
    int n = sizeof(refs)/sizeof(refs[0]);
    int capacity = 5;

    int f_fifo = fifo(refs, n, capacity);
    int f_lru  = lru(refs, n, capacity);

    printf("Comparação FIFO x LRU (frames = %d)\n", capacity);
    printf("Sequência: ");
    for (int i = 0; i < n; i++) printf("%d ", refs[i]);
    printf("\n\nPage Faults:\n");
    printf("FIFO = %d\n", f_fifo);
    printf("LRU  = %d\n", f_lru);
    return 0;
}