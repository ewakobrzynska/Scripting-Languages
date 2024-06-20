#!/usr/bin/env python3
import argparse
import sys
import pickle
from statki import *


class Game:
    def __init__(self, size=10, auto_place=False):
        self.size = size
        self.player_board = Board(size=self.size)
        self.computer_board = Board(hid=True, size=self.size)
        self.auto_place = auto_place
        player = Player(self.player_board, auto_place=self.auto_place)
        player.place_ships()
        computer = Player(self.computer_board, auto_place=True)
        computer.place_ships()

    def start(self):
        print("Rozpoczynamy grę!")
        while True:
            print("-" * 20)
            print("Plansza przeciwnika:")
            print(self.computer_board)
            print("Twoja plansza:")
            print(self.player_board)
            strzal_gracza = self.wykonajRuchGracza()
            if strzal_gracza and self.computer_board.count == 10:
                print("Wygrałeś!")
                break
            print("Ruch przeciwnika:")
            strzal_przeciwnika = self.wykonajRuchKomputera()
            if strzal_przeciwnika and self.player_board.count == 10:
                print("Przegrałeś!")
                break

    def wykonajRuchGracza(self):
        while True:
            cords = input(
                "Podaj współrzędne strzału (format: x y), lub wpisz 'q' aby zakończyć grę, 'save' aby zapisać grę: "
            )
            if cords == "q":
                print("Koniec gry.")
                sys.exit(0)
            elif cords == "save":
                self.zapiszGre()
                print("Gra została zapisana w domyślnej lokalizacji.")
                continue
            else:
                cords = cords.split()
                if len(cords) != 2:
                    print("Musisz podać 2 współrzędne: x y.")
                    continue
                x, y = cords
                if not (x.isdigit()) or not (y.isdigit()):
                    print("Współrzędne muszą być dodatnimi liczbami całkowitymi.")
                    continue
                x, y = int(x), int(y)
                if not (1 <= x <= self.player_board.size) or not (
                    1 <= y <= self.player_board.size
                ):
                    print("Współrzędne poza planszą. Wybierz inne.")
                    continue
                kratka = Coords(x - 1, y - 1)
                try:
                    if kratka in self.computer_board.shots:
                        raise BoardUsedException()
                    strzal = self.computer_board.strzel(kratka)
                    if strzal:
                        if self.computer_board.count == 10:
                            print("Wygrałeś!")
                            return True
                        return strzal
                    else:
                        return False
                except BoardUsedException:
                    print(
                        "Już strzeliłeś w to pole lub na tym polu statek nie może już wystąpić. Wybierz inne."
                    )

    def wykonajRuchKomputera(self):
        while True:
            x = randint(0, 9)
            y = randint(0, 9)
            cel = Coords(x, y)
            try:
                strzal = self.player_board.strzel(cel)
                if strzal and self.player_board.count == 10:
                    print("Przegrałeś!")
                    return False
                return strzal
            except BoardUsedException:
                continue
            except OutOfBoardException:
                continue

    def zapiszGre(self):
        with open("saved_game.pickle", "wb") as file:
            pickle.dump(self, file)


if __name__ == "__main__":
    parser = argparse.ArgumentParser(
        description="Gra w statki to klasyczna gra planszowa, w której dwóch graczy rywalizuje ze sobą, próbując zestrzelić wszystkie statki przeciwnika."
    )
    parser.add_argument(
        "-a", "--auto_place", action="store_true", help="Rozmieść statki automatycznie"
    )
    parser.add_argument("-r", "--rules", action="store_true", help="Wyświetl zasady gry")
    parser.add_argument(
        "-ls",
        "--load_saved",
        action="store_true",
        help="Wczytaj zapisany stan gry z pliku",
    )
    args = parser.parse_args()

    if args.rules:
        print("Zasady gry:")
        print(
            "1. Każdy gracz ma planszę o wymiarach 10x10 pól, na której rozmieszcza swoje statki."
        )
        print("2. Statki nie mogą dotykać się ani bokami, ani rogami.")
        print(
            "3. Gracze rozmieszczają swoje statki na planszy w sposób strategiczny, starając się ukryć je przed przeciwnikiem."
        )
        print(
            "4. Statki są reprezentowane przez połączone pola na planszy: czteromasztowiec, trójmasztowiec, dwumasztowiec i cztery jednomasztowce."
        )
        print("5. Gracze na zmianę wykonują strzały na planszy przeciwnika, wskazując współrzędne pola, które chcą trafic.")
        print(
            "6. Jeśli strzał trafi w statek przeciwnika, pole na planszy zostaje oznaczone jako trafione. W przeciwnym razie oznacza się je jako pudło."
        )
        print("7. Celem gry jest zestrzelenie wszystkich statków przeciwnika.")
        print(
            "8. Gra kończy się, gdy któryś z graczy zestrzeli wszystkie statki przeciwnika.print"
        )

        sys.exit()

    if args.load_saved:
        try:
            with open("saved_game.pickle", "rb") as file:
                game = pickle.load(file)
                game.start()
        except FileNotFoundError:
            print("Brak zapisanej gry.")
        sys.exit()

    game = Game(auto_place=args.auto_place)
    game.start()
