# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
require 'open-uri'

page = Nokogiri::HTML(open('http://4flaga.ru/d_1_1000.html'))
page.css('p.newsgr a').each do |v|
  original = v.text.strip
  translated = v.next_sibling.text.sub(' -', '').strip
  Card.create(original_text: original, translated_text: translated)
end
# vocabulary = ziped.map { |v| [:original_text, :translated_text].zip(v).to_h }
# vocabulary.each { |v| Card.create(v) }
