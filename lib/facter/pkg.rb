# Cody Herriges <cody@puppetlabs.com>
#
# Collects and creates a fact for every package installed on the system and
# returns that package's version as the fact value.  Useful for doing package
# inventory and making decisions based on installed package versions.

require 'facter/util/pkg'

counter_hash = {}
Facter::Util::Pkg.package_list.each do |key, value|
  if counter_hash[:"#{key}"].nil?
    counter_hash[:"#{key}"] = value
  else
    counter_hash[:"#{key}"] << ", #{value}"
  end
end

counter_hash.each do |key, value|
  Facter.add(:"pkg_#{key}") { setcode { value } }
end
