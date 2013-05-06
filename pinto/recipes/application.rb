# installs pinto application - see https://metacpan.org/module/THALJEF/Pinto-0.082/lib/Pinto/Manual/Installing.pod#___pod


node.pinto.bootstrap.packages.each do |p|
    package p
end

execute 'curl -L http://cpanmin.us | perl - --sudo App::cpanminus'

execute 'cpanm App::Pinto --sudo'

