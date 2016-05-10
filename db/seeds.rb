# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
require 'open-uri'

page = Nokogiri::HTML(open('http://4flaga.ru/d_1_1000.html'))
original = page.css('p.newsgr a').children.map(&:text).map(&:strip)
translated =
  page.css('.newsgr a').map { |v| v.next_sibling().text.sub(' -', '') }
  .map(&:strip)
ziped = original.zip(translated)
vocabulary = ziped.map { |v| [:original_text, :translated_text].zip(v).to_h }
vocabulary.each { |v| Card.create(v) }
