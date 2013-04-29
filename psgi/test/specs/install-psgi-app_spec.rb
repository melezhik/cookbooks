class PsgiSpec < MiniTest::Chef::Spec
  it "installs init script file" do
    file("/tmp/psgi/app").must_exists
  end
end
