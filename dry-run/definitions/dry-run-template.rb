define :dry_run_template do

 dry_run_conf = "#{node.dryrun.dir}/#{File.basename(params[:name])}"

 template dry_run_conf do
   source    params[:source]
   mode params[:mode] unless params[:source].nil?
   owner params[:owner] unless params[:owner].nil?
   group params[:group] unless params[:group].nil?
 end

  
  dry_run_stat = "#{dry_run_conf}.stat"
  dry_run_diff = "#{dry_run_conf}.diff"

  ruby_block 'create dry-run-stat file' do
    block do
      File.open(dry_run_stat,"w") do |log|
        log.puts("WOULD install config into #{params[:name]}")
      end
    end
  end


  ruby_block "dry-run install" do
    block do
      if ! File.directory?(File.dirname(params[:name]))
        File.open(dry_run_stat,"a") do |log| 
          log.puts("WOULD create directory #{params[:name]}")
        end
      end
      if File.exist?(params[:name])
          stat1 = `stat --format '%A|%U|%G' #{params[:name]}`.chomp!
          stat2 = `stat --format '%A|%U|%G' #{dry_run_conf}`.chomp! 
          if  stat1 != stat2 
            File.open(dry_run_stat,"a") do |log| 
              log.puts("WOULD change access rights from #{stat1} to #{stat2}")
            end
          end 
      else
        File.open(dry_run_stat,"a") do |log| 
          log.puts("WOULD create NEW config (current one does not exist)")
        end
      end
    end
    action :create
  end



  ruby_block "dry-run-diff" do
    block do
      if File.exist?("#{params[:name]}")
        system("diff -u -B -w  #{dry_run_conf} #{params[:name]} > #{dry_run_diff}")
        if File.size?(dry_run_diff)
          File.open(dry_run_stat,"a") do |log| 
            log.puts("WOULD change current config --- see #{dry_run_diff}")
          end
        else
          File.open(dry_run_stat,"a") do |log| 
            log.puts("WOULD*NOT change current config")
          end
        end
      end
    end
    action :create
  end

  ruby_block 'dry-run-info' do
    block do
      puts '*******'  
      IO.foreach(dry_run_stat) {|line| puts " +++ #{line}" }
      puts '*******'  
    end
  end

end
