#!/usr/bin/ruby

require 'rubygems'
require 'nokogiri'
require 'open-uri'
require 'json'

stock_file = 'stock'
windy_url = 'http://www.windygaming.com'
windy_new = 'http://www.windygaming.com/collections/newest-items'

stock = JSON.parse(IO.read(stock_file)) if File.file?(stock_file)

page = Nokogiri::HTML(open(windy_new))

buffer = page.css('div.product-grid-item a')
if stock
  if stock['1'] != buffer[0]['title'] ||
     stock['2'] != buffer[2]['title'] ||
     stock['3'] != buffer[4]['title']
    puts "New Items Found!\n\n"
    (0..11).each do |i|
      puts buffer[i * 2]['title'], windy_url + buffer[i * 2]['href'], "\n"
    end
  end
end

my_hash = { :"1" => buffer[0]['title'],
            :"2" => buffer[2]['title'],
            :"3" => buffer[4]['title'] }

json = JSON.pretty_generate(my_hash)

File.open(stock_file, 'w') do |f|
  f.write(json)
end
