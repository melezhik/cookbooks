# version 0.0.13
- install summary:
 - impoved, fixed and simplified

# version 0.0.12
 - cpan-client: redirect stderr to stdout 
 - made logs more clear
 
# version 0.0.11
 - add cucumber features
 - bugfix for install_path cases
 
# version 0.0.10
 - bugfix : before install create /tmp/local-lib/install directory

# version 0.0.9
 - add documentation
 
# version 0.0.8
 - .modulebuildrc create in :install action instead of cpan::default recipe
 - add cpan_home optional attribute
 - create '/tmp/local_lib/' before doing install

# version 0.0.7
 - bugfix for install from tarball (forgot about cwd while refactoring)
 
# version 0.0.6
 - replace execute resource by bash resources for less verbosity in logs
 - improve after-install summary
 
# version 0.0.5
 - compact log messages

# version 0.0.4
 - log messages are neat and at different levels
 - big fix for access to log files 
 
