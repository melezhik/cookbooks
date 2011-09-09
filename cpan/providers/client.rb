def load_current_resource

  @installer = Chef::Resource::LocalLibInstall.new(new_resource.name)
  @installer.name(new_resource.name)
  @installer.install_base(new_resource.install_base)
  @installer.dry_run(new_resource.dry_run)
  @installer.reload_cpan_index(new_resource.reload_cpan_index)
  @installer.inc(new_resource.inc)
  @installer.install_type(new_resource.install_type)
  @installer.cwd(new_resource.cwd)
  @installer.from_cookbook(new_resource.from_cookbook)
  @installer.force(new_resource.force)
  @installer.install_path(new_resource.install_path)
  @installer.user(new_resource.user)
  @installer.group(new_resource.group)
  @installer.version(new_resource.version)
  @installer.environment(new_resource.environment)
  nil
end

def header 

  user = @installer.user
  group = @installer.group
  dry_run = @installer.dry_run
  install_type = @installer.install_type
  version = @installer.version
  cwd = @installer.cwd
  
  ruby_block 'info' do 
    block do
      print "#{dry_run == true ? 'DRYRUN' : 'REAL' } install #{install_type} #{installed_module} via cpan #{cpan_client_flags} "
      print "cpan_client has started with rights: user=#{user} group=#{group} "
      print "install-base : #{install_base_print} "
      print "cwd : #{cwd} "
      print "install_version : #{version} "
      print "cpan_client_stack : #{cpan_client_stack} "
      print "install path : #{get_install_path} " unless get_install_path.empty?
      print "install log file #{install_log_file} "
    end
  end
  
end

action :reload_cpan_index do

  user = @installer.user
  group = @installer.group
  cwd = @installer.cwd
  home = get_home

  log 'reload cpan index'
  execute "reload cpan index" do
    command 'perl -MCPAN -e "CPAN::Index->reload"'
    action :run
    user user
    group group
    cwd cwd
    environment ({'HOME' => home , 'MODULEBUILDRC' => '/tmp/local-lib/.modulebuildrc' }) 
  end

end

action :install do

  @test_mode = nil
  user = @installer.user
  group = @installer.group
  cwd = @installer.cwd
  home = get_home
  
  header
  @installer.dry_run == true ? install_dry_run : install_real
  new_resource.updated_by_last_action(true)

end

action :test do

  @test_mode = 1

  header
  log 'don*t install, run tests only'

  install_real

end

def cpan_client_stack

  perl5lib = Array.new
  perl5lib += node.cpan_client.default_inc
  perl5lib += @installer.inc

  cpan_client_stack = 'eval $(perl -Mlocal::lib=--deactivate-all); '  

  unless  @installer.install_base.nil?
   cpan_client_stack << "eval $(perl -Mlocal::lib=#{real_install_base}); "
  end

  cpan_client_stack << "PERL5LIB=$PERL5LIB:#{perl5lib.join(':')}; " unless perl5lib.empty?
  return cpan_client_stack
  
end

def real_install_base
   install_base = @installer.install_base
   install_base.gsub!('\s','')
   install_base.chomp!
   unless /^\//.match(install_base)
     install_base = "#{@installer.cwd}/#{install_base}"
   end
   return install_base
end

def install_base_print 
 @installer.install_base.nil? ? 'default::install::base' : real_install_base
end


def install_dry_run
 return install_dry_run_tarball if @installer.from_cookbook
 return install_dry_run_cpan_module if @installer.install_type == 'cpan_module'
 return install_dry_run_cpan_module if @installer.install_type == 'cpan_module'
 return install_dry_run_application if @installer.install_type == 'application'
 raise 'should set install_type as (cpan_module|application) or from_cookbook parameter'
end

def install_real
 return install_tarball if @installer.from_cookbook
 return install_cpan_module if @installer.install_type == 'cpan_module'
 return install_cpan_module if @installer.install_type == 'cpan_module'
 return install_application if @installer.install_type == 'application'
 raise 'should set install_type as (cpan_module|application) or from_cookbook parameter'
end

def installed_module
  unless @installer.from_cookbook
    installed_module = @installer.name
    installed_module.gsub!(' ','-')
  else
    mat = /([a-z\d\.-]+)\.tar\.gz$/i.match(@installer.name)
    installed_module = mat[1]
  end
  return installed_module
end

def install_dry_run_cpan_module
  text = Array.new
  text << "WOULD install cpan module #{@installer.name}"
  ruby_block 'info' do
    block do
	print text.join("\n")
    end      
  end
end

def install_dry_run_tarball
  
  text = Array.new
  text << "WOULD copy cookbook file #{@installer.from_cookbook}::#{@installer.name} to /tmp/local-lib/install/"
  text << "WOULD cd to /tmp/local-lib/install/"
  text << "WOULD tar -zxf #{@installer.name}"
  text << "WOULD cd to #{installed_module}"
  text << "WOULD cpan #{cpan_client_flags} ."
  
  ruby_block 'info' do
    block do
	print text.join("\n")
    end      
  end
end


def install_dry_run_application

  cwd = @installer.cwd
  user = @installer.user
  group = @installer.group

  text = Array.new
  text << "WOULD install application"
  ruby_block 'info' do
    block do
	print text.join("\n")
    end      
  end

  cmd = Array.new
  cmd << cpan_client_stack
  cmd << 'if test -f Build.PL; then'
  cmd << 'perl Build.PL && ./Build'
  cmd << " echo './Build fakeinstall' > #{install_log_file}"
  cmd << " ./Build fakeinstall >> #{install_log_file}"
  cmd << " echo './Build prereq_report' >> #{install_log_file}"
  cmd << " ./Build prereq_report >> #{install_log_file}"
  cmd << 'else'
  cmd << 'perl Makefile.PL && make'
  cmd << "echo ' -- OK dry-run mode only enabled for Module::Build based distributions' > #{install_log_file}"
  cmd << 'fi'

  bash "install_dry_run_application" do
    user user
    group group
    cwd cwd
    code cmd.join("\n")
  end

  ruby_block 'prereq_report' do 
    block do
        IO.foreach(install_log_file) do |l|
            print l unless /^Skipping /.match(l)
        end
    end
  end

end


def install_cpan_module

  cwd = @installer.cwd
  user = @installer.user
  group = @installer.group
  home = get_home

  cmd = Array.new
  cmd << cpan_client_stack

  if @installer.version.nil? # not install if uptodate
      log 'version required : highest'
      cmd << 'perl -MCPAN -e \''
      cmd << 'unless(CPAN::Shell->expand("Module",$ARGV[0])->uptodate){ exit(2) }'
      cmd << ' else { print $ARGV[0], " -- OK is uptodate : ".(CPAN::Shell->expand("Module",$ARGV[0])->inst_version) }'
      cmd << "' #{@installer.name} 2>&1 > #{install_log_file} || "  
  elsif @installer.version == "0" # not install if any version already installed
      log 'version required : any'
      cmd << 'perl -MCPAN -e \''
      cmd << 'unless(CPAN::Shell->expand("Module",$ARGV[0])->inst_version){ exit(2) }'
      cmd << ' else { print $ARGV[0], " -- OK already installed " }'
      cmd << "' #{@installer.name} 2>&1 > #{install_log_file} || "  
  elsif @installer.version != "0" # not install if have higher or equal version
      v = @installer.version
      log "version required : #{v}"
      cmd << 'perl -MCPAN -MCPAN::Version -e \''
      cmd << '$inst_v = CPAN::Shell->expand("Module",$ARGV[0])->inst_version;'
      cmd << 'unless ( CPAN::Version->vcmp($inst_v, $ARGV[1]) >=0 ) { exit(2) }'
      cmd << ' else { print $ARGV[0], " -- OK have higher or equal version [$inst_v]"  }'
      cmd << "' #{@installer.name} #{@installer.version} 2>&1 > #{install_log_file} || "  
  else
      raise "bad version : #{@installer.version}"      
  end
  

  cmd << " cpan #{cpan_client_flags} #{@installer.name} 2>&1 > #{install_log_file}"


  file "#{install_log_file}" do
    action :touch
    owner user
    group group
  end

  bash "install_cpan_module" do
    user user
    group group
    cwd cwd
    code cmd.join("\n")
    environment my_env
  end

  install_log

end

def install_tarball

  cwd = @installer.cwd
  user = @installer.user
  group = @installer.group
  home = get_home
  tarball_name = @installer.name
  from_cookbook = @installer.from_cookbook

  cookbook_file "/tmp/local-lib/install/#{@installer.name}" do
    action 'create_if_missing'
    mode "0644"
    cookbook from_cookbook
    owner user
    group group
  end

  bash "install_tarball" do
    user user
    group group
    cwd "/tmp/local-lib/install/"
    code "tar -zxf #{tarball_name}"
  end

  cmd = Array.new
  cmd << cpan_client_stack
  cmd << "export PERL_MB_OPT=$PERL_MB_OPT' #{get_install_path}'" unless get_install_path.empty?
  cmd << 'perl -MCPAN::Version -MDist::Metadata -MCPAN -e \''
  cmd << 'my $dist = Dist::Metadata->new(file => $ARGV[0]);'
  cmd << 'my $dist_name = $dist->name;';
  cmd << '$cpan_dist = CPAN::Shell->expand("Distribution","/\/$dist_name-.*\.tar\.gz/");'
  cmd << 'eval{ for $m ($cpan_dist->containsmods) { $cpan_mod = CPAN::Shell->expand("Module", $m);'
  cmd << 'eval { $res = CPAN::Version->vcmp($dist->version,$cpan_mod->inst_version)}; next if $@;'
  cmd << 'if ($res == 0) { print " -- OK : exact version already installed \n"; exit(0) } } };'
  cmd << 'exit(2);'
  cmd << "\' /tmp/local-lib/install/#{@installer.name} 2>&1 > #{install_log_file} ||"
  cmd << "cpan #{cpan_client_flags} . 2>&1 >> #{install_log_file}"

  
  file "#{install_log_file}" do
    action :touch
    owner user
    group group
  end

        
  bash "install_tarball" do
    user user
    group group
    cwd "/tmp/local-lib/install/#{installed_module}"
    code cmd.join("\n")
    environment my_env
  end

  install_log

end

def get_install_path
  install_path = ''
  @installer.install_path.each do |i|
    install_path << " --install_path #{i} "
  end
  install_path
end

def install_application

  cwd = @installer.cwd
  user = @installer.user
  group = @installer.group
  home = get_home

  cmd = Array.new
  cmd << cpan_client_stack
  cmd << "cpan #{cpan_client_flags} .  2>&1 > #{install_log_file}"

  #cmd << "cpan #{cpan_client_flags} . "
  
  bash "install_application" do
    user user
    group group
    cwd cwd
    code cmd.join("\n")
    environment my_env
  end

  install_log

end

def my_env
  my_env = @installer.environment
  my_env['HOME'] = get_home
  my_env['MODULEBUILDRC'] = '/tmp/local-lib/.modulebuildrc'        
  my_env
end

def install_log_file 
  "/tmp/local-lib/#{installed_module}-install.log"
end

def install_log 

  my_installed_module = installed_module
  ruby_block 'install-log' do
    block do
        print " *** #{my_installed_module} *** "
        IO.foreach(install_log_file) do |l|
            print l if /\s--\s(OK|NOT OK)/.match(l)
            print l if /Writing.*for/.match(l) 
            print l if /Going to build/.match(l)
            print l if /^Warning:/.match(l)
            
        end
        print " *** "
    end
  end
end


def cpan_client_flags 
  flags = Array.new
  if @test_mode.nil? 
   flags << '-i'
  else
   flags << '-t'
  end
  flags << '-f' if @installer.force == true
  flags << ''
  flags.join(' ')
end

def get_home 
  user = @installer.user
  group = @installer.group
  home = user == 'root' ? "/root/" : "/home/#{user}/"
  return home
end 

