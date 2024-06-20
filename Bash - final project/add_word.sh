#!/bin/bash

add_word() {
    local new_word
    read -p "Podaj nowe słowo: " new_word

    # Sprawdzenie, czy słowo zawiera tylko litery
    if [[ "$new_word" =~ ^[[:alpha:]]+$ ]]; then
        echo "$new_word" >> "words.txt"  # Dodaj słowo w nowej linii
        echo "Dodano nowe słowo: $new_word"
    else
        echo "Słowo nie może zawierać cyfr ani znaków specjalnych. Słowo nie zostało dodane."
    fi
}
