site :opscode

metadata

cookbook 'cpan', git: 'https://github.com/melezhik/cookbooks.git', rel: 'cpan'

cookbook 'test', path: "#{Dir.pwd}/test"

group :integration do
  cookbook "minitest-handler"
end



