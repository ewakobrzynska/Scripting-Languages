#!/bin/bash

# Funkcja do pobierania losowego hasła
get_random_word() {
    local script_dir="$(dirname "$0")"
    local project_dir="$script_dir/../"
    local words_file="$script_dir/words.txt"

    if [ -f "$words_file" ]; then
        words_file="$script_dir/words.txt"
    elif [ -f "$project_dir/words.txt" ]; then
        words_file="$project_dir/words.txt"
    else
        echo "Plik words.txt nie został znaleziony."
        exit 1
    fi

    local words=()
    IFS=$'\n' read -d '' -r -a words < "$words_file"
    echo "${words[$((RANDOM % ${#words[@]}))]}"
}
