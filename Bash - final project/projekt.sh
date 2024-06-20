#!/bin/bash

# Ustawienie domyślnej ścieżki dla bibliotek, jeśli nie jest ustawiona
: ${BASH_LIBS_PATH:="$(dirname "$0")"}

# Załadowanie biblioteki do rysowania wisielca
source "$BASH_LIBS_PATH/draw_hangman.sh"

# Załadowanie biblioteki do sprawdzania liter w haśle
source "$BASH_LIBS_PATH/check_letter.sh"

# Załadowanie biblioteki do maskowania hasła
source "$BASH_LIBS_PATH/mask_word.sh"

# Załadowanie biblioteki do pobierania losowego hasła
source "$BASH_LIBS_PATH/get_random_word.sh"

# Załadowanie biblioteki do wyświetlania pomocy
source "$BASH_LIBS_PATH/display_help.sh"

# Załadowanie biblioteki do dodawania słów
source "$BASH_LIBS_PATH/add_word.sh"

# Inicjalizacja gry
while getopts ":ha" opt; do
    case ${opt} in
        h)
            display_help
            ;;
        a)
            add_word
            exit 0
            ;;
        \?)
            echo "Błędna opcja: -$OPTARG" >&2
            exit 1
            ;;
    esac
done

hangman_word=$(get_random_word)

# Konwersja hasła do odgadnięcia na małe litery
hangman_word=$(echo "$hangman_word" | tr '[:upper:]' '[:lower:]')

guessed_letters=""
attempts=0
max_attempts=10

echo "Witaj w grze Wisielec!"
echo "Odgadnij hasło."


# Pętla gry
while true; do
    masked=$(mask_word "$hangman_word" "$guessed_letters")
    echo -e "\nHasło: $masked"
    echo "Odgadnięte litery: $guessed_letters"
    echo "Pozostałe próby: $((max_attempts - attempts))"

    if [ "$masked" == "$hangman_word" ]; then
        echo -e "\nGratulacje! Odgadłeś hasło: $hangman_word"
        break
    fi

    read -p "Podaj literę lub całe hasło: " guess

    # Konwersja wprowadzonego hasła na małe litery
    guess=$(echo "$guess" | tr '[:upper:]' '[:lower:]')

    # Sprawdzenie, czy wprowadzona wartość jest literą lub całe hasło
    if [[ ! $guess =~ ^[[:alpha:]]+$ ]]; then
        echo "Podaj pojedynczą literę lub całe hasło."
        continue
    fi

    # Sprawdzenie, czy całe hasło zostało odgadnięte
    if [[ "$guess" == "$hangman_word" ]]; then
        echo -e "\nGratulacje! Odgadłeś hasło: $hangman_word"
        break
    fi

    # Sprawdzenie, czy litera lub hasło zostały już odgadnięte
    if [[ $guessed_letters == *"$guess"* ]]; then
        echo "Ta litera lub hasło już została odgadnięta."
        continue
    fi

    guessed_letters+="$guess"

    # Sprawdzenie, czy litera znajduje się w haśle
    if [ "$(check_letter "$guess" "$hangman_word")" == "false" ]; then
        attempts=$((attempts + 1))
        draw_hangman $attempts

        if [ $attempts -eq $max_attempts ]; then
            echo -e "\nPrzegrana! Hasło to: $hangman_word"
            break
        fi
    fi
done
