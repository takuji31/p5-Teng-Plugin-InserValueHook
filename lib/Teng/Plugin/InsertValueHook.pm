package Teng::Plugin::InsertValueHook;
use strict;
use warnings;
use 5.010_001;

our $VERSION = '0.01';

use Class::Method::Modifiers qw/install_modifier/;

our @EXPORT = qw//;

sub init {
    my ($class, $pkg) = @_;
    if ($class eq $pkg) {
        # XXX Avoid Teng plugin initialize bug
        $pkg = caller(1);
    }

    my $modifiers = $class->modifiers;
    for my $modifier (@$modifiers){
        my $type = $modifier->{type};
        my $name = $modifier->{name};
        my $code = $modifier->{code};
        my $cond = $modifier->{cond};
        if (!defined $cond || $cond->($class, $pkg)) {
            install_modifier $pkg, $type, $name, $code;
        }
    }
}

sub modifiers { die 'This method is abstract' }

sub get_table_info {
    my ($class, $teng, $table_name) = @_;

    my $table = $teng->schema->get_table($table_name);

    return unless $table;

    return $table->columns;
}

sub find_column_and_insert_value {
    my ($class, $columns, $row_data, $column_name, $value) = @_;

    if (grep /^$column_name$/, @$columns) {
        $row_data->{$column_name} //= $value;
    }
}


1;
__END__

=head1 NAME

Teng::Plugin::InsertValueHook - Perl extention to do something

=head1 VERSION

This document describes Teng::Plugin::InsertValueHook version 0.01.

=head1 SYNOPSIS

    use Teng::Plugin::InsertValueHook;

=head1 DESCRIPTION

# TODO

=head1 INTERFACE

=head2 Functions

=head3 C<< hello() >>

# TODO

=head1 DEPENDENCIES

Perl 5.10.0 or later.

=head1 BUGS

All complex software has bugs lurking in it, and this module is no
exception. If you find a bug please either email me, or add the bug
to cpan-RT.

=head1 SEE ALSO

L<perl>

=head1 AUTHOR

Nishibayashi Takuji E<lt>takuji@senchan.jpE<gt>

=head1 LICENSE AND COPYRIGHT

Copyright (c) 2012, Nishibayashi Takuji. All rights reserved.

This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself.

=cut
