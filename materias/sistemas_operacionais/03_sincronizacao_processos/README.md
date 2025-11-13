# Aula 03 — Sincronização de Processos e Threads

**Disciplina:** Sistemas Operacionais  
**Professor:** Prof. Me. Filipo Mór  
**Semestre:** 2025/I

---

## Objetivo
Entender como evitar race conditions com mecanismos de sincronização (mutex, semáforos e barreiras) em programas multithread.

---

## Conceitos essenciais

- **Thread:** unidade de execução que compartilha memória do processo.
- **Seção crítica:** trecho que acessa dado compartilhado; deve ser protegido.
- **Race condition:** resultado incorreto quando duas threads modificam o mesmo dado ao mesmo tempo.
- **Mutex (exclusão mútua):**
  ```c
  pthread_mutex_lock(&mutex);   /* seção crítica */
  /* ... */
  pthread_mutex_unlock(&mutex);
  ```
- **Semáforo:** controla quantas threads podem acessar um recurso.
    ```c
    sem_wait(&s);  /* entra */ 
    /* ... */
    sem_post(&s);  /* sai   */
    ```
- **Barreira:** todas as threads esperam um ponto comum.
    ```c
    pthread_barrier_wait(&b);
    ```

## Exemplo 1 — Mutex + Barreira + Semáforo

**Arquivo:** exemplo1_sync_threads.c
**Ideia:** incrementar contador protegido por mutex; sincronizar fase com barreira; limitar acesso a recurso com semáforo.

**Trecho ilustrativo:**
```c
pthread_mutex_lock(&mutex);
contador++;
pthread_mutex_unlock(&mutex);

pthread_barrier_wait(&barrier);

sem_wait(&semaforo);
/* usa recurso limitado */
sem_post(&semaforo);
```

**O que observar:**
- Sem o mutex, o contador final varia (perda de incrementos).
- Com mutex, o contador bate o esperado.
- A barreira garante que todas terminem uma etapa antes da próxima.
- O semáforo limita o número de threads no recurso

# Conclusões
- **Mutex** evita condições de corrida em variáveis compartilhadas.
- **Semáforos** controlam concorrência sobre recursos limitados.
- **Barreiras** coordenam fases entre threads.
- Sem sincronização, os resultados são não determinísticos.