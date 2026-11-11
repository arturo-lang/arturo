#ifndef UTF8_UTIL_H
#define UTF8_UTIL_H

#ifdef __cplusplus
extern "C" {
#endif

/**
 * UTF-8 utility functions
 *
 * (c) 2010-2019 Steve Bennett <steveb@workware.net.au>
 *
 * See utf8.c for licence details.
 */

#ifndef USE_UTF8
#include <ctype.h>

#define MAX_UTF8_LEN 1

/* No utf-8 support. 1 byte = 1 char */
#define utf8_charcount(S, B) ((B) < 0 ? (int)strlen(S) : (B))
#define utf8_strwidth(S, B) utf8_strlen((S), (B))
#define utf8_tounicode(S, CP) (*(CP) = (unsigned char)*(S), 1)
#define utf8_index(C, I) (I)
#define utf8_dispwidth(C) 1
#define utf8_str_dispwidth(S) (int)strlen(S)
#define utf8_char_bytes(S, B) 1
#define utf8_inspect(S, CP, DW) (*(CP) = (unsigned char)*(S), *(DW) = 1, 1)

#else

/* Note that below the term "character" is used to refer to a grapheme cluster,
 * which may consist of multiple unicode code points.
 * The term "codepoint" refers to a single unicode codepoint
 * that may have a byte length of 1 or more
 */

#define MAX_UTF8_LEN 4

/* If you don't want to use the amalgamation, define UTF8_STATIC to empty
 * to make these functions non-static and put them in a separate .c file.
 */
#ifndef UTF8_STATIC
#define UTF8_STATIC static
#endif

/**
 * Converts the given unicode codepoint (0 - 0x1fffff) to utf-8
 * and stores the result at 'p'.
 *
 * Returns the number of bytes used to store the codepoint.
 */
UTF8_STATIC int utf8_fromunicode(char p[MAX_UTF8_LEN], unsigned uc);

/**
 * Returns the unicode codepoint corresponding to the
 * utf-8 sequence 'str'.
 *
 * Stores the result in *uc and returns the number of bytes
 * consumed.
 *
 * If 'str' is null terminated, then an invalid utf-8 sequence
 * at the end of the string will be returned as individual bytes.
 *
 * If it is not null terminated, the length *must* be checked first.
 *
 * Does not support unicode code points > \u1fffff
 */
UTF8_STATIC int utf8_tounicode(const char *str, int *uc);

/**
 * Returns the byte length of the utf-8 sequence starting with byte 'c'.
 *
 * Returns 1-4, or -1 if this is not a valid start byte.
 */
UTF8_STATIC int utf8_bytelen(int c);

/**
 * Returns the number of characters in the string of the given byte length.
 * If bytelen is -1, the string is assumed to be null terminated.
 *
 * Any bytes which are not part of an valid utf-8
 * sequence are treated as individual characters.
 *
 * Does not support unicode code points > \u1fffff
 */
UTF8_STATIC int utf8_charcount(const char *str, int bytelen);

/**
 * Returns the display width of the given unicode codepoint.
 * This is 1 for normal letters and 0 for combining codepoints and 2 for wide codepoints.
 *
 * In general, use utf8_str_dispwidth() instead of this function as
 * by itself it does not take into account combining characters,
 * which may be part of a grapheme cluster.
 */
UTF8_STATIC int utf8_dispwidth(int cp);

/**
 * Calculates the display width of the null terminates string, 'str'.
 */
UTF8_STATIC int utf8_str_dispwidth(const char *str);

/**
 * Returns the byte index of the given character in the utf-8 string
 * of the given length.
 *
 * This will return the byte length of a utf-8 string
 * if given the char length.
 */
UTF8_STATIC int utf8_index(const char *str, int charindex);

/**
 * Returns the number of bytes used to represent the first character at 'str'
 * of length 'len' bytes. (len < 0 means null-terminated string)
 *
 * A character is a utf-8 encoded base codepoint followed by any number of combining characters,
 * and possibly ZJW-joined characters.
 *
 * If the first character isn't valid UTF-8, it will be treated as a single byte character.
 */
UTF8_STATIC int utf8_char_bytes(const char *str, int len);

/**
 * Like utf8_char_bytes(), but also returns the codepoint in *c and the display width of the character
 * in *dispwidth.
 */
UTF8_STATIC int utf8_inspect(const char *str, int *c, int *dispwidth);

#endif

#ifdef __cplusplus
}
#endif

#endif
