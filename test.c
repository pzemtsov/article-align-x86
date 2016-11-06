#include <stdint.h>
#include <stdio.h>

extern _Bool check_ip_header_sum (const char * p, size_t size);

extern uint64_t sum  (const uint32_t * p, size_t nwords);
extern uint64_t sum0 (const char * p, size_t nwords);
extern uint64_t sum1 (const char * p, size_t nwords);
extern uint64_t sum2 (const char * p, size_t nwords);
extern uint64_t sum3 (const char * p, size_t nwords);

char x [100];

int main (void)
{
    size_t i;
    for (i = 0; i < sizeof (x); i++) x [i] = (char) i;

    for (i = 0; i < 16; i++) {
        printf ("Trying %d sum\n", (int) i);
        printf ("Done: %d\n", (int) sum ((const uint32_t*) (x + i), 16));

        printf ("Trying %d sum1\n", (int) i);
        printf ("Done: %d\n", (int) sum0 (x + i, 16));

        printf ("Trying %d sum1\n", (int) i);
        printf ("Done: %d\n", (int) sum1 (x + i, 16));

        printf ("Trying %d sum2\n", (int) i);
        printf ("Done: %d\n", (int) sum2 (x + i, 16));

        printf ("Trying %d sum3\n", (int) i);
        printf ("Done: %d\n", (int) sum3 (x + i, 16));
    }
    return 0;
}
