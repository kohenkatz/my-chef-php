# Chef 0.10.10 or greater
default_action :install_composer

# In earlier versions of Chef the LWRP DSL doesn't support specifying
# a default action, so you need to drop into Ruby.
def initialize(*args)
  super
  @action = :install_composer
end

actions :install_composer, :install_packages, :create_project

attribute :project_path, :kind_of => [String, NilClass], :name_attribute => true

# For `composer create-project`
attribute :project, :kind_of => [String, NilClass]
attribute :stability, :kind_of => [Symbol], :default => :stable, :equal_to => [:dev, :alpha, :beta, :RC, :stable]
