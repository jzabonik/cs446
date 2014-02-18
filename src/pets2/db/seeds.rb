# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

Animal.delete_all
Animal.create!(name: 'Tomcat Brady',
  breed: 'Cat',
  gender: 'Male',
  age: '2 Months',
  habits: 
    %{<p>
        What a little cutie! Mr. Brady enjoys watching football on Sundays
		and really gets into the games. Already litterboxed trained, this
		little guy is ready to go.
      </p>},
  status: 'Fostered',
  image_url:   'kitten1.jpg')
# . . .
Animal.create!(name: 'Feral Owens',
  breed: 'Lion',
  gender: 'Male',
  age: '3 Years',
  habits: 
    %{<p>
        In his spare time, Feral Owens likes getting into fights with tigers.
		He is extremely aggressive and will rip your head off if you are not
		careful. However, if you are looking for that sort of thing, he is the
		perfect pet for you. I'm not sure why we have him at our facility...
      </p>},
  status: 'Available',
  image_url:   'lion1.jpg')
# . . .

Animal.create!(name: 'Bulldozer',
  breed: 'Dog',
  gender: 'Female', 
  age: '4 Months',
  habits: 
    %{<p>
        Despite her masculine name, Bulldozer is a little sweetheart. Given the
		opportunity, she won't hesitate to snuggle up to you. She loves sitting
		next to the fire and just getting cozzy. A very relaxing and calm girl
		ready to be loved.
      </p>},
  status: 'Available',
  image_url:   'puppy1.jpg')
  # . . .

Animal.create!(name: 'Quincy',
  breed: 'Duck',
  gender: 'Female',
  age: '3 Weeks',
  habits: 
    %{<p>
        Quincy the duck enjoys splashing around in shallow water. She loves eating
		small pieces of bread in the park during a bright, sun-shining day. Quincy
		is a brave little adventurer who will explore the space around her.
      </p>},
  status: 'Available',
  image_url:   'duck1.jpg')