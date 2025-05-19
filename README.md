# mastermind
The game mastermind from the ODIN project

Pseudocode

1. Instantiate game --> set game parameters during instantiation
    a) Who is player (codebreaker)? game mode 1 or 2 (Computer or human player)
    b) current attempt count and total count
2. start play game --> call game play method
    a) Who is player (codebreaker)? game mode 1 or 2 (Computer or human player)
    b) Creator generate code
    c) Breaker guesses code
    d) Creator give feedback
    e) Keep doing c<->d 
    f) return if match or over attempt
