def load_current_resource

  @installer = Chef::Resource::CpanClient.new(new_resource.name)
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
  @installer.cpan_home(new_resource.cpan_home)

  nil
end

def header 

  user = @installer.user
  group = @installer.group
  dry_run = @installer.dry_run
  install_type = @installer.install_type
  version = @installer.version
  cwd = @installer.cwd
  
      Chef::Log.info("#{dry_run == true ? 'DRYRUN' : 'REAL' } install #{install_type} #{installed_module}. install_version: #{version_print}")
      Chef::Log.debug("cpan_client has started with rights: user=#{user} group=#{group}")
      Chef::Log.debug("cpan_home: #{get_home}")
      Chef::Log.debug("cwd: #{cwd}")
      Chef::Log.debug("install-base: #{install_base_print}")
      Chef::Log.debug("local::lib expresion: #{local_lib_stack}")
      Chef::Log.debug("perl5lib variable: #{perl5lib_stack}")
      Chef::Log.debug("install command: #{install_perl_code}")
      Chef::Log.debug("environment: #{cpan_env_print}")
      Chef::Log.info("install log file: #{install_log_file}")
  
end


def cpan_env
  c_env = @installer.environment
  c_env['HOME'] = get_home
  c_env['MODULEBUILDRC'] = '/tmp/local-lib/.modulebuildrc'        
  c_env['PERL5LIB'] = perl5lib_stack unless (perl5lib_stack.nil? || perl5lib_stack.empty?)
  c_env
end

def cpan_env_print
  st = ''
  cpan_env.each {|key, value| st << " #{key}=#{value}; " }
  st
end

def version_print
  retval = nil
  if @installer.version.nil? # not install if uptodate
      retval = 'highest'
  elsif @installer.version == "0" # not install if any version already installed
      retval = 'any'
  elsif @installer.version != "0" # not install if have higher or equal version
      v = @installer.version
      retval = "#{v}"
  else
      raise "bad version : #{@installer.version}"      
  end
  retval
end

def install_log_file
  "/tmp/local-lib/#{installed_module}-install.log"
end

def install_log 

  my_installed_module = installed_module
  force_mode = @installer.force
  ruby_block 'install-log' do
    block do
        print ">>> #{my_installed_module} install summary <<<\n"
        prev_line = ''
        IO.foreach(install_log_file) do |l|
            print "   #{l.chomp} [#{prev_line}]\n" if /\s--\s(OK|NOT OK)/.match(l)
            if /Stopping: 'install' failed/.match(l)
                if force_mode == true
                    Chef::Log.warn("error occured : #{l}[#{prev_line}]") 
                    Chef::Log.info("will continue because we are in force_mode = true mode") 
                else
                    raise "#{l}[#{prev_line}]\n"
                end   
            end
            prev_line = l.chomp.gsub(/^\s+/,"").gsub(/\s+$/,"")
        end
    end
  end
end



def install_perl_code install_thing = '$ARGV[0]'
 cmd = nil
 if @test_mode.nil?
  if @installer.force == true
    cmd = "CPAN::Shell->force(\"install\",#{install_thing})"
  else
    cmd = "CPAN::Shell->install(#{install_thing})" 
 end 
 else
   cmd = "print \"PERL_MB_OPT : $ENV{PERL_MB_OPT}\n\"; CPAN::Shell->test(#{install_thing})" 
 end
 cmd
end

def get_home 
  user = @installer.user
  group = @installer.group
  cpan_home = @installer.cpan_home
  home = user == 'root' ? "/root/" : ( cpan_home.nil? ? "/home/#{user}/" : cpan_home)
  return home
end 

def perl5lib_stack

  perl5lib = Array.new
  perl5lib += node.cpan_client.default_inc
  perl5lib += @installer.inc
  perl5lib.join(':')
  
end

def evaluate_mb_opt
  string = ''
  install_paths = []
  @installer.install_path.each do |i|
    install_paths << "--install_path #{i}"
  end
  string << "PERL_MB_OPT=\"${PERL_MB_OPT} #{install_paths.join(' ')}\"; " unless install_paths.empty?
  string  
end


def local_lib_stack

  stack = '';
  #stack  << "#{perl5lib_stack}; " unless ( perl5lib_stack.nil? || perl5lib_stack.empty? )

  unless  @installer.install_base.nil?
    stack << "eval $(perl -Mlocal::lib=#{real_install_base}); #{evaluate_mb_opt} "
  else
    stack << "#{evaluate_mb_opt} "
  end
  return stack
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

  directory '/tmp/local-lib/' do
    owner user
    group group
  end

  directory '/tmp/local-lib/install' do
    owner user
    group group
  end
  
  file install_log_file do
    owner user
    group group
  end

  cookbook_file '/tmp/local-lib/.modulebuildrc' do
    cookbook 'cpan'
    action :create
    source '.modulebuildrc'
    mode '0644'
    owner user
    group group
  end
  
  header
  @installer.dry_run == true ? install_dry_run : install_real
  new_resource.updated_by_last_action(true)

end

action :test do

  @test_mode = 1

  header
  log 'don*t install, run tests only'

  user = @installer.user
  group = @installer.group

  directory '/tmp/local-lib/' do
    owner user
    group group
  end

  file install_log_file do
    owner user
    group group
  end

  install_real

end


def install_dry_run
 return install_dry_run_tarball if @installer.from_cookbook
 return install_dry_run_cpan_module if @installer.install_type == 'cpan_module'
 return install_dry_run_cpan_module if @installer.install_type == 'cpan_module'
 return install_dry_run_application if @installer.install_type == 'application'
 raise 'should set install_type as (cpan_module|application) or from_cookbook parameter'
end

def install_real
 if @installer.from_cookbook or /([a-z\d\.-]+)\.tar\.gz$/i.match(@installer.name) or /^(http:\/\/)/i.match(@installer.name)
    return install_tarball 
 end
 
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
    if mat.nil?
        raise "distributive name #{@installer.name} does not match ([a-z\d\.-]+)\.tar\.gz$ pattern"
    end
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
  text << "WOULD install via #{install_perl_code} ."
  
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
  cmd << local_lib_stack
  cmd << 'if test -f Build.PL; then'
  cmd << 'perl Build.PL && ./Build'
  cmd << " echo './Build fakeinstall' 1>#{install_log_file} 2>&1"
  cmd << " ./Build fakeinstall 1>>#{install_log_file} 2>&1"
  cmd << " echo './Build prereq_report' 1>>#{install_log_file} 2>&1"
  cmd << " ./Build prereq_report 1>>#{install_log_file} 2>&1"
  cmd << 'else'
  cmd << 'perl Makefile.PL && make'
  cmd << "echo ' -- OK dry-run mode only enabled for Module::Build based distributions' 1>#{install_log_file} 2>&1"
  cmd << 'fi'

  bash "install application dry-run" do
    user user
    group group
    cwd cwd
    code cmd.join("\n")
    environment cpan_env
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

  file "#{install_log_file}" do
    action :touch
    owner user
    group group
  end

  cmd = Array.new
  cmd << local_lib_stack

  if @installer.version.nil? # not install if uptodate
      cmd << 'perl -MCPAN -e \''
      cmd << 'unless(CPAN::Shell->expand("Module",$ARGV[0])->uptodate){'
      cmd << install_perl_code
      cmd << ' } '
      cmd << ' else { print $ARGV[0], " -- OK is uptodate : ".(CPAN::Shell->expand("Module",$ARGV[0])->inst_version)."\n" }'
      cmd << "' #{@installer.name}  1>#{install_log_file} 2>&1"  
  elsif @installer.version == "0" # not install if any version already installed
      cmd << 'perl -MCPAN -e \''
      cmd << 'unless(CPAN::Shell->expand("Module",$ARGV[0])->inst_version) { '
      cmd << install_perl_code
      cmd << ' } '
      cmd << ' else { print $ARGV[0], " -- OK already installed \n" }'
      cmd << "' #{@installer.name}  1>#{install_log_file} 2>&1"  
  elsif @installer.version != "0" # not install if have higher or equal version
      v = @installer.version
      cmd << 'perl -MCPAN -MCPAN::Version -e \''
      cmd << '$inst_v = CPAN::Shell->expand("Module",$ARGV[0])->inst_version;'
      cmd << 'unless ( CPAN::Version->vcmp($inst_v, $ARGV[1]) >=0 ) { '
      cmd << install_perl_code
      cmd << ' } '
      cmd << ' else { print $ARGV[0], " -- OK have higher or equal version [$inst_v]"  }'
      cmd << "' #{@installer.name} #{@installer.version}  1>#{install_log_file} 2>&1"  
  else
      raise "bad version : #{@installer.version}"      
  end

  Chef::Log.debug "cmd: [#{cmd}]"
  
  bash 'install cpan module' do
    code cmd.join(" ")
    user user
    group group
    cwd cwd
    environment cpan_env
  end

  install_log

end

def install_tarball

  cwd = @installer.cwd
  user = @installer.user
  group = @installer.group
  home = get_home

  execute "rm -rf /tmp/local-lib/install/#{installed_module}"
  
  if @installer.name.match('^http:\/\/')
    tarball_name = @installer.name.split('/').last
    remote_file "/tmp/local-lib/install/#{tarball_name}" do
        source @installer.name
        mode "0644"
        owner user
        group group
    end        
  else
    tarball_name = @installer.name
    from_cookbook = @installer.from_cookbook
    cookbook_file "/tmp/local-lib/install/#{tarball_name}" do
        action 'create_if_missing'
        mode "0644"
        cookbook from_cookbook
        owner user
        group group
        end
  end

  execute "tar -zxf #{tarball_name}" do
    user user
    group group
    cwd "/tmp/local-lib/install/"
  end

  cmd = Array.new
  cmd << local_lib_stack
  cmd << 'perl -MCPAN::Version -MDist::Metadata -MCPAN -e \''
  cmd << 'my $dist = Dist::Metadata->new(file => $ARGV[0]);'
  cmd << 'my $dist_name = $dist->name;';
  cmd << '$cpan_dist = CPAN::Shell->expand("Distribution","/\/$dist_name-.*\.tar\.gz/");'
  cmd << 'eval{ for $m ($cpan_dist->containsmods) { $cpan_mod = CPAN::Shell->expand("Module", $m);'
  cmd << 'eval { $res = CPAN::Version->vcmp($dist->version,$cpan_mod->inst_version)}; next if $@;'
  cmd << 'if ($res == 0) { print " -- OK : exact version already installed \n"; exit(0) } } };'
  cmd << install_perl_code('"."')
  cmd << "' /tmp/local-lib/install/#{@tarball_name} 1>#{install_log_file} 2>&1"
  
  Chef::Log.debug "cmd: [#{cmd}]"
  file "#{install_log_file}" do
    action :touch
    owner user
    group group
  end

        
  bash 'install from tarball' do
    user user
    group group
    code cmd.join(' ')
    environment cpan_env
    cwd "/tmp/local-lib/install/#{installed_module}"
  end

  install_log

end

def install_application

  cwd = @installer.cwd
  user = @installer.user
  group = @installer.group
  home = get_home

  cmd = Array.new
  cmd << local_lib_stack
  cmd << "perl -MCPAN -e '"
  cmd << install_perl_code('"."')
  cmd << "' 1>#{install_log_file} 2>&1"


  bash 'install application' do
    code cmd.join(" ")
    user user
    group group
    cwd cwd
    environment cpan_env
  end

  install_log

end

