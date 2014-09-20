module MolAssertions
  def assert_layout(lay)
    assert_equal 'layouts/'+lay, @response.layout
  end

  def assert_assigns(key, expected_value=nil)
    actual_value = assigns(key)
    if expected_value
      assert_equal expected_value, actual_value, %{
        Expected `assigns(:#{key})` to be `#{expected_value.inspect}`,
        but it was: #{actual_value.inspect}
      }.squish!
    else
      assert_not_nil actual_value,
        "Expected `assigns(:#{key})` to be set, but it was nil"
    end
  end

  def assert_content_type(ext)
    assert_equal(
      Mime::Type.lookup_by_extension(ext.to_s),
      @response.content_type
    )
  end

  def assert_json_contains(key, expected_value=nil)
    @_json ||= ActiveSupport::JSON.decode(@response.body)
    actual_value = @_json[key.to_s]

    if expected_value.nil? # Any non-nil value expected
      assert_not_nil actual_value,
        %{Expected JSON response's key `#{key}` to be set, but it was nil}
    elsif expected_value.respond_to?(:match) &&
          expected_value.respond_to?(:source)
      assert_match expected_value, actual_value, %{
        Expected JSON response's key `#{key}`
        to match /#{expected_value.source}/, but it was: #{actual_value}
      }.squish!
    else
      assert_equal expected_value, actual_value, %{
        Expected JSON response's key `#{key}`
        to equal "#{expected_value}", but it was: #{actual_value}
      }.squish!
    end
  end

  def assert_flash(type, expected_value=nil)
    # Usage:
    # assert_flash :notice, /has been saved/

    expected_types = [:notice, :alert]
    unless expected_types.include?(type)
      raise 'assert_flash: `type` should be one of: ' +
        expected_types.map { |type| ":#{type}" }.join(', ') and return
    end

    if expected_value.present?
      assert_match expected_value, flash[type]
    else
      assert flash[type].present?,
        "Expected `flash[:#{type}]` to be present, but it was blank"
    end

    (expected_types - [type]).each do |other_type|
      assert flash[other_type].blank?, %{
        Expected `flash[:#{other_type}]` to be blank, but it was:
        #{flash[other_type]}
      }.squish!
    end
  end

end
