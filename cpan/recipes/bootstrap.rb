include_recipe 'cpan'

node.cpan_client.bootstrap.packages.each  { |p| package p } 

execute 'curl -L http://cpanmin.us | perl - --sudo App::cpanminus'

node.cpan_client.bootstrap.cpan_packages.each  do |m|
    execute "cpanm #{m}" do
        user 'root'
        group 'root'
  end
end

