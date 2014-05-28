require 'rubygems'
require 'nokogiri'
require 'open-uri'
require 'json'

stock_file = "stock"
windy_url = "http://www.windygaming.com"

if File.file?(stock_file)
    stock = JSON.parse(IO.read(stock_file))
    found_stock = true
end

page = Nokogiri::HTML(open("http://www.windygaming.com/collections/newest-items")) 

buffer = page.css('div.product-grid-item a')
if found_stock
    if stock["1"] != buffer[0]["title"] or
        stock["2"] != buffer[2]["title"] or
        stock["3"] != buffer[4]["title"]
            print "New Items Found!\n"
            puts buffer[0]["title"], windy_url + buffer[0]["href"]
            puts buffer[2]["title"], windy_url + buffer[2]["href"]
            puts buffer[4]["title"], windy_url + buffer[4]["href"]
    end
end

my_hash = {:"1" => buffer[0]["title"],
           :"2" => buffer[2]["title"],
           :"3" => buffer[4]["title"]}

json = JSON.pretty_generate(my_hash)

File.open('stock',"w") do |f|
    f.write(json)
end