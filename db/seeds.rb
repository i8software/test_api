# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

unless User.find_by(email: 'admin@demo.com')
	User.create(
		email: 'admin@demo.com',
		password: 'helloworld123',
		username: Faker::Internet.username,
		first_name: Faker::Name.first_name,
		last_name: Faker::Name.last_name,
	)
end

5.times do
	username = Faker::Internet.username
	User.create(
		username: username,
		first_name: Faker::Name.first_name,
		last_name: Faker::Name.last_name,
		email: Faker::Internet.free_email(username),
		password: 'helloworld123',
	)
end

users = User.where.not(email: 'admin@demo.com')
quotes = [
	Faker::FamilyGuy.quote,
	Faker::DumbAndDumber.quote,
	Faker::DrWho.quote,
	Faker::Hobbit.quote,
	Faker::HowIMetYourMother.quote,
	Faker::HitchhikersGuideToTheGalaxy.quote,
	Faker::GameOfThrones.quote,
	Faker::Friends.quote,
]

10.times do
	GeoCache.create(
		title: Faker::Book.title,
		message: [Faker::GreekPhilosophers.quote, Faker::FamousLastWords.last_words].sample,
		lat: Faker::Address.latitude,
		lng: Faker::Address.longitude,
		cacher: users.sample,
	)
end

geo_caches = GeoCache.all

30.times do
	Comment.create(
		commenter: users.sample,
		comment: quotes.sample,
		geo_cache: geo_caches.sample,
	)
end

comments = Comment.all

60.times do
	Reply.create(
		sender: users.sample,
		reply: quotes.sample,
		comment: comments.sample,
	)
end

replies = Reply.all

200.times do
	Reaction.create(
		reacted_on: [geo_caches, comments, replies].sample.sample,
		reaction: [1, -1].sample,
		reactor: users.sample,
	)
end
