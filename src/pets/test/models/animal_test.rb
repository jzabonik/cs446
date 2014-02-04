require 'test_helper'

class AnimalTest < ActiveSupport::TestCase
	fixtures :animals

	test "animal attributes must not be empty" do
		animal = Animal.new
		assert animal.invalid?
		assert animal.errors[:name].any?
		assert animal.errors[:breed].any?
		assert animal.errors[:gender].any?
		assert animal.errors[:age].any?
		assert animal.errors[:habits].any?
		assert animal.errors[:image_url].any?
	end
	
	test "animal is not valid without a unique name" do
		animal = Animal.new(name: animals(:monkey).name,
		breed: "y",
		gender: "yy",
		age: "1 Month",
		habits: "yyy",
		image_url: "fred.gif")
		assert animal.invalid?
		assert_equal ["has already been taken"], animal.errors[:name]
	end
	
	def new_product(image_url)
		Animal.new(name: "My Animal Name",
		breed: "Animal Type",
		gender: "Guy or Girl",
		age: "Young or Old",
		habits: "They do stuff",
		image_url: image_url)
	end
	test "image url" do
		ok = %w{ fred.gif fred.jpg fred.png FRED.JPG FRED.Jpg
				http://a.b.c/x/y/z/fred.gif }
		bad = %w{ fred.doc fred.gif/more fred.gif.more }
		ok.each do |name|
			assert new_product(name).valid?, "#{name} should be valid"
		end
		bad.each do |name|
			assert new_product(name).invalid?, "#{name} shouldn't be valid"
		end
	end
end
