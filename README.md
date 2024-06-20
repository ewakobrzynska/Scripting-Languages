# ScriptingLanguages
---

<table>
  <tr>
    <td width="40%">
      <p align="center">
        <img src="./assets/bash.png" alt="Hangman Game - Bash" width="180"/>
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

--

<table>
  <tr>
    <td width="40%">
      <p align="center">
        <img src="./assets/perl.png" alt="Task List Manager - Perl" width="180"/>
      </p>
    </td>
    <td width="60%">
      The Task List Manager is a simple command-line Perl script designed to assist users in managing their to-do tasks. It allows users to add new tasks, view the task list, mark tasks as completed, remove completed tasks, and exit the program. The script utilizes a configuration file and provides a basic menu-driven interface.
    </td>
  </tr>
</table>

### Features

1. **Configuration File**

   The script uses a configuration file (`.todolistrc`) to store user-defined settings. If the configuration file does not exist, the script creates it with default settings.
   
   Default Configuration:
   - Priorities: LOW, MEDIUM, HIGH
   - Date Format: %Y-%m-%d

2. **Task File**

   The task list is stored in a file named `todo.txt`. If the file does not exist, the script creates an empty one.

3. **Menu Interface**

   The script presents a menu-driven interface with the following options:
   - Add Task
     - Prompts the user to enter a new task description, set priority (LOW/MEDIUM/HIGH), and due date. Adds the task to the list.
   - View Tasks
     - Displays a numbered list of tasks.
   - Mark as Completed
     - Displays the task list and prompts the user to enter the task number to mark as completed.
     - Marks the selected task as completed.
   - Clear Completed
     - Removes all completed tasks from the list.
   - Exit
     - Quits the program.
   - Help (Options)
     - Displays a help menu explaining available options.

4. **Command-Line Options**

   The script supports command-line options:
   - `-h` or `--help`: Displays detailed help information.

### Usage

#### Running the Script

To run the script, use the following command:
```bash
perl todo.pl
```

#### Options

- `-h` or `--help`: Displays detailed help menu.

### Notes

- The script uses a simple text file (`todo.txt`) to store tasks, each formatted with a due date, priority, and description.
- Minimal input validation is performed, so users are expected to input information in the specified format.

--
