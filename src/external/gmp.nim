{.push warning[user]: off.}
when defined(USE_GMP_HEADER):
  include gmp/header
else:
  include gmp/pure
{.pop.}
