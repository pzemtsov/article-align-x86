#include <cstddef>
#include <cstdint>
#include <cstring>
#include <iostream>

template<typename T> class unaligned_ref
{
    void * p;
public:
    unaligned_ref (void * p) : p (p) {}

    T operator= (const T& rvalue)
    {
        memcpy (p, &rvalue, sizeof (T));
        return rvalue;
    }

    operator T() const
    {
        T tmp;
        memcpy (&tmp, p, sizeof (T));
        return tmp;
    }
};

template<typename T> class unaligned_pointer
{
    char * p;
public:
    unaligned_pointer () : p (0) {}
    unaligned_pointer (void * p) : p ((char*)p) {}
    unaligned_ref<T> operator* () const { return unaligned_ref<T> (p); }
    unaligned_pointer operator+ (std::ptrdiff_t d) const { return unaligned_pointer (p + d * sizeof (T)); }
    unaligned_ref<T> operator[] (std::ptrdiff_t d) const { return *(*this + d); }
};

template<typename T> class const_unaligned_pointer
{
    const char * p;
public:
    const_unaligned_pointer () : p (0) {}
    const_unaligned_pointer (const void * p) : p ((const char*)p) {}
    T operator* () const
    {
        T tmp;
        memcpy (&tmp, p, sizeof (T));
        return tmp;
    }
    const_unaligned_pointer operator+ (std::ptrdiff_t d) const { return const_unaligned_pointer (p + d * sizeof (T)); }
    T operator[] (std::ptrdiff_t d) const { return *(*this + d); }
};

template<typename T> const_unaligned_pointer<T> operator+ (std::ptrdiff_t d, const_unaligned_pointer<T> p)
{
    return p + d;
}

uint64_t sum_unaligned (const char * p, size_t nwords)
{
    uint64_t res = 0;
    size_t i;
    const_unaligned_pointer<uint32_t> q (p);
    for (i = 0; i < nwords; i++) {
        res += q[i];
    }
    return res;
}

bool check_unaligned (const char * p, size_t size)
{
    const_unaligned_pointer<uint32_t> q (p);
    uint64_t sum = 0;

    sum += q [0];
    sum += q [1];
    sum += q [2];
    sum += q [3];
    sum += q [4];

    for (size_t i = 5; i < size / 4; i++) {
        sum += q [i];
    }

    do {
        sum = (sum & 0xFFFF) + (sum >> 16);
    } while (sum & ~0xFFFFL);

    return sum == 0xFFFF;
}

char mem [100];

void dump ()
{
    std::cout << (int) mem [0] << " " << (int) mem [1] << " " << (int) mem [2] << " " << (int) mem [3] << " " << (int) mem [4] << "\n";
}

int main (void)
{
    std::cout << sum_unaligned (mem + 1, 16) << "\n";
    std::cout << check_unaligned (mem + 1, 15) << "\n";

    dump ();
    unaligned_pointer<int> p (mem + 1);
    int r = *p;
    r++;
    *p = r;
    dump ();

    return 0;
}