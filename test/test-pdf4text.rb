# -*- coding: utf-8 -*-

class PDF4TextTest < Test::Unit::TestCase
  include Rack::Test::Methods

  def app
    @app ||= Rack::Builder.parse_file(File.join(base_dir, "config.ru")).first
  end

  def setup
    header "Content-Type", "application/json"
  end

  def test_root
    get "/"
    assert_true(last_response.ok?)
  end

  def test_json
    get "/json", :uri => File.join(fixtures_dir, "sample.pdf")
    assert_true(last_response.ok?)
    assert_match(/[\"秋\\n?\"]/, last_response.body)
  end

  private
  def base_dir
    File.expand_path(File.join(File.dirname(__FILE__), ".."))
  end

  def test_dir
    File.join(base_dir, "test")
  end

  def fixtures_dir
    File.join(test_dir, "fixtures")
  end
end
