use Module::Build;

my $build = Module::Build->new(
    module_name => 'UR::Object::Command::Crud',
    license => 'perl',
    dist_abstract => 'Automatic generation of CRUD (create, list (read), update and delete plus copy) sub commands for UR objects.',
    dist_author => 'Anthony Brummett <brummett@cpan.org>',
    dist_version => '0.01',
    build_requires => {
        'Module::Build' => 0,
    },
    test_requires => {
        'Path::Class'   => 0,
        'Test::More'    => 0,
        'Scope::Guard'  => 0,
    },
    requires => {
        'UR'                    => 0,
        'YAML'                  => 0,
        'Lingua::EN::Inflect'   => 0,
        'List::MoreUtils'       => 0,
        'Sub::Install'          => 0,
    },
);
$build->create_build_script;
