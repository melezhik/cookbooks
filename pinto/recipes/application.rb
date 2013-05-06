# installs pinto application - see https://metacpan.org/module/THALJEF/Pinto-0.082/lib/Pinto/Manual/Installing.pod#___pod
include_recipe 'cpanminus'
execute 'cpanm App::Pinto --sudo'

