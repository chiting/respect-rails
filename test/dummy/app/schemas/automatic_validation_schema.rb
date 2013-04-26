class AutomaticValidationSchema < ApplicationSchema
  def basic_get
    request do
      params do |s|
        s.integer "param1", equal_to: 42 do |m|
          m.title "A parameter"
          m.description do
            "An important parameter that should be equal to 42."
          end
        end
      end
    end
    response_for do |status|
      status.ok do
        body_with_object do |s|
          s.integer "id", equal_to: 42
        end
      end
    end
  end

  def raise_no_method_error
    raise NoMethodError, "user has raised NoMethodError"
  end

  def raise_name_error
    raise NameError, "user has raised a NameError"
  end

  def no_request_schema
    response_for do |status|
      status.ok do
        body_with_object do |s|
          s.integer "id", equal_to: 42
        end
      end
    end
  end

  def response_schema_from_file
    # - No request schema defined.
    # - Response for status ok is defined in the associated file.
  end

  def response_schema_from_file_unknown_status
    # - No request schema defined.
    # - Response for status ok is defined in the associated file.
  end

  def route_constraints
    request do
      params do |s|
        s.string "param1", equal_to: "42"
      end
    end
  end

  def composite_custom_types
    request do
      params do |s|
        s.circle "circle"
      end
    end
  end

  def default_response_schema_in_file
    # - No request schema defined.
    # - Default response for :ok is defined in automatic_validation/default_response_in_file.schema
  end

end
