#ifndef SYMTABLE_C
#define SYMTABLE_C

#include <stdio.h>
#include <string.h>

#define MAX_SYMBOLS 100

typedef struct {
    char name[32];
    int value;
    int initialized;
} Symbol;

static Symbol table[MAX_SYMBOLS];
static int symbol_count = 0;

/* Inserta una variable o actualiza su valor */
void set_symbol(const char *name, int value) {
    for (int i = 0; i < symbol_count; i++) {
        if (strcmp(table[i].name, name) == 0) {
            table[i].value = value;
            table[i].initialized = 1;
            return;
        }
    }

    strcpy(table[symbol_count].name, name);
    table[symbol_count].value = value;
    table[symbol_count].initialized = 1;
    symbol_count++;
}

/* Obtiene el valor de una variable */
int get_symbol(const char *name) {
    for (int i = 0; i < symbol_count; i++) {
        if (strcmp(table[i].name, name) == 0) {
            if (!table[i].initialized) {
                printf("⚠ Error semantico: variable '%s' no inicializada\n", name);
                return 0;
            }
            return table[i].value;
        }
    }

    printf("❌ Error semantico: variable '%s' no declarada\n", name);
    return 0;
}

#endif
