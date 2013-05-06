class CpanClientSpec < MiniTest::Chef::Spec
  it "updates Metadata file" do
        file("/root/.cpan/Metadata").must_be_modified_after(run_status.start_time)
  end
end

