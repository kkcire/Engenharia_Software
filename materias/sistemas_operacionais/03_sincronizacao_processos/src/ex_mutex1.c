#include <stdio.h>
#include <pthread.h>

#define num_threads 5
#define increments 1000000

int count = 0;
pthread_mutex_t mutex;

void* incrementar(void*)
{
    for (int i = 0; i < increments; i++)
    {
        pthread_mutex_lock(&mutex);
        count++;
        pthread_mutex_unlock(&mutex);
    }

    pthread_exit(NULL);
    return NULL;
}

int main()
{
    pthread_t threads[num_threads];

    pthread_mutex_init(&mutex, NULL);

    for (int i = 0; i < num_threads; i++)
    {
        pthread_create(&threads[i], NULL, incrementar, NULL);
    }

    for (int i = 0; i < num_threads; i++)
    {
        pthread_join(threads[i], NULL);
    }

    pthread_mutex_destroy(&mutex);

    printf("Valor final do contador: %i", count);
    return 0;
}