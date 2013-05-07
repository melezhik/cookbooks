# installs pinto application - see https://metacpan.org/module/THALJEF/Pinto-0.082/lib/Pinto/Manual/Installing.pod#___pod

node.pinto.bootstrap.packages.each do |p|
    package p
end

directory node.pinto.bootstrap.home do
    recursive true
    owner node.pinto.bootstrap.user
    group node.pinto.bootstrap.group
end

#cd ~/bin
#    curl -LO http://xrl.us/cpanm
#    chmod +x cpanm


# execute 'cpanm App::Pinto --sudo'

