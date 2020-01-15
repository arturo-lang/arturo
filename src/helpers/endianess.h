/*****************************************************************
 * Arturo :VM
 * 
 * Programming Language + Compiler
 * (c) 2019-2020 Yanis Zafirópulos (aka Dr.Kameleon)
 *
 * @file: src/helpers/endianess.h
 *****************************************************************/

#ifndef __ENDIANESS_H__
#define __ENDIANESS_H__

#define IS_LITTLE_ENDIAN ({ \
    int n = 1;                              \
    (*(char *)&n == 1);                     \
})

#endif