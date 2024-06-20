#!/usr/bin/perl

package TodoOperations;
use strict;
use warnings;
use feature 'say';
use Time::Piece;
use TodoConfig qw($TODO_FILE $DATE_FORMAT);
use constant ONE_DAY => 24 * 60 * 60;

our @EXPORT_OK = qw(add_task display_tasks mark_as_completed clear_completed display_menu display_help);

# Dodanie zadania
sub add_task {
    print "Wprowadź nowe zadanie: ";
    chomp(my $new_task = <STDIN>);
    print "Priorytet (LOW/MEDIUM/HIGH): ";
    chomp(my $priority = <STDIN>);
    print "Termin (dziś/jutro/RRRR-MM-DD): ";
    chomp(my $due_date_input = <STDIN>);

    my $due_date;
    if ($due_date_input =~ /^dziś$/i) {
        $due_date = localtime->strftime($DATE_FORMAT);
    } elsif ($due_date_input =~ /^jutro$/i) {
        my $current_time = localtime;
        my $tomorrow = $current_time + ONE_DAY;
        $due_date = $tomorrow->strftime($DATE_FORMAT);
    } elsif ($due_date_input =~ /^\d{4}-\d{2}-\d{2}$/) {
        my $input_date = Time::Piece->strptime($due_date_input, $DATE_FORMAT);

        # Sprawdzenie czy data jest późniejsza niż obecna
        if ($input_date < localtime) {
            say "Nie można dodać zadania z przeszłą datą.";
            return;
        }
        $due_date = $due_date_input;
    } else {
        say "Nieprawidłowy format daty. Poprawny format: dziś, jutro lub RRRR-MM-DD";
        return;
    }

    open my $todo_fh, '>>', $TODO_FILE or die "Cannot open todo file: $!";
    say $todo_fh "[$due_date] [$priority] - $new_task";
    close $todo_fh;
    say "Zadanie dodane!";
}

# Wyświetlenie zadań
sub display_tasks {
    if (-s $TODO_FILE) {
        say "========= Lista Zadań =========";
        open my $todo_fh, '<', $TODO_FILE or die "Cannot open todo file: $!";
        while (my $task = <$todo_fh>) {
            chomp $task;
            say $task;
        }
        close $todo_fh;
        say "===============================";
    } else {
        say "Lista zadań jest pusta.";
    }
}

# Oznaczenie zadania jako zakończone
sub mark_as_completed {
    display_tasks();
    print "Podaj numer zadania do oznaczenia jako zakończone: ";
    chomp(my $task_number = <STDIN>);

    my @tasks;
    open my $todo_fh, '<', $TODO_FILE or die "Cannot open todo file: $!";
    @tasks = <$todo_fh>;
    close $todo_fh;

    if ($task_number <= 0 || $task_number > scalar @tasks) {
        say "Błąd: Podany numer zadania jest nieprawidłowy.";
        return;
    }

    # Dodanie flagi "completed" do zadania
    $tasks[$task_number - 1] =~ s/\n?$/ COMPLETED\n/;

    open $todo_fh, '>', $TODO_FILE or die "Cannot open todo file: $!";
    print $todo_fh $_ for @tasks;
    close $todo_fh;
    say "Zadanie oznaczone jako zakończone.";
}

# Usunięcie zakończonych zadań
sub clear_completed {
    say "Czyszczenie zakończonych zadań...";
    my @tasks;
    open my $todo_fh, '<', $TODO_FILE or die "Cannot open todo file: $!";
    while (<$todo_fh>) {
        push @tasks, $_ unless /COMPLETED/;
    }
    close $todo_fh;
    open $todo_fh, '>', $TODO_FILE or die "Cannot open todo file: $!";
    print $todo_fh $_ for @tasks;
    close $todo_fh;
    say "Zakończone zadania zostały usunięte.";
}

# Wyświetlenie menu
sub display_menu {
    say "=========== TO-DO LIST MANAGER ===========";
    say "1. Dodaj zadanie";
    say "2. Wyświetl zadania";
    say "3. Oznacz zadanie jako zakończone";
    say "4. Wyczyść zakończone zadania";
    say "5. Wyjście";
    say "6. Pomoc (opcje)";
    say "===========================================";
    print "Wybierz opcję: ";
}

# Wyświetlenie pomocy
sub display_help {
    say "=========== TO-DO LIST MANAGER - Pomoc ===========";
    say "Opcje:";
    say "  1. Dodaj zadanie - Dodaje nowe zadanie do listy.";
    say "  2. Wyświetl zadania - Wyświetla listę zadań.";
    say "  3. Oznacz zadanie jako zakończone - Oznacza wybrane zadanie jako zakończone.";
    say "  4. Wyczyść zakończone zadania - Usuwa z listy wszystkie zakończone zadania.";
    say "  5. Wyjście - Kończy program.";
    say "  6. Pomoc (opcje) - Wyświetla pomoc dotyczącą dostępnych opcji.";
    say "===================================================";
    say "Przykłady użycia:";
    say "  - Wprowadź nowe zadanie, priorytet (LOW/MEDIUM/HIGH), i termin (dziś/jutro/RRRR-MM-DD).";
    say "  - Wyświetl listę zadań i numery zadań do operacji na nich.";
    say "  - Oznacz zadanie jako zakończone, podając numer zadania.";
    say "  - Wyczyść zakończone zadania.";
    say "  - Wyjście z programu.";
    say "===================================================";
    say "Aby uruchomić skrypt, wpisz w terminalu: perl todo.pl";
    say "Dostępne również opcje:";
    say "  -h, --help: Wyświetla pomoc (to menu).";
    say "  Przykład: perl todo.pl -h";
    say "===================================================";
}

1;