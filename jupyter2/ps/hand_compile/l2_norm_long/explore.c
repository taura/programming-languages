/* Pointers are just integers (addresses); dereferencing uses load instructions. */
long long_ptr_deref(long * p) { return *p; }       /* *p           -> ldr */
long array_index_long(long * p) { return p[0] + p[10]; }  /* p[i]   -> ldr with offset */
