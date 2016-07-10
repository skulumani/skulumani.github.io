## Manage multiple python installs using Anaconda

conda info --envs 
conda create -n python2 python=2.7 anaconda
source activate python2

conda install ipython

list comprehension

[thing for thing in list_of_things]

## Crib dragging to break many time pad
1. Guess a word that might appear in one of the messages
2. Encode the word from step 1 to a ascii string
3. XOR the two cipher-text messages and encode as ascii
4. XOR the string from step 2 at each position of the XOR of the two cipher-texts (from step 3)
5. When the result from step 4 is readable text, we guess the English word and expand our crib search.
6. If the result is not readable text, we try an XOR of the crib word at the next position.