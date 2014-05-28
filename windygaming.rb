require 'rubygems'
require 'nokogiri'
require 'open-uri'
   
page = Nokogiri::HTML(open("http://www.windygaming.com/collections/newest-items")) 

buffer = page.css('div.product-grid-item a')

buffer.each{|name| puts name['title']}
