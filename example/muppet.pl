#!/usr/bin/env perl

use strict;
use warnings 'FATAL';

use Path::Class;

use lib file(__FILE__)->dir->parent->subdir('t')->stringify;
use lib file(__FILE__)->dir->parent->subdir('lib')->stringify;

use UR;
use UR::Object::Command::Crud;
use TestCrudClasses;

UR::Object::Command::Crud->create_command_subclasses(
    target_class => 'Test::Muppet',
    namespace => 'Muppet::Command',
    target_name => 'muppet',
    sub_command_configs => { update => { only_if_null => [qw/ name /], }, list => { show => 'id,name', order_by => 'name', }, },
);

Muppet::Command->execute_with_shell_params_and_exit();
