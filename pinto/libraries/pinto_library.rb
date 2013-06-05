module PintoLibrary
    def pinto_home
        if node.pinto.user == 'root'
            pinto_home = '/opt/local/pinto'
        else
            pinto_home = "/home/#{node.pinto.user}/opt/local/pinto"
        end
            pinto_home
    end

    def pinto_sub_dirs
        if node.pinto.user == 'root'
            %w{ /opt /opt/local /opt/local/pinto /opt/local/pinto/bin /opt/local/pinto/misc /opt/local/pinto/misc/bin }
        else node.pinto.user == 'root'
            %w{ opt opt/local opt/local/pinto opt/local/pinto/bin opt/local/pinto/misc opt/local/pinto/misc/bin }.map do |d|
                "/home/#{node.pinto.user}/#{d}"
            end
        end
    end

    def create_pinto_sub_dirs
        log "create pinto_home sub directories"
        pinto_sub_dirs.each do |d|
            directory d do
                owner node.pinto.user
                group node.pinto.group
            end
        end
    end

    def  repo_root

        if node.pinto.user == 'root'
            repo_root = '/opt/local/pinto/var/'
        else
            repo_root = "/home/#{node.pinto.user}/opt/local/pinto/var"
        end
    end

    def pinto_user_home 
        node.pinto.user == 'root' ? nil : "/home/#{node.pinto.user}"
    end        
end

