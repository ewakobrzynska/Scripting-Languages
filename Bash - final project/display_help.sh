#!/bin/bash

display_help() {
    echo "Gra w wisielca w Bash."
    echo "Odgadnij hasło, zanim wisielec zostanie narysowany."
    echo ""
    echo "Użycie: $0 [-h] [-a]"
    echo ""
    echo "Opcje:"
    echo "  -h  Wyświetl pomoc (to okno)"
    echo "  -a  Dodaj własne słowo do listy"
    echo ""
    echo "Gra polega na odgadnięciu losowo wybranego słowa spośród podanych w funkcji get_random_word()."
    echo "Gracz podaje litery, aby odgadnąć hasło. Za każdą błędną literę"
    echo "rysuje się kolejna część wisielca. Gracz ma 10 prób, aby odgadnąć hasło."
    echo ""
    echo "Hasło może zawierać tylko litery (bez znaków specjalnych) i może być zapisane zarówno wielkimi, jak i małymi literami."
    echo "Podczas wprowadzania liter do odgadywania, nie ma znaczenia ich wielkość."
    echo ""
    echo "Po zakończeniu gry zostanie wyświetlony wynik (wygrana/porażka)."
    exit 0
}
