default.local_lib.default_inc = []
default.local_lib.bootstrap.deps = [
 { :module => 'local::lib', :version => '0' }, 
 { :module => 'CPAN::Version', :version => '0' }, 
 { :module => 'ExtUtils::MakeMaker' , :version => '6.31' },   
 { :module => 'CPAN::Meta::YAML' , :version => '0' },
 { :module =>  'File::Path' , :version => '2.08' },  
 { :module =>  'Dist::Metadata' , :version => '0' }, 
 { :module => 'Module::Build' , :version => '0.36_17' }
]

default.local_lib.bootstrap.install_base = nil


