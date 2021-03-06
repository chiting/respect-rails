require "test_helper"

class ResponseHelperTest < Test::Unit::TestCase
  def test_successful_response_validation
    response = Object.new
    response.extend(Respect::Rails::ResponseHelper)
    body = ""
    schema = mock()
    response.stubs(:schema).with().returns(schema)
    response.stubs(:content_type).with().returns(Mime::JSON)
    schema.stubs(:validate?).with(response).returns(true).once
    Benchmark.stubs(:realtime).with().yields().returns(1.2345) # 1234.5 seconds.
    Rails.logger.stubs(:info).with("  Response validation: success (1234.5ms)").once
    assert_nothing_raised do
      response.validate_schema
    end
  end

  def test_failed_response_validation
    response = Object.new
    response.extend(Respect::Rails::ResponseHelper)
    body = ""
    schema = mock()
    response.stubs(:schema).with().returns(schema)
    response.stubs(:content_type).with().returns(Mime::JSON)
    schema.stubs(:validate?).with(response).returns(false).once
    error = RuntimeError.new("test error")
    error.stubs(:context).with().returns(["foo", "bar"])
    schema.stubs(:last_error).with().returns(error)
    Benchmark.stubs(:realtime).with().yields().returns(1.2345) # 1234.5 seconds.
    Rails.logger.stubs(:info).with("  Response validation: failure (1234.5ms)").once
    Rails.logger.stubs(:info).with("    foo").once
    Rails.logger.stubs(:info).with("    bar").once
    begin
      response.validate_schema
      assert false, "nothing raised"
    rescue RuntimeError => e
      assert_equal error, e
    end
  end

  def test_none_response_validation
    response = Object.new
    response.extend(Respect::Rails::ResponseHelper)
    body = ""
    schema = mock()
    response.stubs(:schema).with().returns(nil)
    response.stubs(:body).with().never
    response.stubs(:content_type).with().never
    schema.stubs(:validate?).never
    Benchmark.stubs(:realtime).with().yields().returns(1.2345) # 1234.5 seconds.
    ::Rails.logger.stubs(:info).with("  Response validation: none (1234.5ms)").once
    assert_nothing_raised do
      response.validate_schema
    end
  end

  def test_response_validation_schema_query_on_success
    response = Object.new
    response.extend(Respect::Rails::ResponseHelper)
    response.stubs(:validate_schema).returns(true)
    assert_equal(true, response.validate_schema?)
  end

  def test_response_validation_schema_query_on_failure
    error = mock()
    error.stubs(:context).returns([])
    response = Object.new
    response.extend(Respect::Rails::ResponseHelper)
    response.stubs(:validate_schema).raises(Respect::Rails::ResponseValidationError.new(error, :body, {}))
    assert_equal(false, response.validate_schema?)
  end
end
