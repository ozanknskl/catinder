require 'test_helper'

class CatsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @cat = cats(:one)
  end

  test "should get index" do
    get cats_url
    assert_response :success
  end

  test "should get new" do
    get new_cat_url
    assert_response :success
  end

  test "should create cat" do
    assert_difference('Cat.count') do
      post cats_url, params: { cat: { about: @cat.about, age: @cat.age, cat_type_id: @cat.cat_type_id, color: @cat.color, health: @cat.health, hyperactivity: @cat.hyperactivity, location_id: @cat.location_id, name: @cat.name, user_id: @cat.user_id } }
    end

    assert_redirected_to cat_url(Cat.last)
  end

  test "should show cat" do
    get cat_url(@cat)
    assert_response :success
  end

  test "should get edit" do
    get edit_cat_url(@cat)
    assert_response :success
  end

  test "should update cat" do
    patch cat_url(@cat), params: { cat: { about: @cat.about, age: @cat.age, cat_type_id: @cat.cat_type_id, color: @cat.color, health: @cat.health, hyperactivity: @cat.hyperactivity, location_id: @cat.location_id, name: @cat.name, user_id: @cat.user_id } }
    assert_redirected_to cat_url(@cat)
  end

  test "should destroy cat" do
    assert_difference('Cat.count', -1) do
      delete cat_url(@cat)
    end

    assert_redirected_to cats_url
  end
end
