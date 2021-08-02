# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

# Seed using the given API

require 'open-uri'
require 'json'

puts 'Reset Database...'

Movie.destroy_all

puts 'Parsing movies from themoviedb API'

url = 'http://tmdb.lewagon.com/movie/top_rated'

10.times do |i|
  puts "IMPORTING MOVIES FROM PAGE #{i + 1}"
  movies = JSON.parse(open("#{url}?page=#{i + 1}").read)['results']
  movies.each do |movie|
    puts "Creating #{movie['title']}"
    base_poster_url = 'https://image.tmdb.org/t/p/w500'
    Movie.create(
      title: movie['title'],
      overview: movie['overview'],
      poster_url: "#{base_poster_url}#{movie['backdrop_path']}"
    )
  end
end

puts 'Movies created!'
