#!/bin/bash

# Funkcja do rysowania wisielca
draw_hangman() {
    case $1 in
        1)
            echo "        "
            echo "        "
            echo "        "
            echo "        "
            echo "        "
            echo "      /\\"
            echo "---------"
            ;;
        2)
            echo "        "
            echo "      ||"
            echo "      ||"
            echo "      ||"
            echo "      ||"
            echo "      /\\"
            echo "---------"
            ;;
        3)
            echo "  ------"
            echo "      ||"
            echo "      ||"
            echo "      ||"
            echo "      ||"
            echo "      /\\"
            echo "---------"
            ;;
        4)
            echo "  ------"
            echo "  |   ||"
            echo "      ||"
            echo "      ||"
            echo "      ||"
            echo "      /\\"
            echo "---------"
            ;;
        5)
            echo "  ------"
            echo "  |   ||"
            echo "  O   ||"
            echo "      ||"
            echo "      ||"
            echo "      /\\"
            echo "---------"
            ;;
        6)
            echo "  ------"
            echo "  |   ||"
            echo "  O   ||"
            echo "  |   ||"
            echo "      ||"
            echo "      /\\"
            echo "---------"
            ;;
        7)
            echo "  ------"
            echo "  |   ||"
            echo "  O   ||"
            echo " /|   ||"
            echo "      ||"
            echo "      /\\"
            echo "---------"
            ;;
        8)
            echo "  ------"
            echo "  |   ||"
            echo "  O   ||"
            echo " /|\  ||"
            echo "      ||"
            echo "      /\\"
            echo "---------"
            ;;
        9)
            echo "  ------"
            echo "  |   ||"
            echo "  O   ||"
            echo " /|\  ||"
            echo " /    ||"
            echo "      /\\"
            echo "---------"
            ;;
        10)
            echo "  ------"
            echo "  |   ||"
            echo "  O   ||"
            echo " /|\  ||"
            echo " / \  ||"
            echo "      /\\"
            echo "---------"
            ;;
    esac
}
