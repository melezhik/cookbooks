#
# Cookbook Name:: cpan
# Library:: matchers
#

if defined?(ChefSpec)
  def install_cpan_module(resource_name)
    ChefSpec::Matchers::ResourceMatcher.new(:cpan_client, :install, resource_name)
  end

  def test_cpan_module(resource_name)
    ChefSpec::Matchers::ResourceMatcher.new(:cpan_client, :test, resource_name)
  end
 
  def reload_cpan_index(resource_name)
    ChefSpec::Matchers::ResourceMatcher.new(:cpan_client, :reload_cpan_index, resource_name)
  end
end
