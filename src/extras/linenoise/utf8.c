/**
 * UTF-8 utility functions
 *
 * (c) 2010-2026 Steve Bennett <steveb@workware.net.au>
 *
 * All rights reserved.
 *
 * Redistribution and use in source and binary forms, with or without
 * modification, are permitted provided that the following conditions are met:
 *
 * * Redistributions of source code must retain the above copyright notice,
 *   this list of conditions and the following disclaimer.
 *
 * * Redistributions in binary form must reproduce the above copyright notice,
 *   this list of conditions and the following disclaimer in the documentation
 *   and/or other materials provided with the distribution.
 *
 * THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND
 * ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
 * WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
 * DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT OWNER OR CONTRIBUTORS BE LIABLE FOR
 * ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES
 * (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;
 * LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON
 * ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
 * (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
 * SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
 */

#include <ctype.h>
#include <stdlib.h>
#include <string.h>
#include <stdio.h>
#include <assert.h>
#ifndef UTF8_UTIL_H
#include "utf8.h"
#endif

#ifdef USE_UTF8
UTF8_STATIC int utf8_fromunicode(char p[MAX_UTF8_LEN], unsigned uc)
{
    if (uc <= 0x7f) {
        *p = uc;
        return 1;
    }
    else if (uc <= 0x7ff) {
        *p++ = 0xc0 | ((uc & 0x7c0) >> 6);
        *p = 0x80 | (uc & 0x3f);
        return 2;
    }
    else if (uc <= 0xffff) {
        *p++ = 0xe0 | ((uc & 0xf000) >> 12);
        *p++ = 0x80 | ((uc & 0xfc0) >> 6);
        *p = 0x80 | (uc & 0x3f);
        return 3;
    }
    /* Note: We silently truncate to 21 bits here: 0x1fffff */
    else {
        *p++ = 0xf0 | ((uc & 0x1c0000) >> 18);
        *p++ = 0x80 | ((uc & 0x3f000) >> 12);
        *p++ = 0x80 | ((uc & 0xfc0) >> 6);
        *p = 0x80 | (uc & 0x3f);
        return 4;
    }
}

UTF8_STATIC int utf8_bytelen(int c)
{
    if ((c & 0x80) == 0) {
        return 1;
    }
    if ((c & 0xe0) == 0xc0) {
        return 2;
    }
    if ((c & 0xf0) == 0xe0) {
        return 3;
    }
    if ((c & 0xf8) == 0xf0) {
        return 4;
    }
    /* Invalid sequence */
    return -1;
}

UTF8_STATIC int utf8_charcount(const char *str, int bytelen)
{
    int chars = 0;
    if (bytelen < 0) {
        bytelen = strlen(str);
    }
    while (bytelen > 0) {
        int n = utf8_char_bytes(str, bytelen);
        if (n > bytelen) {
            /* This is an invalid sequence, so consume what is remaining */
            n = bytelen;
        }
        bytelen -= n;
        str += n;
        chars++;
    }
    return chars;
}

UTF8_STATIC int utf8_index(const char *str, int index)
{
    const char *s = str;
    while (index--) {
        s += utf8_char_bytes(s, -1);
    }
    return s - str;
}

UTF8_STATIC int utf8_tounicode(const char *str, int *uc)
{
    unsigned const char *s = (unsigned const char *)str;

    if (s[0] < 0xc0) {
        *uc = s[0];
        return 1;
    }
    if (s[0] < 0xe0) {
        if ((s[1] & 0xc0) == 0x80) {
            *uc = ((s[0] & ~0xc0) << 6) | (s[1] & ~0x80);
            if (*uc >= 0x80) {
                return 2;
            }
            /* Otherwise this is an invalid sequence */
        }
    }
    else if (s[0] < 0xf0) {
        if (((str[1] & 0xc0) == 0x80) && ((str[2] & 0xc0) == 0x80)) {
            *uc = ((s[0] & ~0xe0) << 12) | ((s[1] & ~0x80) << 6) | (s[2] & ~0x80);
            if (*uc >= 0x800) {
                return 3;
            }
            /* Otherwise this is an invalid sequence */
        }
    }
    else if (s[0] < 0xf8) {
        if (((str[1] & 0xc0) == 0x80) && ((str[2] & 0xc0) == 0x80) && ((str[3] & 0xc0) == 0x80)) {
            *uc = ((s[0] & ~0xf0) << 18) | ((s[1] & ~0x80) << 12) | ((s[2] & ~0x80) << 6) | (s[3] & ~0x80);
            if (*uc >= 0x10000) {
                return 4;
            }
            /* Otherwise this is an invalid sequence */
        }
    }

    /* Invalid sequence, so just return the byte */
    *uc = *s;
    return 1;
}

UTF8_STATIC int utf8_inspect(const char *str, int *c, int *dispwidth)
{
    int n = utf8_tounicode(str, c);
    /* Should this be utf8_str_dispwidth(str, n) instead? */
    *dispwidth = utf8_dispwidth(*c);
    return utf8_char_bytes(str, n);
}

UTF8_STATIC int utf8_str_dispwidth(const char *str)
{
    int width = 0;
    while (*str) {
        int w;
        int c;
        int n = utf8_inspect(str, &c, &w);
        width += w;
        str += n;
    }
    return width;
}

/* Note: The following functions were taken largely as-is from
 * https://github.com/antirez/linenoise.git
 */
static int utf8_is_variation_selector(int cp)
{
    return cp == 0xFE0E || cp == 0xFE0F;  /* Text/emoji style */
}

/* Check if codepoint is a skin tone modifier. */
static int isSkinToneModifier(int cp)
{
    return cp >= 0x1F3FB && cp <= 0x1F3FF;
}

/* Check if codepoint is Zero Width Joiner. */
static int utf8_is_zero_width_joiner(int cp)
{
    return cp == 0x200D;
}

/* Check if codepoint is a Regional Indicator (for flag emoji). */
static int utf8_is_regional_indicator(int cp)
{
    return cp >= 0x1F1E6 && cp <= 0x1F1FF;
}

/* Check if codepoint is a combining mark or other zero-width character. */
static int utf8_is_combining_mark(int cp)
{
    return (cp >= 0x0300 && cp <= 0x036F) ||   /* Combining Diacriticals */
           (cp >= 0x1AB0 && cp <= 0x1AFF) ||   /* Combining Diacriticals Extended */
           (cp >= 0x1DC0 && cp <= 0x1DFF) ||   /* Combining Diacriticals Supplement */
           (cp >= 0x20D0 && cp <= 0x20FF) ||   /* Combining Diacriticals for Symbols */
           (cp >= 0xFE20 && cp <= 0xFE2F);     /* Combining Half Marks */
}

/* Check if codepoint extends the previous character (doesn't start a new grapheme). */
static int utf8_is_grapheme_extend(int cp)
{
    return utf8_is_variation_selector(cp) || isSkinToneModifier(cp) ||
           utf8_is_zero_width_joiner(cp) || utf8_is_combining_mark(cp);
}

/* Note: The following functions are based on code from
 * https://github.com/antirez/linenoise.git
 */
UTF8_STATIC int utf8_char_bytes(const char *str, int len)
{
    /* First we get the current character. Then we look ahead
     * to see if there are any combining characters that follow it, and if so we
     * treat them as part of the same "character".
     */
    int total = 0;

    int c;
    int n = utf8_tounicode(str, &c);
    total += n;
    str += n;

    if (len < 0) {
        len = strlen(str);
    }
    const char *end = str + len;
    int is_ri = utf8_is_regional_indicator(c);

    /* Consume any extending characters that follow. */
    while (str < end) {
        /* Check the next character. */
        n = utf8_tounicode(str, &c);

        if (utf8_is_zero_width_joiner(c) && str + n < end) {
            /* ZWJ: include it and the following character. */
            total += n;
            str += n;
            /* Get the character after ZWJ. */
            n = utf8_tounicode(str, &c);
            total += n;
            str += n;
            continue;  /* Check for more extending after the joined char. */
        } else if (utf8_is_grapheme_extend(c)) {
            /* Variation selector, skin tone, combining mark, etc. */
            total += n;
            str += n;
            continue;
        } else if (is_ri && utf8_is_regional_indicator(c)) {
            /* Second regional indicator for a flag pair. */
            total += n;
            str += n;
            is_ri = 0;  /* Only pair once. */
            continue;
        } else {
            break;
        }
    }

    return total;

}

/* Return the display width of a Unicode codepoint. This is a heuristic
 * that works for most common cases:
 * - Control chars and zero-width: 0 columns
 * - Grapheme-extending chars (VS, skin tone, ZWJ): 0 columns
 * - ASCII printable: 1 column
 * - Wide chars (CJK, emoji, fullwidth): 2 columns
 * - Everything else: 1 column
 *
 * This is not a full wcwidth() implementation, but a minimal heuristic
 * that handles emoji and CJK characters reasonably well. */
UTF8_STATIC int utf8_dispwidth(int cp)
{
    /* Control characters and combining marks: zero width. */
    if (cp < 32 || (cp >= 0x7F && cp < 0xA0)) {
        return 0;
    }
    if (utf8_is_combining_mark(cp)) {
        return 0;
    }

    /* Grapheme-extending characters: zero width.
     * These modify the preceding character rather than taking space. */
    if (utf8_is_variation_selector(cp) || utf8_is_combining_mark(cp) || utf8_is_grapheme_extend(cp)) {
        return 0;
    }

    /* Wide character ranges - these display as 2 columns:
     * - CJK Unified Ideographs and Extensions
     * - Fullwidth forms
     * - Various emoji ranges */
    if (cp >= 0x1100 &&
        (cp <= 0x115F ||                      /* Hangul Jamo */
         cp == 0x2329 || cp == 0x232A ||      /* Angle brackets */
         (cp >= 0x231A && cp <= 0x231B) ||    /* Watch, Hourglass */
         (cp >= 0x23E9 && cp <= 0x23F3) ||    /* Various symbols */
         (cp >= 0x23F8 && cp <= 0x23FA) ||    /* Various symbols */
         (cp >= 0x25AA && cp <= 0x25AB) ||    /* Small squares */
         (cp >= 0x25B6 && cp <= 0x25C0) ||    /* Play/reverse buttons */
         (cp >= 0x25FB && cp <= 0x25FE) ||    /* Squares */
         (cp >= 0x2600 && cp <= 0x26FF) ||    /* Misc Symbols (sun, cloud, etc) */
         (cp >= 0x2700 && cp <= 0x27BF) ||    /* Dingbats (❤, ✂, etc) */
         (cp >= 0x2934 && cp <= 0x2935) ||    /* Arrows */
         (cp >= 0x2B05 && cp <= 0x2B07) ||    /* Arrows */
         (cp >= 0x2B1B && cp <= 0x2B1C) ||    /* Squares */
         cp == 0x2B50 || cp == 0x2B55 ||      /* Star, circle */
         (cp >= 0x2E80 && cp <= 0xA4CF &&
          cp != 0x303F) ||                    /* CJK ... Yi */
         (cp >= 0xAC00 && cp <= 0xD7A3) ||    /* Hangul Syllables */
         (cp >= 0xF900 && cp <= 0xFAFF) ||    /* CJK Compatibility Ideographs */
         (cp >= 0xFE10 && cp <= 0xFE1F) ||    /* Vertical forms */
         (cp >= 0xFE30 && cp <= 0xFE6F) ||    /* CJK Compatibility Forms */
         (cp >= 0xFF00 && cp <= 0xFF60) ||    /* Fullwidth Forms */
         (cp >= 0xFFE0 && cp <= 0xFFE6) ||    /* Fullwidth Signs */
         (cp >= 0x1F1E6 && cp <= 0x1F1FF) ||  /* Regional Indicators (flags) */
         (cp >= 0x1F300 && cp <= 0x1F64F) ||  /* Misc Symbols and Emoticons */
         (cp >= 0x1F680 && cp <= 0x1F6FF) ||  /* Transport and Map Symbols */
         (cp >= 0x1F900 && cp <= 0x1F9FF) ||  /* Supplemental Symbols */
         (cp >= 0x1FA00 && cp <= 0x1FAFF) ||  /* Chess, Extended-A */
         (cp >= 0x20000 && cp <= 0x2FFFF)))   /* CJK Extension B and beyond */
        return 2;

    return 1; /* Default: single width */
}

#endif
