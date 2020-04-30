
Collection of research and resources about general MxN Sudoku puzzles:


https://board.flatassembler.net/topic.php?p=213787#213787

https://www.youtube.com/watch?v=G_UYXzGuqvM

18 Feb 2020 06:14 - recursive backtracking solver


23 Apr 2020 03:47

Here is a wolframscript (wls) general implementation using binary constraints. Presently, it solves 25x25 puzzles in a couple of seconds (single-threaded) - over 500k constraints.

Wolframscript will run on anything from a Rasberry PI to the cloud, and is free for personal use. If I create some larger puzzles I'll post them. There are many open problems in the sudoku puzzles.

What makes the binary constraint method so appealing is it's flexibility. Nice survey of sudoku variations and their adaptation to SAT solvers:
https://yurichev.com/writings/SAT_SMT_by_example.pdf



26 Apr 2020, 19:15

If my Swedish (code in Java) through Google translate is correct, this paper gives some hope that a higher-level technique could be advantageous, and also help to enumerate techniques used. The paper has a number of errors, but that doesn't mean it isn't useful. For example, the timing measurements don't have an equivalent basis: this can be seen in the constant time for DL algorithm - this would only happen if puzzles were exactly the same complexity, or DL algorithm was searching for all solutions. No other algorithm is searching for all solutions. Wink

So, the author misses that DL algorithm is actually faster than all other methods, and is equivalent to many of the high-level techniques.



28 Apr 2020, 18:10

It is unclear what you mean by number placement and unique. The puzzle has a great deal of symmetry, and repeated use of the following (base*) transformations can produce all equivalent variations. In that regard, there is no difference in placement. This also means there are no unique puzzles, per se.
Code:
;the permutations that leave sudoku unchanged are:
;       (a) rotate the grid 90 degrees
;       (b) swap the top two rows
;       (c) swap the top two bands
;       (d) swap any two cell values for all cells with those values    
*Base in that they are the most reduced form.

Most likely, you are saying that the problem complexity does not directly correlate to the number of clues. Which is absolutely correct. It's possible to construct a graph (DAG) of discovery mechanics needed to solve a puzzle and that graph can be unique within the (symmetry divided) problem space.



29 Apr 2020, 11:29

Herbert Kociemba, has already produced massive 400x400 grids by reverse engineering human-like solving methods. The best existing software for general sudoku solving (Delphi source code), imho.

Qiu Yanzhe, the 2017 bronze champion has commented on a sudoku forum regarding the minimum clues, demonstrating an algorithm that works generally. For the NxN grid, it producing solutions with Floor(N²/4) clues.

This more modern write-up suggests another avenue, using propositional logic to greatly reduce guessing. Adapting this method to the general problem seems like it would be advantageous.

