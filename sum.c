#include <stdlib.h>
#include <stdint.h>
#include <string.h>

_Bool check_ip_header_sum (const char * p, size_t size)
{
    const uint32_t * q = (const uint32_t *) p;
    uint64_t sum = 0;
    size_t i;

    sum += q [0];
    sum += q [1];
    sum += q [2];
    sum += q [3];
    sum += q [4];

    for (i = 5; i < size / 4; i++) {
        sum += q [i];
    }

    do {
        sum = (sum & 0xFFFF) + (sum >> 16);
    } while (sum & ~0xFFFFL);

    return sum == 0xFFFF;
}

uint64_t sum (const uint32_t * p, size_t nwords)
{
    uint64_t res = 0;
    size_t i;
    for (i = 0; i < nwords; i++) res += p [i];
    return res;
}

uint64_t sum0 (const char * p, size_t nwords)
{
    const uint32_t * q = (const uint32_t *) p;
    uint64_t res = 0;
    size_t i;
    for (i = 0; i < nwords; i++) res += q [i];
    return res;
}

#if defined (__GNUC__) && (defined (__x86_64__) || defined (__i386__))
__attribute__ ((target ("no-sse")))
#endif
uint64_t sum1 (const char * p, size_t nwords)
{
    const uint32_t * q = (const uint32_t *) p;
    uint64_t res = 0;
    size_t i;
    for (i = 0; i < nwords; i++) res += q [i];
    return res;
}

uint64_t sum2 (const char * p, size_t nwords)
{
    uint64_t res = 0;
    size_t i;
    uint32_t temp;
    for (i = 0; i < nwords; i++) {
        memcpy (&temp, p + i * sizeof (uint32_t), sizeof (temp));
        res += temp;
    }
    return res;
}

#if defined (__GNUC__) && (defined (__x86_64__) || defined (__i386__))
__attribute__ ((target ("no-sse")))
#endif
uint64_t sum3 (const char * p, size_t nwords)
{
    uint64_t res = 0;
    size_t i;
    uint32_t temp;
    for (i = 0; i < nwords; i++) {
        memcpy (&temp, p + i * sizeof (uint32_t), sizeof (temp));
        res += temp;
    }
    return res;
}

