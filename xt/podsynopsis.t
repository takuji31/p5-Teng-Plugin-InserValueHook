use strict;
use Test::More;
eval q{use Test::Synopsis};
plan skip_all => 'Test::Synopsis required for testing SYNOPSIS'
    if $@;
all_synopsis_ok();
