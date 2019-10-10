
/**
 * C preprocessor
 * Copyright: 2013 by Digital Mars
 * License: $(LINK2 http://boost.org/LICENSE_1_0.txt, Boost License 1.0).
 * Authors: Walter Bright
 */

module external.warp.constexpr;

import std.stdio;

import external.warp.omain;
import external.warp.lexer;
import external.warp.id;

/*****************************
 * Evaluate constant expressions for a boolean result.
 */

bool constantExpression(Lexer)(ref Lexer r)
{
    auto i = Comma(r);
    return i.value != 0;
}

private:

PPnumber Primary(Lexer)(ref Lexer r)
{

    // This line only works with 2.064 and later
    //enum bool isContext = __traits(compiles, r.src.expanded);

    // Use for 2.063 and later
    enum bool isContext = is(typeof(r.src.expanded));

    switch (r.front)
    {
        case TOK.identifier:
            if (r.idbuf[] == "defined")
            {
                bool sawParen;

                if (isContext)
                {
                    r.popFrontNoExpand();
                    if (r.front == TOK.lparen)
                    {
                        sawParen = true;
                        r.popFrontNoExpand();
                    }
                    if (r.front != TOK.identifier)
                    {
                        err_fatal("identifier expected after 'defined'");
                    }
                    else
                    {
                        PPnumber i;
                        auto m = Id.search(cast(ustring)r.idbuf[]);
                        if (m && m.flags & Id.IDmacro)
                        {
                            //writefln("defined(%s)", cast(string)m.name);
                            i.value = 1;
                        }
                        r.popFrontNoExpand();
                        if (sawParen)
                        {
                            if (r.front != TOK.rparen)
                                err_fatal("')' expected");
                            r.popFrontNoExpand();
                        }
                        return i;
                    }
                }
                else
                {
                    r.popFront();
                    if (r.front == TOK.lparen)
                    {
                        sawParen = true;
                        r.popFront();
                    }
                    if (r.front != TOK.identifier)
                    {
                        err_fatal("identifier expected after 'defined'");
                    }
                    else
                    {
                        PPnumber i;
                        r.popFront();
                        if (sawParen)
                        {
                            if (r.front != TOK.rparen)
                                err_fatal("')' expected");
                            r.popFront();
                        }
                        return i;
                    }
                }

            }
            break;

        case TOK.integer:
        {
            auto i = r.number;
            r.popFront();
            return i;
        }

        default:
            err_fatal("primary expression expected, not %s", r.front);
            break;
    }
    r.popFront();
    PPnumber n;
    return n;          // i.e. return signed 0
}

unittest
{
  {
    auto s = cast(immutable(ubyte)[])(" 100u \n");
    auto lexer = createLexer(s);
    assert(!lexer.empty);
    auto n = lexer.Primary();
    assert(n.value == 100);
    assert(n.isunsigned == true);
  }
  {
    auto s = cast(immutable(ubyte)[])(" abc \n");
    auto lexer = createLexer(s);
    assert(!lexer.empty);
    auto n = lexer.Primary();
    assert(n.value == 0);
    assert(n.isunsigned == false);
  }
}

PPnumber Unary(Lexer)(ref Lexer r)
{
    switch (r.front)
    {
        case TOK.plus:
            r.popFront();
            return Unary(r);

        case TOK.minus:
        {
            r.popFront();
            auto i = Unary(r);
            i.value = -i.value;
            return i;
        }

        case TOK.not:
        {
            r.popFront();
            auto i = Unary(r);
            i.value = !i.value;
            i.isunsigned = false;
            return i;
        }

        case TOK.tilde:
        {
            r.popFront();
            auto i = Unary(r);
            i.value = ~i.value;
            return i;
        }

        case TOK.lparen:
        {
            r.popFront();
            auto i = Comma(r);
            if (r.front != TOK.rparen)
                err_fatal(") expected");
            r.popFront();
            return i;
        }

        default:
            return Primary(r);
    }
}

unittest
{
  {
    auto s = cast(immutable(ubyte)[])(" +-100u \n");
    auto lexer = createLexer(s);
    assert(!lexer.empty);
    auto n = lexer.Unary();
    assert(n.value == -100);
    assert(n.isunsigned == true);
  }
  {
    auto s = cast(immutable(ubyte)[])(" !100u \n");
    auto lexer = createLexer(s);
    assert(!lexer.empty);
    auto n = lexer.Unary();
    assert(n.value == 0);
    assert(n.isunsigned == false);
  }
  {
    auto s = cast(immutable(ubyte)[])(" ~0x234 \n");
    auto lexer = createLexer(s);
    assert(!lexer.empty);
    auto n = lexer.Unary();
    assert(n.value == ~0x234);
    assert(n.isunsigned == false);
  }
}

PPnumber Mul(Lexer)(ref Lexer r)
{
    auto i = Unary(r);
    while (1)
    {
        switch (r.front)
        {
            case TOK.mul:
                r.popFront();
                auto i2 = Unary(r);
                i.value = i.value * i2.value;
                i.isunsigned |= i2.isunsigned;
                continue;

            case TOK.div:
                r.popFront();
                auto i2 = Unary(r);
                if (i2.value)
                {
                    i.isunsigned |= i2.isunsigned;
                    if (i.isunsigned)
                        i.value /= cast(ppuint_t)i2.value;
                    else
                        i.value /= i2.value;
                }
                else
                    err_fatal("divide by zero");
                continue;

            case TOK.mod:
                r.popFront();
                auto i2 = Unary(r);
                if (i2.value)
                {
                    i.isunsigned |= i2.isunsigned;
                    if (i.isunsigned)
                        i.value %= cast(ppuint_t)i2.value;
                    else
                        i.value %= i2.value;
                }
                else
                    err_fatal("divide by zero");
                continue;

             default:
                break;
        }
        break;
    }
    return i;
}

unittest
{
  {
    auto s = cast(immutable(ubyte)[])(" 2*100*100u \n");
    auto lexer = createLexer(s);
    assert(!lexer.empty);
    auto n = lexer.Mul();
    assert(n.value == 20000);
    assert(n.isunsigned == true);
  }
  {
    auto s = cast(immutable(ubyte)[])(" 200/-10/3u \n");
    auto lexer = createLexer(s);
    assert(!lexer.empty);
    auto n = lexer.Mul();
    assert(n.value == 200L/-10L/3uL);
    assert(n.isunsigned == true);
  }
  {
    auto s = cast(immutable(ubyte)[])(" 200%-10%3u \n");
    auto lexer = createLexer(s);
    assert(!lexer.empty);
    auto n = lexer.Mul();
    assert(n.value == 200L%-10L%3uL);
    assert(n.isunsigned == true);
  }
}

PPnumber Add(Lexer)(ref Lexer r)
{
    auto i = Mul(r);
    while (1)
    {
        switch (r.front)
        {
            case TOK.plus:
                r.popFront();
                auto i2 = Mul(r);
                i.value = i.value + i2.value;
                i.isunsigned |= i2.isunsigned;
                continue;

            case TOK.minus:
                r.popFront();
                auto i2 = Mul(r);
                i.value = i.value - i2.value;
                i.isunsigned |= i2.isunsigned;
                continue;

             default:
                break;
        }
        break;
    }
    return i;
}

unittest
{
  {
    auto s = cast(immutable(ubyte)[])(" 200+-10+3u \n");
    auto lexer = createLexer(s);
    assert(!lexer.empty);
    auto n = lexer.Add();
    assert(n.value == 200L+-10L+3uL);
    assert(n.isunsigned == true);
  }
  {
    auto s = cast(immutable(ubyte)[])(" 200- -10-3u \n");
    auto lexer = createLexer(s);
    assert(!lexer.empty);
    auto n = lexer.Add();
    assert(n.value == 200L- -10L-3uL);
    assert(n.isunsigned == true);
  }
}


PPnumber Shift(Lexer)(ref Lexer r)
{
    auto i = Add(r);
    while (1)
    {
        switch (r.front)
        {
            case TOK.shl:
                r.popFront();
                auto i2 = Add(r);
                i.value = i.value << i2.value;
                continue;

            case TOK.shr:
                r.popFront();
                auto i2 = Add(r);
                if (i.isunsigned)
                    i.value = cast(ppuint_t)i.value >> i2.value;
                else
                    i.value = i.value >> i2.value;
                continue;

             default:
                break;
        }
        break;
    }
    return i;
}

unittest
{
  {
    auto s = cast(immutable(ubyte)[])(" 200<< 10<<3u \n");
    auto lexer = createLexer(s);
    assert(!lexer.empty);
    auto n = lexer.Shift();
    assert(n.value == 200L<< 10L<<3uL);
    assert(n.isunsigned == false);
  }
  {
    auto s = cast(immutable(ubyte)[])(" 200>>10u>>3 \n");
    auto lexer = createLexer(s);
    assert(!lexer.empty);
    auto n = lexer.Shift();
    assert(n.value == 200L>>10Lu>>3L);
    assert(n.isunsigned == false);
  }
  {
    auto s = cast(immutable(ubyte)[])(" 200u>>10 \n");
    auto lexer = createLexer(s);
    assert(!lexer.empty);
    auto n = lexer.Shift();
    assert(n.value == 200Lu>>10L);
    assert(n.isunsigned == true);
  }
}



PPnumber Cmp(Lexer)(ref Lexer r)
{
    auto i = Shift(r);
    while (1)
    {
        switch (r.front)
        {
            case TOK.le:
                r.popFront();
                auto i2 = Shift(r);
                if (i.isunsigned || i2.isunsigned)
                    i.value = i.value <= cast(ppuint_t)i2.value;
                else
                    i.value = i.value <= i2.value;
                i.isunsigned = false;
                continue;

            case TOK.lt:
                r.popFront();
                auto i2 = Shift(r);
                if (i.isunsigned || i2.isunsigned)
                    i.value = i.value < cast(ppuint_t)i2.value;
                else
                    i.value = i.value < i2.value;
                i.isunsigned = false;
                continue;

            case TOK.ge:
                r.popFront();
                auto i2 = Shift(r);
                if (i.isunsigned || i2.isunsigned)
                    i.value = i.value >= cast(ppuint_t)i2.value;
                else
                    i.value = i.value >= i2.value;
                i.isunsigned = false;
                continue;

            case TOK.gt:
                r.popFront();
                auto i2 = Shift(r);
                if (i.isunsigned || i2.isunsigned)
                    i.value = i.value > cast(ppuint_t)i2.value;
                else
                    i.value = i.value > i2.value;
                i.isunsigned = false;
                continue;

             default:
                break;
        }
        break;
    }
    return i;
}

unittest
{
  {
    auto s = cast(immutable(ubyte)[])(" 200<=3 \n");
    auto lexer = createLexer(s);
    assert(!lexer.empty);
    auto n = lexer.Cmp();
    assert(n.value == (200L<=3L));
    assert(n.isunsigned == false);
  }
  {
    auto s = cast(immutable(ubyte)[])(" -200u<=3 \n");
    auto lexer = createLexer(s);
    assert(!lexer.empty);
    auto n = lexer.Cmp();
    assert(n.value == (-200uL<=3L));
    assert(n.isunsigned == false);
  }
  {
    auto s = cast(immutable(ubyte)[])(" 200<3 \n");
    auto lexer = createLexer(s);
    assert(!lexer.empty);
    auto n = lexer.Cmp();
    assert(n.value == (200L<3L));
    assert(n.isunsigned == false);
  }
  {
    auto s = cast(immutable(ubyte)[])(" -200u<3 \n");
    auto lexer = createLexer(s);
    assert(!lexer.empty);
    auto n = lexer.Cmp();
    assert(n.value == (-200uL<3L));
    assert(n.isunsigned == false);
  }
  {
    auto s = cast(immutable(ubyte)[])(" 200>=3 \n");
    auto lexer = createLexer(s);
    assert(!lexer.empty);
    auto n = lexer.Cmp();
    assert(n.value == (200L>=3L));
    assert(n.isunsigned == false);
  }
  {
    auto s = cast(immutable(ubyte)[])(" -200u>=3 \n");
    auto lexer = createLexer(s);
    assert(!lexer.empty);
    auto n = lexer.Cmp();
    assert(n.value == (-200uL>=3L));
    assert(n.isunsigned == false);
  }
  {
    auto s = cast(immutable(ubyte)[])(" 200>3 \n");
    auto lexer = createLexer(s);
    assert(!lexer.empty);
    auto n = lexer.Cmp();
    assert(n.value == (200L>3L));
    assert(n.isunsigned == false);
  }
  {
    auto s = cast(immutable(ubyte)[])(" -200u>3 \n");
    auto lexer = createLexer(s);
    assert(!lexer.empty);
    auto n = lexer.Cmp();
    assert(n.value == (-200uL>3L));
    assert(n.isunsigned == false);
  }
}

PPnumber Equal(Lexer)(ref Lexer r)
{
    auto i = Cmp(r);
    while (1)
    {
        switch (r.front)
        {
            case TOK.equal:
                r.popFront();
                auto i2 = Cmp(r);
                i.value = i.value == i2.value;
                i.isunsigned = false;
                continue;

            case TOK.notequal:
                r.popFront();
                auto i2 = Cmp(r);
                i.value = i.value != i2.value;
                i.isunsigned = false;
                continue;

             default:
                break;
        }
        break;
    }
    return i;
}

unittest
{
  {
    auto s = cast(immutable(ubyte)[])(" 200==3 \n");
    auto lexer = createLexer(s);
    assert(!lexer.empty);
    auto n = lexer.Equal();
    assert(n.value == (200L==3L));
    assert(n.isunsigned == false);
  }
  {
    auto s = cast(immutable(ubyte)[])(" -200u!=3 \n");
    auto lexer = createLexer(s);
    assert(!lexer.empty);
    auto n = lexer.Equal();
    assert(n.value == (-200uL!=3L));
    assert(n.isunsigned == false);
  }
}

PPnumber And(Lexer)(ref Lexer r)
{
    auto i = Equal(r);
    while (r.front == TOK.and)
    {
        r.popFront();
        auto i2 = Equal(r);
        i.value &= i2.value;
        i.isunsigned |= i2.isunsigned;
    }
    return i;
}

unittest
{
  {
    auto s = cast(immutable(ubyte)[])(" 200 & 3u \n");
    auto lexer = createLexer(s);
    assert(!lexer.empty);
    auto n = lexer.And();
    assert(n.value == (200L & 3uL));
    assert(n.isunsigned == true);
  }
}

PPnumber Xor(Lexer)(ref Lexer r)
{
    auto i = And(r);
    while (r.front == TOK.xor)
    {
        r.popFront();
        auto i2 = And(r);
        i.value ^= i2.value;
        i.isunsigned |= i2.isunsigned;
    }
    return i;
}

unittest
{
  {
    auto s = cast(immutable(ubyte)[])(" 200 ^ 3 \n");
    auto lexer = createLexer(s);
    assert(!lexer.empty);
    auto n = lexer.Xor();
    assert(n.value == (200L ^ 3L));
    assert(n.isunsigned == false);
  }
}


PPnumber Or(Lexer)(ref Lexer r)
{
    auto i = Xor(r);
    while (r.front == TOK.or)
    {
        r.popFront();
        auto i2 = Xor(r);
        i.value |= i2.value;
        i.isunsigned |= i2.isunsigned;
    }
    return i;
}

unittest
{
  {
    auto s = cast(immutable(ubyte)[])(" 200 | 3u | 8 \n");
    auto lexer = createLexer(s);
    assert(!lexer.empty);
    auto n = lexer.Or();
    assert(n.value == (200L | 3uL | 8L));
    assert(n.isunsigned == true);
  }
}


PPnumber AndAnd(Lexer)(ref Lexer r)
{
    auto i = Or(r);
    while (r.front == TOK.andand)
    {
        r.popFront();
        auto i2 = Or(r);
        i.value = i.value && i2.value;
        i.isunsigned = false;
    }
    return i;
}

unittest
{
  {
    auto s = cast(immutable(ubyte)[])(" 200 && 3u && 8 \n");
    auto lexer = createLexer(s);
    assert(!lexer.empty);
    auto n = lexer.AndAnd();
    assert(n.value == (200L && 3uL && 8L));
    assert(n.isunsigned == false);
  }
}


PPnumber OrOr(Lexer)(ref Lexer r)
{
    auto i = AndAnd(r);
    while (r.front == TOK.oror)
    {
        r.popFront();
        auto i2 = AndAnd(r);
        i.value = i.value || i2.value;
        i.isunsigned = false;
    }
    return i;
}

unittest
{
  {
    auto s = cast(immutable(ubyte)[])(" 200 || 3u || 8 \n");
    auto lexer = createLexer(s);
    assert(!lexer.empty);
    auto n = lexer.OrOr();
    assert(n.value == (200L || 3uL || 8L));
    assert(n.isunsigned == false);
  }
}


PPnumber Cond(Lexer)(ref Lexer r)
{
    auto i = OrOr(r);
    if (r.front == TOK.question)
    {
        r.popFront();
        auto i1 = Comma(r);
        if (r.front != TOK.colon)
            err_fatal(": expected");
        r.popFront();
        auto i2 = Cond(r);
        i.value = i.value ? i1.value : i2.value;
        i.isunsigned = i1.isunsigned | i2.isunsigned;
        return i;
    }
    return i;
}

unittest
{
  {
    auto s = cast(immutable(ubyte)[])(" 1 ? 2,3 : 4u \n");
    auto lexer = createLexer(s);
    assert(!lexer.empty);
    auto n = lexer.Cond();
    assert(n.value == (1L ? 2L,3L : 4Lu));
    assert(n.isunsigned == true);
  }
}



PPnumber Comma(Lexer)(ref Lexer r)
{
    auto i = Cond(r);
    while (r.front == TOK.comma)
    {
        r.popFront();
        i = Cond(r);
    }
    return i;
}


unittest
{
  {
    auto s = cast(immutable(ubyte)[])(" 1 + 3 - 4 \n");
    auto lexer = createLexer(s);
    assert(!lexer.empty);
    auto n = lexer.constantExpression();
    assert(n == !!(1L + 3L -4L));
  }
}



