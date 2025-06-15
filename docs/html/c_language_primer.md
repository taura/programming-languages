# 🌟 C Language Primer

## 1. Primitive Types

C provides several built-in types. Common numeric types include:

```c
int     a = 10;      // typically 4 bytes
long    b = 100000L; // typically 8 bytes
float   c = 3.14f;   // single-precision floating point
double  d = 3.14159; // double-precision floating point
```

Use `sizeof()` to check the exact size on your platform.

---

## 2. Function Definition

A function consists of a return type, name, parameters, and a body:

```c
int add(int x, int y) {
    return x + y;
}
```

Usage:

```c
int result = add(2, 3); // result = 5
```

---

## 3. Variables

Variables must be declared with a type:

```c
int count = 42;
float ratio = 0.75;
```

Uninitialized variables contain garbage values.

---

## 4. Expressions

Expressions involve operators and operands:

```c
int a = 5, b = 3;
int sum = a + b;
int product = a * b;
float quotient = (float)a / b;
```

C has standard arithmetic and logical operators.

---

## 5. Pointers and Arrays

### Pointers

A pointer stores the address of another variable:

```c
int x = 10;
int *p = &x;   // p points to x
*p = 20;       // x is now 20
```

### Arrays

Arrays are contiguous blocks of elements:

```c
int arr[3] = {1, 2, 3};
int first = arr[0];
```

Arrays and pointers are closely related:

```c
int *ptr = arr;
printf("%d\n", ptr[1]); // prints 2
```

---

## 6. `if` Statements

Conditional execution:

```c
int x = 10;
if (x > 0) {
    printf("Positive\n");
} else if (x == 0) {
    printf("Zero\n");
} else {
    printf("Negative\n");
}
```

---

## 7. `while` Statements

Loop while condition is true:

```c
int i = 0;
while (i < 5) {
    printf("%d\n", i);
    i++;
}
```

---

## 8. `for` Statements

More compact loop syntax:

```c
for (int i = 0; i < 5; i++) {
    printf("%d\n", i);
}
```

---

## 9. `typedef struct` Definitions

Custom types using `struct` and `typedef`:

```c
typedef struct {
    int id;
    float grade;
} Student;

Student s = {123, 95.5};
printf("ID: %d, Grade: %.1f\n", s.id, s.grade);
```

You can also use the traditional style:

```c
struct Student {
    int id;
    float grade;
};
```

---
