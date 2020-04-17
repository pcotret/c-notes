# Register windows in SPARC

- 128 registers available in SPARC.
- Each window is divided in 3 areas:
  - 8 input registers (`i0-i7`)
  - 8 local registers (`l0-l7`)
  - 8 output registers (`o0-07`)

```c
input // Function F1
local
output	input // Save instruction (F2 called in F1)
		local
		output	input // Save instruction (F3 called in F2)
				local
				output
```

As you can see, each time a function is called in another, the registers window "slides": by the way, output registers of $F_n$ are equal to input registers of $F_{n+1}$.

**Consequence #1 :** 24 registers are consumed for `F_1`, 40 for `F_2`...
`Reg_total = 24 + (n-1) x 16, 1 <= n <= 6`
**Consequence #2 :** we cannot have more than 6 function calls at a given time (i.e. `F_1` calling `F_2`  calling `F_3` [...] calling `F_6`). In this case, 120 registers are used.

**Consequence #3 :** if a seventh function call happens, a **window overflow** trap will happen (exception `0x05`, see [Table 7-1 in the SPARC v8 ISA](https://www.gaisler.com/doc/sparcv8.pdf)). This seventh function would need 16 more registers while only 8 registers only are available...
