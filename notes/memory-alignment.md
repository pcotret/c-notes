This note was inspired by a work of Samuele Giraudo (LIGM, [Université Paris-Est Marne-la-Vallée](http://www.univ-mlv.fr/))

http://igm.univ-mlv.fr/~giraudo/Enseignements/

## Memory alignment
https://en.wikipedia.org/wiki/Data_structure_alignment

Memory alignment of a given data is the way this data is organized in the memory.
For instance, an array of `n` elements of type `T` is organized as a continuous array of `sizeof(T) * n` bytes. 
As a consequence, an array `t` of `3`  `uint8_t` elements is organized as:

![https://bytebucket.org/pcotret/alignment-tutorial/raw/555b7d7d5fc6e2f8a9eed163fe387306214a18d1/bytes.png?token=99a78a645f83fb3e0d47ee3f64a62d08ef856c76](https://bytebucket.org/pcotret/alignment-tutorial/raw/555b7d7d5fc6e2f8a9eed163fe387306214a18d1/bytes.png?token=99a78a645f83fb3e0d47ee3f64a62d08ef856c76)

How does memory alignment work for variables of a structured type? Let's find out :blush:
## Memory alignment within a structured type
Let's consider the following declarations:
```c
typedef struct {
uint8_t  x;
uint8_t  y;
uint16_t z;
}A;
typedef struct {
uint8_t  x;
uint16_t z;
uint8_t  y;
}B;
```
`A` and `B` are two structured types based on the same fields. Only fields order matters.
However,
```c
printf("%lu %lu\n", sizeof(A), sizeof(B));
```
displays `4 6`. `A` and `B` have diferrent size due to memory alignment...
A variable of type `A` is organized as follows:

![https://bytebucket.org/pcotret/alignment-tutorial/raw/555b7d7d5fc6e2f8a9eed163fe387306214a18d1/structure_a.png?token=43c87414e7df4644be1b97fc282f56aeb6543b81](https://bytebucket.org/pcotret/alignment-tutorial/raw/555b7d7d5fc6e2f8a9eed163fe387306214a18d1/structure_a.png?token=43c87414e7df4644be1b97fc282f56aeb6543b81)

A variable of type `B` is organized as follows:

![https://bytebucket.org/pcotret/alignment-tutorial/raw/555b7d7d5fc6e2f8a9eed163fe387306214a18d1/structure_b.png?token=3c9083448578a00891b9fd9dca52987c591a0d80](https://bytebucket.org/pcotret/alignment-tutorial/raw/555b7d7d5fc6e2f8a9eed163fe387306214a18d1/structure_b.png?token=3c9083448578a00891b9fd9dca52987c591a0d80)

Hashed bytes inserted for memory alignment are also known as  **completion bytes**.
## Completion bytes
Completion bytes are inserted in order to make each field of a structured type beginning at an address multiple of its type. In our example,  we know that each field of  `uint8_t` (resp. `uint16_t`) must begin at an address multiple of `1` (resp. `2`). Memory alignment of  `b` is as follows:

![https://bytebucket.org/pcotret/alignment-tutorial/raw/555b7d7d5fc6e2f8a9eed163fe387306214a18d1/completion_bytes.png?token=99076ecd9084a5c1556aa014fcaddae49e3bfdbd](https://bytebucket.org/pcotret/alignment-tutorial/raw/555b7d7d5fc6e2f8a9eed163fe387306214a18d1/completion_bytes.png?token=99076ecd9084a5c1556aa014fcaddae49e3bfdbd)

Last completion bytes are inserted in case we want to use arrays of `B` while respecting memory alignment.
## Manual access
Let `a` a variable of type `A` initialized by:
```c
A a = {0x10, 0x20, 0x30};
```
The memory layout of this variable is:

![https://bytebucket.org/pcotret/alignment-tutorial/raw/555b7d7d5fc6e2f8a9eed163fe387306214a18d1/structure_a.png?token=43c87414e7df4644be1b97fc282f56aeb6543b81](https://bytebucket.org/pcotret/alignment-tutorial/raw/555b7d7d5fc6e2f8a9eed163fe387306214a18d1/structure_a.png?token=43c87414e7df4644be1b97fc282f56aeb6543b81)

We can access fields of this structure as follows:
```c
uint8_t x, y;
uint16_t z;
void *p;
p = &a;
x = *((uint8_t *) p);  /* Equivalent a x = a.x; */
p += 1;
y = *((uint8_t *) p);  /* Equivalent a y = a.y; */
p += 1;
z = *((uint16_t *) p); /* Equivalent a z = a.z; */
```
Let `b` a variable of type `B` initialized by:
```c
B b = {0x10, 0x20, 0x30};
```
The memory layout of this variable is:

![https://bytebucket.org/pcotret/alignment-tutorial/raw/555b7d7d5fc6e2f8a9eed163fe387306214a18d1/structure_b.png?token=3c9083448578a00891b9fd9dca52987c591a0d80](https://bytebucket.org/pcotret/alignment-tutorial/raw/555b7d7d5fc6e2f8a9eed163fe387306214a18d1/structure_b.png?token=3c9083448578a00891b9fd9dca52987c591a0d80)

We can access fields of this structure as follows:
```c
uint8_t x, y;
uint16_t z;
void *p;
p = &a;
x = *((uint8_t *) p);  /* Equivalent a x = a.x; */
p += 2;
y = *((uint8_t *) p);  /* Equivalent a y = a.y; */
p += 2;
z = *((uint16_t *) p); /* Equivalent a z = a.z; */
```
## `-Wpadded` option
The compiler flag `-Wpadded` gives a warning when a type needs completion bytes. For instance, with the structured type `B` defined by:
```c
typedef struct {
uint8_t  x;
uint16_t z;
uint8_t  y;
} B;
```
The follwing warning appears in the terminal:
```bash
main.c:7:1: warning: padding struct size to alignment boundary [-Wpadded]
 } B;
```
## Memory alignment — A summary
Memory alignment for variables of a structured type relies on several parameters such as:
- Processor architecture on which the code has been compiled.
- Compiler itself.
Therefore, it is recommended to be aware that size of a structured type is not a trivial issue and depends of the context.
