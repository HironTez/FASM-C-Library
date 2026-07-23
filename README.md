# FASM C-Library

A hand-written x86-64 assembly utility library for [FASM](https://flatassembler.net/) on Linux ELF64. Provides C‑like convenience routines — console I/O, string formatting, and math — using raw Linux syscalls with no libc dependency.

## Modules

| Module | File | Purpose |
|--------|------|---------|
| **fmt** | `asmlib/fmt.asm` | Console I/O: print, input, char conversion |
| **sys** | `asmlib/sys.asm` | Exit and error handling |
| **math** | `asmlib/math.asm` | Fibonacci and factorial |

Each module has a `.inc` interface header declaring the public symbols.

## API

### fmt
| Routine | Input | Output | Description |
|---------|-------|--------|-------------|
| `printNumber` | `rax` = integer | — | Print decimal integer to stdout |
| `printChar` | `rax` = ASCII char | — | Print a single character |
| `printLine` | — | — | Print a newline (`\n`) |
| `print` | `rax` = buffer, `rdx` = size | — | Write buffer to stdout |
| `input` | `rax` = buffer, `rdx` = size | — | Read stdin into buffer (null-terminated) |
| `charToNumber` | `rax` = ASCII digit | `rax` = integer | Convert `'0'`–`'9'` to 0–9 |

### sys
| Routine | Input | Description |
|---------|-------|-------------|
| `exit` | — | Exit with code 0 |
| `exception` | `rax` = msg, `rdx` = len | Print error prefix + message, exit with code 1 |

### math
| Routine | Input | Output | Description |
|---------|-------|--------|-------------|
| `fibonacci` | `rax` = N | `rax` = fib(N) | Nth Fibonacci number |
| `factorial` | `rax` = N | `rax` = N! | Factorial of N |

## Build

Requires [fasm](https://flatassembler.net/) and GNU `ld`.

```bash
make build    # assemble and link
make run      # build and execute
make clean    # remove generated files
```

## Example

```asm
format ELF64
include 'asmlib/fmt.inc'
include 'asmlib/sys.inc'

section '.code' executable
_start:
    mov rax, 42
    call printNumber
    call printLine
    call exit
```

## License

MIT
