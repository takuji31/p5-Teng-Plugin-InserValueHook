use strict;
use Test::LoadAllModules;
use Test::More;

BEGIN {
    all_uses_ok(
        search_path => "Teng::Plugin::InsertValueHook",
        except => [],
    );
}


diag "Testing Teng::Plugin::InsertValueHook/$Teng::Plugin::InsertValueHook::VERSION";
