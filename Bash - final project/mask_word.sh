#!/bin/bash

# Funkcja do zamiany hasła na kreski zgodnie z odgadniętymi literami
mask_word() {
    local word=$1
    local guessed_letters=$2

    local masked_word=""
    for ((i = 0; i < ${#word}; i++)); do
        char="${word:$i:1}"
        if [[ $guessed_letters == *$char* ]]; then
            masked_word+="$char"
        else
            masked_word+="_"
        fi
    done

    echo "$masked_word"
}