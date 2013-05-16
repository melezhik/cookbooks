
def load_current_resource

  @installer = Chef::Resource::CpanClient.new(new_resource.name)
  @installer.name(new_resource.name)
  @installer.module_name(new_resource.module_name)
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
  force_mode = @installer.force 
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
      Chef::Log.info("force_mode: #{force_mode}")  
  
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


def sanity_string file_contents

    require 'iconv' unless String.method_defined?(:encode)
    if String.method_defined?(:encode)
      file_contents.encode!('UTF-8', 'UTF-8', :invalid => :replace)
    else
      ic = Iconv.new('UTF-8', 'UTF-8//IGNORE')
      file_contents = ic.iconv(file_contents)
    end
end

def install_log 

  my_installed_module = installed_module
  force_mode = @installer.force
  ruby_block 'validate cpan client logs' do
    block do
        print ">>> #{my_installed_module} install summary <<<\n"
        prev_line = ''
        IO.foreach(install_log_file) do |l|
            ll = sanity_string l
            print "   #{l} [#{prev_line}]\n" if /\s--\s(OK|NOT OK)/.match(ll)
            if /(Stopping: 'install' failed|won't install without force)/.match(ll)
                if force_mode == true
                    Chef::Log.warn("error occured : #{ll}[#{prev_line}]") 
                    Chef::Log.info("will continue because we are in force_mode = true mode") 
                else
                    raise "#{ll}[#{prev_line}]\n"
                end   
            end
            prev_line = ll.chomp.gsub(/^\s+/,"").gsub(/\s+$/,"")
        end
    end
  end
end



def install_perl_code install_thing = '$ARGV[0]'
    cmd = Array.new
    if @test_mode.nil?
        if @installer.force == true
            cmd << "CPAN::Shell->force(\"install\",#{install_thing})"
        else
            cmd << "CPAN::Shell->install(#{install_thing})"
        end 
    else
        cmd << "CPAN::Shell->test(#{install_thing})" 
    end
    cmd.join('; ')
end

def get_home 
  user = @installer.user
  group = @installer.group
  cpan_home = @installer.cpan_home
  home = user == 'root' ? "/root/" : ( cpan_home.nil? ? "/home/#{user}/" : cpan_home )
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
   unless install_base.nil?
       install_base.gsub!('\s','')
       install_base.chomp!
       unless /^\//.match(install_base)
         install_base = "#{@installer.cwd}/#{install_base}"
       end
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
    command 'perl -MCPAN -e "CPAN::Index->force_reload"'
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

  directory '/tmp/local-lib/' do
    owner user
    group group
  end

  directory '/tmp/local-lib/install' do
    owner user
    group group
  end
  
  file install_log_file do
    action :create
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
    action :create
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
  if /([a-z\d\.-]+)\.tar\.gz$/i.match(@installer.name) or ! @installer.from_cookbook.nil?
    installed_module = @installer.name.split('/').last
    installed_module.gsub!(' ','-')
    mat = /([a-z\d\.-]+)\.tar\.gz$/i.match(installed_module)
    if mat.nil?
        raise "distributive name #{@installer.name} does not match ([a-z\d\.-]+)\.tar\.gz$ pattern"
    end
    installed_module = mat[1]
  else
    installed_module = @installer.name
    installed_module.gsub!(' ','-')
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


def install_cpan_module args = { }

    user = @installer.user
    group = @installer.group

    cwd = args[:cwd] || @installer.cwd
    module_name = args[:module_name] || @installer.name
    module_version = args[:module_version] || @installer.version
    install_object = args[:install_object] || @installer.name

    execute  "rm #{install_log_file}" 

    if module_name != '.' 
        bash "checking if module exists at CPAN" do
            code <<-CODE
                #{local_lib_stack}
                perl -MCPAN -e '
                my $m = CPAN::Shell->expand("Module","#{module_name}");
                exit(2) unless defined $m';
            CODE
            user user
            group group
            cwd cwd
            environment cpan_env
        end
    end
 
    if @installer.version.nil? && module_name != '.' && @test_mode.nil? # not install if uptodate
        bash "installing cpan module" do
            code <<-CODE
                #{local_lib_stack}
                perl -MCPAN -e '
                my $m = CPAN::Shell->expand("Module","#{module_name}");
                if ($m->uptodate){
                     print "#{module_name} -- OK have higher or equal version [",$m->inst_version,"] [",$m->inst_file,"]\n";
                }else{
                    #{install_perl_code}
                }' #{install_object} 1>>#{install_log_file} 2>&1
            CODE
            user user
            group group
            cwd cwd
            environment cpan_env
        end
    elsif @installer.version == "0" && module_name != '.' && @test_mode.nil? # not install if any version already installed
        bash "installing cpan module" do
            code <<-CODE
                #{local_lib_stack}
                perl -MCPAN -e '
                my $m = CPAN::Shell->expand("Module","#{module_name}");
                if ($m->inst_version){
                     print "#{module_name} -- OK already installed at version [",$m->inst_version,"] [",$m->inst_file,"]\n";
                }else{
                    #{install_perl_code}
                }' #{install_object} 1>>#{install_log_file} 2>&1
            CODE
            user user
            group group
            cwd cwd
            environment cpan_env
        end
    elsif @installer.version != "0" && module_name != '.' && @test_mode.nil? # not install if have higher or equal version
        v = @installer.version
        bash "installing cpan module" do
            code <<-CODE
                #{local_lib_stack}
                perl -MCPAN -MCPAN::Version -e '
                my $m = CPAN::Shell->expand("Module","#{module_name}");
                my $inst_v = CPAN::Shell->expand("Module","#{module_name}")->inst_version;
                my $version_required = "#{module_version}";
                s/\s//g for $version_required;
                my $exact_version_check = 0;
                if ($version_required=~/=/){
                    $exact_version_check =  1;
                    s/=//g for $version_required;
                }
                
                if ($exact_version_check == 0 && CPAN::Version->vcmp($inst_v, $version_required) >= 0){
                    print "#{module_name} -- OK : have higher or equal version [$inst_v] [",$m->inst_file,"]\n";
                }elsif($exact_version_check == 1 &&  CPAN::Version->vcmp($inst_v, $version_required) == 0){
                    print "#{module_name} -- OK : have equal version [$inst_v] [",$m->inst_file,"]\n";
                }else{
                    #{install_perl_code}
                }' #{install_object} 1>>#{install_log_file} 2>&1
            CODE
            user user
            group group
            cwd cwd
            environment cpan_env
        end
  elsif ! @test_mode.nil? && @test_mode == 1
      bash 'running tests on cpan module' do
            code <<-CODE
                #{local_lib_stack}
                perl -MCPAN -e '
                #{install_perl_code}' #{install_object} 1>>#{install_log_file} 2>&1
            CODE
            user user
            group group
            cwd cwd
            environment cpan_env
      end
  elsif module_name == '.'
      bash 'installing cpan module as cpan_client .' do
            code <<-CODE
                #{local_lib_stack}
                perl -MCPAN -e '
                #{install_perl_code}' #{install_object} 1>>#{install_log_file} 2>&1
            CODE
            user user
            group group
            cwd cwd
            environment cpan_env
      end
  else
      raise "bad version : #{@installer.version}"      
  end

  install_log

end

def install_tarball

  cwd = @installer.cwd
  user = @installer.user
  group = @installer.group
  
  Chef::Log.debug "installed_module: #{installed_module}"

  execute "rm -rf /tmp/local-lib/install/#{installed_module}/"
  
  if @installer.name.match('^http:\/\/')
    tarball_name = @installer.name.split('/').last
    execute "rm -rf /tmp/local-lib/install/#{tarball_name}"
    source_name = @installer.name
    Chef::Log.debug "tarball_name: #{tarball_name}"
    remote_file "/tmp/local-lib/install/#{tarball_name}" do
        source source_name
        mode "0644"
        owner user
        group group
    end        
  else
    tarball_name = @installer.name
    from_cookbook = @installer.from_cookbook
    execute "rm -rf /tmp/local-lib/install/#{tarball_name}"
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

  install_cpan_module({
    :cwd => "/tmp/local-lib/install/#{installed_module}", 
    :install_object => '.', 
    :module_name => @installer.module_name || '.'
  })

end

def install_application

  install_cpan_module({
    :cwd => @installer.cwd, 
    :install_object => '.', 
    :module_name => '.'
  })


end

