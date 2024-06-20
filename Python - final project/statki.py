#!/usr/bin/env python3

from random import randint
import argparse
import sys

class Coords:
    def __init__(self, x, y):
        self.x = x
        self.y = y

    def __eq__(self, other):
        return self.x == other.x and self.y == other.y

    def __repr__(self):
        return f"({self.x}, {self.y})"

    def __hash__(self):
        return hash((self.x, self.y))

class OutOfBoardException(Exception):
    pass

class BoardUsedException(Exception):
    pass

class BoardWrongShipException(Exception):
    pass

class Ship:
    def __init__(self, kratka, maszty, orientacja):
        self.kratka = kratka
        self.maszty = maszty
        self.orientacja = orientacja
        self.doOdstrzalu = maszty

    @property
    def statekPlynie(self):
        wspolStatku = []
        for i in range(self.maszty):
            wspolX = self.kratka.x
            wspolY = self.kratka.y
            if self.orientacja == 0:
                wspolX += i
            elif self.orientacja == 1:
                wspolY += i
            wspolStatku.append(Coords(wspolX, wspolY))
        return wspolStatku

class Board:
    def __init__(self, hid=False, size=10):
        self.size = size
        self.hid = hid
        self.count = 0
        self.pole = [[" "] * size for _ in range(size)]
        self.busy = []
        self.ships = []
        self.shots = set()  

    def __str__(self):
        board_str = "Plansza:\n"
        board_str += "   | 1 | 2 | 3 | 4 | 5 | 6 | 7 | 8 | 9 | 10|\n"
        for i, row in enumerate(self.pole):
            if self.hid:
                row = [" " if cell != "X" else cell for cell in row]
            for j, cell in enumerate(row):
                if Coords(i, j) in self.shots:  
                    if cell == "■":  
                        row[j] = "X"  
                    elif cell == " ":  
                        row[j] = "*"
            board_str += f"{i + 1:2d} | " + " | ".join(row) + " |\n"
        return board_str

    def add_ship(self, ship):
        for d in ship.statekPlynie:
            if self.out(d) or d in self.busy:
                raise BoardWrongShipException("Niewłaściwe ustawienie statku.")
        for d in ship.statekPlynie:
            self.pole[d.x][d.y] = "■"
            self.busy.append(d)
        self.ships.append(ship)
        self.contour(ship)

    def contour(self, ship, verb=False):
        near = [
            (-1, -1), (-1, 0), (-1, 1),
            (0, -1), (0, 0), (0, 1),
            (1, -1), (1, 0), (1, 1)
        ]
        for d in ship.statekPlynie:
            for dx, dy in near:
                cur = Coords(d.x + dx, d.y + dy)
                if not (self.out(cur)) and cur not in self.busy:
                    if verb:
                        self.pole[cur.x][cur.y] = "*"
                        self.busy.append(cur)
                    else:
                        self.busy.append(cur)

    def out(self, kratka):
        return not ((0 <= kratka.x < self.size) and (0 <= kratka.y < self.size))

    def strzel(self, kratka):
        if self.out(kratka):
            raise OutOfBoardException()
        if kratka in self.shots:
            raise BoardUsedException()
        self.shots.add(kratka)  # Add the shot to the set of shots
        for ship in self.ships:
            if kratka in ship.statekPlynie:
                ship.doOdstrzalu -= 1
                self.pole[kratka.x][kratka.y] = "X"
                if ship.doOdstrzalu == 0:
                    self.count += 1
                    self.contour(ship, verb=True)
                    print("Statek: trafiony - zatopiony!")
                    return True  # Ship destroyed
                else:
                    print("Statek został trafiony!")
                    return True
        self.pole[kratka.x][kratka.y] = "*"
        print("Pudło!")
        return False


class Player:
    def __init__(self, board, auto_place=False):
        self.board = board
        self.auto_place = auto_place

    def place_ships(self):
        if self.auto_place:
            self.auto_place_ships()
        else:
            self.manual_place_ships()

    def auto_place_ships(self):
        statki = [4, 3, 3, 2, 2, 2, 1, 1, 1, 1]
        for statek in statki:
            while True:
                x = randint(0, self.board.size - 1)
                y = randint(0, self.board.size - 1)
                orientacja = randint(0, 1)
                kratka = Coords(x, y)
                try:
                    ship = Ship(kratka, statek, orientacja)
                    self.board.add_ship(ship)
                    break
                except BoardWrongShipException:
                    continue

    def manual_place_ships(self):
        print("Umieść swoje statki na planszy:")
        statki = [(4, "czteromasztowiec"), (3, "trójmasztowiec"), (3, "trójmasztowiec"), 
                (2, "dwumasztowiec"), (2, "dwumasztowiec"), (2, "dwumasztowiec"), 
                (1, "jednomasztowiec"), (1, "jednomasztowiec"), (1, "jednomasztowiec"), 
                (1, "jednomasztowiec")]

        for statek, nazwa_statku in statki:
            print(f"Umieszczanie: {nazwa_statku}.")
            while True:
                try: 
                    if statek == 1:
                        kratka, orientacja = self.wprowadzWspolrzedne(jednomasztowiec=True)
                    else:
                        kratka, orientacja = self.wprowadzWspolrzedne(jednomasztowiec=False)
                    ship = Ship(kratka, statek, orientacja)
                    self.board.add_ship(ship)
                    print("Aktualne rozmieszczenie statków:")
                    print(self.board)
                    break
                except BoardWrongShipException as e:
                    print(f"Niewłaściwe współrzędne: {e}")
                except KeyboardInterrupt:
                    print("\nKoniec gry.")
                    sys.exit()
                except Exception as e:
                    print(f"Błąd: {e}")

    def wprowadzWspolrzedne(self, jednomasztowiec=False):
        while True:
            cords = input("Podaj współrzędne początku statku (format: x y), lub wpisz 'q' aby zakończyć grę: ").split()
            if cords == ['q']:
                print("Koniec gry.")
                sys.exit()
            if len(cords) != 2:
                print("Musisz podać 2 współrzędne: x y.")
                continue
            x, y = cords
            if not (x.isdigit()) or not (y.isdigit()):
                print("Współrzędne muszą być dodatnimi liczbami całkowitymi.")
                continue
            kratka = Coords(int(x) - 1, int(y) - 1)
            if jednomasztowiec:
                return kratka, None
            else:
                orientacja = input("Podaj orientację statku (0 - pionowo, 1 - poziomo): ")
                if orientacja not in ['0', '1']:
                    print("Nieprawidłowa orientacja. Podaj 0 lub 1.")
                    continue
                orientacja = int(orientacja)
                return kratka, orientacja


    def wykonajRuch(self):
        while True:
            try:
                cel = self.wprowadzWspolrzedne()
                strzal = self.board.strzel(cel)
                return strzal
            except BoardUsedException as e:
                print(f"Użyte współrzędne: {e}")
            except OutOfBoardException as e:
                print(f"Wyszedłeś poza planszę: {e}")