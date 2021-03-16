#include <stdio.h>

void b();
void c();
void d();

int main() {
    b();
    c();
    d();
}

void b() {
    unsigned int t = 0xAAAAAAAA;
    printf("B. Value: %x \n", t << 4);
}

void c() {
    unsigned int t = 0xAAAAAAAA;
    printf("C. Value: %x \n", t >> 3);
}

void d() {
    int t = 0x00101000;
    printf("3. %x\n", t + 2);
}