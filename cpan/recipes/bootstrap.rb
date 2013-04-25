include_recipe 'cpan'
package 'curl'
execute 'curl -L http://cpanmin.us | perl - --sudo App::cpanminus'
node.cpan_client.bootstrap.deps.each  do |m|
    execute "cpanm #{m}" do
    user root
    group root
  end
end

