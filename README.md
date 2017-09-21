[![Build Status](https://travis-ci.org/genome/UR-Object-Command-Crud.svg?branch=master)](https://travis-ci.org/genome/UR-Object-Command-Crud)
[![Coverage Status](https://coveralls.io/repos/github/genome/UR-Object-Command-Crud/badge.svg?branch=master)](https://coveralls.io/github/genome/UR-Object-Command-Crud?branch=master)

UR Object CRUD CLI
=====
### Create, List (Read), Update and Delete plus Copy (CRUD) Command Line Interfaces for UR Objects

## Example Files
* t/TestCrudClasses.pm	Full test classes
* example/muppet.pl	The implementation of CRUD command below

Using Test::Muppet as out UR::Object, we create a script, or a subcommand of a larger project.

### Script: muppet.pl
```
#!/usr/bin/env perl
# A script to manipulate muppets!

use strict;
use warnings 'FATAL';

use Path::Class;

use lib file(__FILE__)->dir->parent->subdir('t')->stringify;
use lib file(__FILE__)->dir->parent->subdir('lib')->stringify;

use UR;
use UR::Object::Command::Crud;
use TestEnvCrud;

UR::Object::Command::Crud->create_command_classes(
    target_class => 'Test:Muppet',
    namespace => 'Muppet'
    target_name => 'muppet',
);

Muppet::Command->execute_with_shell_params_and_exit();
```

### Sub Command Structure

Each CRUD function will get an in memory class created. These classes are used used for the command line interface. Under the update command, each object property will get its own command. If the relationship of the property is 'has many', there will be an add and remove command for the property.

#### script command structure
```
$ muppet.pl --help
Sub-commands for muppet.pl:
 copy         copy a muppet
 create       create muppets
 delete       delete muppet
 list         muppets
 update  ...  properties on muppets
```
#### update command tree
```
$ muppet.pl update -h
Sub-commands for muppet.pl update:
 best-friend       update muppets best_friend
 friends      ...  add/remove friends
 job               update muppets job
 name              update muppets name
 title             update muppets title
```
#### add/remove friends tree
```
$ muppet.pl update friends --help
Sub-commands for muppet.pl update friends:
 add       friends to muppets
 remove    friends from muppets
```
## Config Parameters

*Optional unless noted*

### target_class (required)
The class name of the objects to create CRUD commands. Ex: *Test::Muppet*

### target_name
The space separated singular name of the objects. Default is to convert the class name from camel case to a space separated string. Default for 'Test::Muppet' would be *test muppet*. For just muppet, give *muppet*.

### namespace
The class name to be the namespace ofthe commadn structure. By default, command is added to the target class, then sub commands are then created from that class name. Use if wanting to adjust the command line structure abd naming. Ex: *Muppet::Command*

### sub_command_configs
A HASH with command names as keys and config HASHes as values. See below for more details.  Ex: *{ create => { skip => 1, }, list => { show => 'id,name', }, ... }*

*All params are optional*

#### All Sub Commands
_skip_ => Skip, do not generate this sub command.

#### Create
_exclude_ => Exclude these properties, do not include them when creating an object.

#### List
_show_ => The default object properties to show. Give as a comma separated string. Ex: *id,name,friends*

_order_by_ => The default order to list the objects in. The ID is the default. Give as string. Ex: *name*

#### Update
_exclude_ => Exclude these properties, do not make sub commmands for them. Give a list of properties => *[qw/ best_friend /]*

_only_if_null_ => Only allow updating of a property if it is null. Give a list of properties => *[qw/ title job /]*

