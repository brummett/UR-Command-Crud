Automatic generation of CRUD (create, list (read), update and delete plus copy) sub commands for UR objects.


[![Build Status](https://travis-ci.org/genome/UR-Object-Command-Crud.svg?branch=master)](https://travis-ci.org/genome/UR-Object-Command-Crud)


Creates trees of Command classes that can handle CRUD operations on UR objects.

```
package Acme::Command::Foo;

use Acme;
use UR::Object::Command::Crud;
UR::Object::Command::Crud->create_command_classes(
    target_class    => 'Acme::Foo',
    namespace       => 'Acme',
    target_name     => 'foo',
);
1;
```

Would create these Command classes:
    Acme::Foo::Command::Copy   (copy an Acme::Foo as a new object)
    Acme::Foo::Command::Create (create a new Acme::Foo)
    Acme::Foo::Command::Delete (delete an Acme::Foo)
    Acme::Foo::Command::List   (Lister command based on UR::Object::Command::List)
    Acme::Foo::Command::Update (Update properties of an Acme::Foo)

And the Update class would have sub-commands for each property of Acme::Foo
