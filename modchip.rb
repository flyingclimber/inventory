require 'rubygems'
require 'nokogiri'
require 'open-uri'

item_url =
  'http://www.segastyle.com/store/index.php?' \
    'route=product/product&product_id=76'

page = Nokogiri::HTML(open(item_url))

buffer = page.css('div.description span:nth-child(3)')[0]
    .next_sibling.text.strip.gsub(/\n  +/, "\n")

puts item_url if buffer.include? 'In Stock'
