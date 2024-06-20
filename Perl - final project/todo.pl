#!/usr/bin/perl
use strict;
use warnings;
use feature 'say';
use Time::Piece;
use FindBin qw($RealBin);
use lib $RealBin;
use TodoConfig qw($CONFIG_FILE $TODO_FILE @PRIORITIES $DATE_FORMAT);
use constant ONE_DAY => 24 * 60 * 60;
use TodoOperations qw(add_task display_tasks mark_as_completed clear_completed display_menu display_help);

# Inicjalizacja pliku konfiguracyjnego
unless (-e $CONFIG_FILE) {
    open my $config_fh, '>', $CONFIG_FILE or die "Cannot create config file: $!";
    say $config_fh "PRIORITIES=(LOW MEDIUM HIGH)";
    say $config_fh "DATE_FORMAT=%Y-%m-%d";
    close $config_fh;
}

# Wczytanie konfiguracji
open my $config_fh, '<', $CONFIG_FILE or die "Cannot open config file: $!";
while (<$config_fh>) {
    chomp;
    if (/PRIORITIES=\((.*?)\)/) {
        @PRIORITIES = split /\s+/, $1;
    } elsif (/DATE_FORMAT=(.*)/) {
        $DATE_FORMAT = $1;
    }
}
close $config_fh;

# Utworzenie pliku zadań, jeśli nie istnieje
unless (-e $TODO_FILE) {
    open my $todo_fh, '>', $TODO_FILE or die "Cannot create todo file: $!";
    close $todo_fh;
}

# Sprawdzanie opcji w wierszu poleceń
if (@ARGV) {
    if ($ARGV[0] eq '-h' || $ARGV[0] eq '--help') {
        TodoOperations::display_help();
        exit;
    }
}

while (1) {
    TodoOperations::display_menu();
    chomp(my $option = <STDIN>);

    if ($option == 1) {
        TodoOperations::add_task();
    } elsif ($option == 2) {
        TodoOperations::display_tasks();
    } elsif ($option == 3) {
        TodoOperations::mark_as_completed();
    } elsif ($option == 4) {
        TodoOperations::clear_completed();
    } elsif ($option == 5) {
        say "Do widzenia!";
        exit;
    } elsif ($option == 6) {
        TodoOperations::display_help();
    } else {
        say "Nieprawidłowa opcja. Wybierz ponownie.";
    }
}
