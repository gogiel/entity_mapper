# This file is autogenerated. Do not edit it by hand. Regenerate it with:
#   srb rbi gems

# typed: strong
#
# If you would like to make changes to this file, great! Please create the gem's shim here:
#
#   https://github.com/sorbet/sorbet-typed/new/master?filename=lib/concord/all/concord.rbi
#
# concord-0.1.5
class Concord < Module
  def define_equalizer; end
  def define_initialize; end
  def define_readers; end
  def included(descendant); end
  def initialize(*names); end
  def instance_variable_names; end
  def names; end
  extend Adamantium::ClassMethods
  extend Adamantium::Flat
  extend Adamantium::ModuleMethods
  extend Memoizable::ModuleMethods
  include Adamantium
  include Adamantium::Flat
  include Equalizer::Methods
  include Memoizable
end
class Concord::Public < Concord
  def included(descendant); end
end
