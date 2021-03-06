require "test_helper"

class ActionSchematest < ActiveSupport::TestCase
  test "instantiating from controller do not catch NoMethodError" do
    assert_raise(NoMethodError) do
      Respect::Rails::ActionSchema.from_controller(:automatic_validation, :raise_no_method_error)
    end
  end

  test "instantiating from controller do not catch NameError" do
    assert_raise(NameError) do
      Respect::Rails::ActionSchema.from_controller(:automatic_validation, :raise_name_error)
    end
  end

  test "has_schema" do
    assert(!Respect::Rails::ActionSchema.from_controller(:automatic_validation, :no_schema_at_all))
    assert(Respect::Rails::ActionSchema.from_controller(:automatic_validation, :no_request_schema).has_schema?)
    assert(Respect::Rails::ActionSchema.from_controller(:automatic_validation, :only_documentation).has_schema?)
  end
end
