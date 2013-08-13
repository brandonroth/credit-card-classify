credit-card-classify
====================

A small utility to classify credit card types based on the number.

This utility builds a tree similar to huffman encoding and uses it to classify a credit card number.  It is able to classify a card, tell it doesn't know yet, or tell you it won't know with as few digits as possible.  This is usefull if you a incrementally inputing a card number and would like to be able to classify a card at the earliest possible moment, for example if you wanted to show a generic card logo before anything is typed and then switch to the actual logo as soon as you know.
