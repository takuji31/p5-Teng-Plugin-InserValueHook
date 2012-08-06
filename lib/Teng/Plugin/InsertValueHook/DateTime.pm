package Teng::Plugin::InsertValueHook::DateTime;
use strict;
use warnings;
use 5.010_001;

use parent qw/Teng::Plugin::InsertValueHook/;
use DateTimeX::Factory::Declare;

sub modifiers {
    return [
        {
            type => 'before',
            name => 'insert',
            code => \&insert_hook,
        },
        {
            type => 'before',
            name => 'fast_insert',
            code => \&insert_hook,
        },
        {
            type => 'before',
            name => 'update',
            code => \&update_hook,
        },
    ];
}


sub insert_hook {
    my ($self, $table, $row_data) = @_;
    my $table_columns = __PACKAGE__->get_table_columns($table);

    if ($table_columns) {
        my $now = dt_now();
        __PACKAGE__->find_column_and_insert_value($table_columns, $row_data, 'created_at', $now);
        __PACKAGE__->find_column_and_insert_value($table_columns, $row_data, 'updated_at', $now);
    }

}

sub update_hook {
    my ($self, $table, $row_data) = @_;
    my $table_columns = __PACKAGE__->get_table_columns($table);

    if ($table_columns) {
        my $now = dt_now();
        __PACKAGE__->find_column_and_insert_value($table_columns, $row_data, 'updated_at', $now);
    }
}



1;
