>> append

>> append - :binary < :binary :binary
[+] passed!
[+] passed!

>> append - :binary < :binary (literal) :binary
[+] passed!
[+] passed!

>> append - :binary < :binary :integer
[+] passed!
[+] passed!

>> append - :binary < :binary (literal) :integer
[+] passed!
[+] passed!

>> append - :string < :string + :string
[+] passed!
[+] passed!

>> append - :string < :string (literal) + :string
[+] passed!
[+] passed!

>> append - :string < :string (pathLiteral) + :string
[+] passed!

>> append - :string < :string + :char
[+] passed!
[+] passed!

>> append - :string < :string (literal) + :char
[+] passed!
[+] passed!

>> append - :string < :char + :char
[+] passed!
[+] passed!

>> append - :string < :char (literal) + :char
[+] passed!
[+] passed!

>> append - :string < :char + :string
[+] passed!
[+] passed!

>> append - :string < :char (literal) + :string
[+] passed!
[+] passed!

>> append - [:string] < [:string] + :string
[+] passed!
[+] passed!
[+] passed!
[+] passed!

>> append - [:string] < [:string] (literal) + :string
[+] passed!
[+] passed!
[+] passed!
[+] passed!

>> append - [:string] < [:string] + :string - testing precedence
[+] passed!
[+] passed!

>> append - :block < :block + :block
[+] passed!
[+] passed!

>> append - :block < :block (literal) + :block
[+] passed!
[+] passed!

>> chop - :string < :string :string
[+] passed!
[+] passed!

>> chop.times - :string < :string :string
[+] passed!

>> chop - :string < :string (literal) :string
[+] passed!
[+] passed!

>> chop - :string < :string (pathLiteral) :string
[+] passed!

>> chop.times - :string < :string (literal) :string
[+] passed!

>> chop - :block < :block :block
[+] passed!
[+] passed!

>> chop.times - :block < :block :block
[+] passed!

>> chop - :block < :block (literal) :block
[+] passed!
[+] passed!

>> chop.times - :block < :block (literal) :block
[+] passed!

>> combine - .count - .repeat - .by
[+] passed!
[+] passed!
[+] passed!
[+] passed!
[+] passed!
[+] passed!

>> contains? - :string
[+] passed!
[+] passed!
[+] passed!
[+] passed!
[+] passed!
[+] passed!

>> contains? - :block
[+] passed!
[+] passed!
[+] passed!
[+] passed!

>> contains? - with nested :block
[+] passed!
[+] passed!
[+] passed!
[+] passed!

>> contains? - with :range
[+] passed!
[+] passed!
[+] passed!
[+] passed!
[+] passed!
[+] passed!

>> contains? - with :dictionary
[+] passed!
[+] passed!
[+] passed!
[+] passed!
[+] passed!
[+] passed!
[+] passed!
[+] passed!

>> contains?.deep - with :block
[+] passed!
[+] passed!

>> contains?.deep - with :dictionary
[+] passed!
[+] passed!

>> couple
[+] passed!

>> decouple
[+] passed!
[+] passed!
[+] passed!

>> drop - :string < :string :string
[+] passed!
[+] passed!
[+] passed!
[+] passed!
[+] passed!
[+] passed!

>> drop - :string < :string (literal) :string
[+] passed!
[+] passed!
[+] passed!
[+] passed!
[+] passed!
[+] passed!

>> drop - :string < :string (pathLiteral) :string
[+] passed!

>> drop - :block < :block :block
[+] passed!
[+] passed!
[+] passed!
[+] passed!
[+] passed!
[+] passed!

>> drop - :block < :block (literal) :block
[+] passed!
[+] passed!
[+] passed!
[+] passed!
[+] passed!
[+] passed!

>> empty - empty?
[+] passed!
[+] passed!
[+] passed!
[+] passed!
[+] passed!
[+] passed!

>> extend
[+] passed!

>> extend (literal)
[+] passed!

>> extend (pathLiteral)
[+] passed!

>> first - .n
[+] passed!
[+] passed!
[+] passed!
[+] passed!
[+] passed!
[+] passed!
[+] passed!
[+] passed!
[+] passed!
[+] passed!
[+] passed!
[+] passed!
[+] passed!
[+] passed!
[+] passed!

>> flatten
[+] passed!
[+] passed!
[+] passed!

>> flatten.once
[+] passed!
[+] passed!

>> get - :string
[+] passed!
[+] passed!
[+] passed!
[+] passed!
[+] passed!

>> get - :date
[+] passed!
[+] passed!

>> get - :binary
[+] passed!

>> get - :dictionary
[+] passed!
[+] passed!
[+] passed!
[+] passed!
[+] passed!

>> get - :object
[+] passed!
[+] passed!
[+] passed!
[+] passed!

>> get - :store
[+] passed!
[+] passed!
[+] passed!
[+] passed!

>> get - :block
[+] passed!
[+] passed!
[+] passed!

>> get - :range
[+] passed!
[+] passed!

>> get - :bytecode
[+] passed!
[+] passed!
[+] passed!
[+] passed!

>> get - :complex
[+] passed!
[+] passed!
[+] passed!
[+] passed!
[+] passed!
[+] passed!
[+] passed!
[+] passed!
[+] passed!
[+] passed!

>> in? - :string
[+] passed!
[+] passed!
[+] passed!
[+] passed!
[+] passed!
[+] passed!

>> in? - :block
[+] passed!
[+] passed!
[+] passed!
[+] passed!

>> in? - with nested :block
[+] passed!
[+] passed!
[+] passed!
[+] passed!

>> in? - with :range
[+] passed!
[+] passed!
[+] passed!
[+] passed!
[+] passed!
[+] passed!

>> in? - with :dictionary
[+] passed!
[+] passed!
[+] passed!
[+] passed!
[+] passed!
[+] passed!
[+] passed!
[+] passed!

>> in?.deep - with :block
[+] passed!
[+] passed!

>> in?.deep - with :dictionary
[+] passed!
[+] passed!

>> index - :string
[+] passed!
[+] passed!

>> index - :dictionary
[+] passed!
[+] passed!

>> index - :block
[+] passed!
[+] passed!
[+] passed!

>> index - :range
[+] passed!
[+] passed!

>> insert - :string
[+] passed!
[+] passed!

>> insert - :string (literal)
[+] passed!
[+] passed!

>> insert - :string (pathLiteral)
[+] passed!

>> get - :dictionary
[+] passed!

>> get - :dictionary (literal)
[+] passed!

>> get - :block
[+] passed!

>> get - :block (literal)
[+] passed!

>> key? - :dictionary
[+] passed!
[+] passed!
[+] passed!

>> key? - :object
[+] passed!
[+] passed!
[+] passed!

>> keys - :dictionary
[+] passed!

>> keys - :object
[+] passed!

>> last - .n
[+] passed!
[+] passed!
[+] passed!
[+] passed!
[+] passed!
[+] passed!
[+] passed!
[+] passed!
[+] passed!
[+] passed!
[+] passed!
[+] passed!
[+] passed!
[+] passed!
[+] passed!
[+] passed!
[+] passed!

>> max - [:integer] - .index
[+] passed!
[+] passed!

>> max - [:string] - .index
[+] passed!
[+] passed!

>> max - [:literal] - .index
[+] passed!
[+] passed!

>> max - :range - .index
[+] passed!
[+] passed!

>> min - [:integer] - .index
[+] passed!
[+] passed!

>> min - [:string] - .index
[+] passed!
[+] passed!

>> min - [:literal] - .index
[+] passed!
[+] passed!

>> min - :range - .index
[+] passed!
[+] passed!

>> one?
[+] passed!
[+] passed!
[+] passed!
[+] passed!
[+] passed!
[+] passed!
[+] passed!

>> permutate
[+] passed!
[+] passed!
[+] passed!
[+] passed!
[+] passed!
[+] passed!
[+] passed!
[+] passed!

>> pop

>> pop - :block .n
[+] passed!
[+] passed!

>> pop - :string .n
[+] passed!
[+] passed!

>> pop - pathLiteral
[+] passed!

>> prepend

>> prepend - :binary < :binary :binary
[+] passed!

>> prepend - :binary < :binary (literal) :binary
[+] passed!

>> prepend - :binary < :binary :integer
[+] passed!

>> prepend - :binary < :binary (literal) :integer
[+] passed!

>> prepend - :string < :string + :string
[+] passed!

>> prepend - :string < :string (literal) + :string
[+] passed!

>> prepend - :string < :string + :char
[+] passed!

>> prepend - :string < :string (literal) + :char
[+] passed!

>> prepend - :string < :char + :char
[+] passed!

>> prepend - :string < :char (literal) + :char
[+] passed!

>> prepend - :string < :char + :string
[+] passed!

>> prepend - :string < :char (literal) + :string
[+] passed!

>> prepend - [:string] < [:string] + :string
[+] passed!
[+] passed!

>> prepend - [:string] < [:string] (literal) + :string
[+] passed!
[+] passed!

>> prepend - [:string] < [:string] (pathLiteral) + :string
[+] passed!

>> prepend - [:string] < [:string] + :string - testing precedence
[+] passed!

>> prepend - :block < :block + :block
[+] passed!

>> prepend - :block < :block (literal) + :block
[+] passed!

>> remove - :string
[+] passed!
[+] passed!
[+] passed!
[+] passed!
[+] passed!

>> remove - :string (literal)
[+] passed!
[+] passed!
[+] passed!
[+] passed!
[+] passed!

>> remove - :string (pathLiteral)
[+] passed!

>> remove - :dictionary
[+] passed!
[+] passed!

>> remove - :dictionary (literal)
[+] passed!
[+] passed!

>> remove - :dictionary (pathLiteral)
[+] passed!

>> remove - :block
[+] passed!
[+] passed!
[+] passed!
[+] passed!
[+] passed!

>> remove - :block (literal)
[+] passed!
[+] passed!
[+] passed!
[+] passed!
[+] passed!

>> remove - :block (pathLiteral)
[+] passed!

>> repeat
[+] passed!
[+] passed!
[+] passed!

>> repeat (literal)
[+] passed!
[+] passed!
[+] passed!

>> repeat (pathLiteral)
[+] passed!

>> reverse
[+] passed!
[+] passed!
[+] passed!
[+] passed!

>> reverse (literal)
[+] passed!
[+] passed!
[+] passed!
[+] passed!

>> reverse (pathLiteral)
[+] passed!

>> rotate
[+] passed!
[+] passed!

>> rotate
[+] passed!
[+] passed!

>> rotate - pathLiteral
[+] passed!

>> sample
[+] passed!
[+] passed!

>> set - :string
[+] passed!
[+] passed!
[+] passed!
[+] passed!
[+] passed!

>> set - :binary
[+] passed!
[+] passed!

>> set - :dictionary
[+] passed!
[+] passed!
[+] passed!
[+] passed!
[+] passed!
[+] passed!

>> set - :object
[+] passed!
[+] passed!
[+] passed!
[+] passed!
[+] passed!
[+] passed!

>> set - :store
[+] passed!
[+] passed!
[+] passed!
[+] passed!
[+] passed!
[+] passed!
[+] passed!
[+] passed!
[+] passed!

>> set - :block
[+] passed!
[+] passed!

>> set - :bytecode

>> shuffle
[+] passed!
[+] passed!

>> size
[+] passed!
[+] passed!
[+] passed!
[+] passed!
[+] passed!
[+] passed!

>> slice
[+] passed!
[+] passed!

>> slice - (literal)
[+] passed!
[+] passed!

>> slice - (pathLiteral)
[+] passed!

>> sort - + .descending
[+] passed!
[+] passed!
[+] passed!
[+] passed!
[+] passed!
[+] passed!
[+] passed!
[+] passed!
[+] passed!
[+] passed!

>> sort - + .descending (literal)
[+] passed!
[+] passed!
[+] passed!
[+] passed!
[+] passed!
[+] passed!
[+] passed!
[+] passed!
[+] passed!
[+] passed!

>> sort - .values
[+] passed!
[+] passed!
[+] passed!
[+] passed!
[+] passed!
[+] passed!
[+] passed!
[+] passed!

>> sort - .values (literal)
[+] passed!
[+] passed!
[+] passed!
[+] passed!
[+] passed!
[+] passed!
[+] passed!
[+] passed!

>> sort - .values (pathLiteral)
[+] passed!
[+] passed!
[+] passed!
[+] passed!
[+] passed!
[+] passed!
[+] passed!

>> sort - .by

>> sorted?
[+] passed!
[+] passed!
[+] passed!
[+] passed!

>> split - + .every
[+] passed!
[+] passed!
[+] passed!
[+] passed!

>> split - + .every (literal)
[+] passed!
[+] passed!
[+] passed!
[+] passed!

>> split - + .every (pathLiteral)
[+] passed!

>> split - .words
[+] passed!
[+] passed!

>> split - .words (literal)
[+] passed!
[+] passed!

>> split - .words (pathLiteral)
[+] passed!

>> split - .lines
[+] passed!
[+] passed!

>> split - .lines (literal)
[+] passed!
[+] passed!

>> split - .lines (pathLiteral)
[+] passed!

>> split - .by
[+] passed!
[+] passed!
[+] passed!

>> split - .by (literal)
[+] passed!
[+] passed!
[+] passed!

>> split - .by (literal)
[+] passed!

>> split - .at
[+] passed!
[+] passed!

>> split - .at (literal)
[+] passed!
[+] passed!

>> split - .at (pathLiteral)
[+] passed!

>> split - .path
[+] passed!
[+] passed!

>> split - .path (literal)
[+] passed!
[+] passed!

>> split - .path (pathLiteral)

>> squeeze
[+] passed!
[+] passed!
[+] passed!

>> squeeze - (literal)
[+] passed!
[+] passed!
[+] passed!

>> squeeze - (pathLiteral)
[+] passed!
[+] passed!
[+] passed!

>> take - :string < :string :string
[+] passed!
[+] passed!
[+] passed!
[+] passed!
[+] passed!
[+] passed!

>> take - :string < :string (literal) :string
[+] passed!
[+] passed!
[+] passed!
[+] passed!
[+] passed!
[+] passed!

>> take - :string < :string (pathLiteral) :string
[+] passed!

>> take - :block < :block :block
[+] passed!
[+] passed!
[+] passed!
[+] passed!
[+] passed!
[+] passed!

>> take - :block < :block (literal) :block
[+] passed!
[+] passed!
[+] passed!
[+] passed!
[+] passed!
[+] passed!

>> take - :block < :block (pathLiteral) :block
[+] passed!

>> take - :range < :range :integer
[+] passed!
[+] passed!
[+] passed!
[+] passed!
[+] passed!
[+] passed!

>> take - :block < :range (literal) :integer
[+] passed!
[+] passed!
[+] passed!
[+] passed!
[+] passed!
[+] passed!

>> take - :block < :range (pathLiteral) :integer

>> tally
[+] passed!
[+] passed!

>> unique
[+] passed!
[+] passed!
[+] passed!

>> unique - literal
[+] passed!
[+] passed!
[+] passed!

>> unique - pathLiteral
1 2 4 3 
1 2 4 3 
[+] passed!
[+] passed!

>> values - :dictionary
[+] passed!

>> values - :object
[+] passed!

>> values - :block
[+] passed!

>> values - :range
[+] passed!
[+] passed!

>> zero?
[+] passed!
[+] passed!
[+] passed!
[+] passed!
[+] passed!
[+] passed!
[+] passed!