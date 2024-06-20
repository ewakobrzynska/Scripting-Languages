# ScriptingLanguages
---

<table>
  <tr>
    <td width="40%">
      <p align="center">
        <img src="./assets/bash.png" alt="Hangman Game - Bash" width="200"/>
      </p>
    </td>
    <td width="60%">
      The "hangman.sh" script is a simple hangman game written in Bash. The player's objective is to guess a randomly chosen word. Each time an incorrect letter is guessed, another part of the hangman is drawn. The player has a limited number of attempts (6) to guess the word.
    </td>
  </tr>
</table>


### Functions

1. **draw_hangman()**
   - Draws the hangman figure based on the number of incorrect attempts.
   - Arguments: `$1` - Number of incorrect attempts.

2. **check_letter()**
   - Checks if a given letter is in the chosen word.
   - Arguments: `$1` - Letter to check. `$2` - Chosen word.

3. **mask_word()**
   - Masks the chosen word with dashes for letters not yet guessed.
   - Arguments: `$1` - Chosen word. `$2` - Guessed letters.

4. **get_random_word()**
   - Returns a random word defined in the script.

5. **display_help()**
   - Displays usage help for the script.

### Initialization and Game Mechanics

The script initializes the game by analyzing options provided at launch. If the `-h` option is given, the `display_help()` function is called; otherwise, the game begins automatically.

The script runs within an infinite loop where the player inputs letters or attempts to guess the entire word. Each iteration updates information about the guessed word, used letters, and remaining attempts.

The game ends when the player correctly guesses the word or exceeds 6 incorrect attempts. Upon completion of the game (win or lose), the script displays an appropriate message and the guessed word.

### Usage

1. Run the script without any options:
   ```bash
   ./hangman.sh
   ```

2. Display help:
   ```bash
   ./hangman.sh -h
   ```

### Limitations

- The script assumes that words to be guessed are defined within the `get_random_word()` function.
- The game supports only lowercase and uppercase letters of the English alphabet.


