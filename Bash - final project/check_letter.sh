#!/bin/bash

# Funkcja do sprawdzania, czy litera znajduje się w haśle
check_letter() {
    local letter=$(echo "$1" | tr '[:upper:]' '[:lower:]')
    local word=$(echo "$2" | tr '[:upper:]' '[:lower:]')

    if [[ "$word" == *"$letter"* ]]; then
        echo "true"
    else
        echo "false"
    fi
}
