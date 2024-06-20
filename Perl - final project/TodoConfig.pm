#!/usr/bin/perl

package TodoConfig;
use strict;
use warnings;
use Exporter qw(import);

our @EXPORT_OK = qw($CONFIG_FILE $TODO_FILE @PRIORITIES $DATE_FORMAT);

our $CONFIG_FILE = ".todolistrc";
our $TODO_FILE   = "todo.txt";
our @PRIORITIES  = qw(LOW MEDIUM HIGH);
our $DATE_FORMAT = "%Y-%m-%d";
use constant ONE_DAY => 24 * 60 * 60;

1;
