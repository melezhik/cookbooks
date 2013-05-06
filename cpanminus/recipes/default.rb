node.cpanminus.bootstrap.packages.each do |p|
    package p
end
execute "curl -L #{node.cpanminus.bootstrap.download_url} | perl - --sudo App::cpanminus"


