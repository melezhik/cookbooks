# installs pinto application - see https://metacpan.org/module/THALJEF/Pinto-0.082/lib/Pinto/Manual/Installing.pod#___pod
include_recipe 'cpanminus'


node.pinto.bootstrap.packages.each do |p|
    package p
end

execute 'cpanm Pinto --sudo'

