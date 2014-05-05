module Tyto
  class Entity
    include ActiveModel::Validations

    def initialize(attrs=nil)
      attrs && attrs.each do |attr_name, value|
        getter = "#{attr_name}"
        next unless self.class.method_defined?(getter)
        var_name = "@#{attr_name}"
        self.instance_variable_set(var_name, value)
      end
    end
  end
end
