
require File.expand_path("../test_helper", __FILE__)

class NotTest < AttrSearchable::TestCase
  def test_not_string
    expected = FactoryGirl.create(:product, :title => "Expected title")
    rejected = FactoryGirl.create(:product, :title => "Rejected title")

    results = Product.search("title: Title NOT title: Rejected")

    assert_includes results, expected
    refute_includes results, rejected

    assert_equal results, Product.search("title: Title -title: Rejected")
  end

  def test_not_hash
    expected = FactoryGirl.create(:product, :title => "Expected title")
    rejected = FactoryGirl.create(:product, :title => "Rejected title")

    results = Product.search(:and => [{:title => "Title"}, {:not => {:title => "Rejected"}}])

    assert_includes results, expected
    refute_includes results, rejected
  end
end

