#!/usr/bin/ruby

=begin
    windygaming.rb - Checks for new items on windygaming.com

    Copyright (C) 2014, Tomasz Finc <tomasz@gmail.com>

    This program is free software; you can redistribute it and/or modify
    it under the terms of the GNU General Public License as published by
    the Free Software Foundation; either version 2 of the License, or
    (at your option) any later version.

    This program is distributed in the hope that it will be useful,
    but WITHOUT ANY WARRANTY; without even the implied warranty of
    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
    GNU General Public License for more details.

    You should have received a copy of the GNU General Public License along
    with this program; if not, write to the Free Software Foundation, Inc.,
    51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
=end

require 'rubygems'
require 'nokogiri'
require 'open-uri'
require 'json'

stock_file = 'stock'
windy_url = 'http://www.windygaming.com'
windy_new = '/collections/newest-items'
threshold = 6
items_total = 10
items_start = 0

stock = JSON.parse(IO.read(stock_file)) if File.file?(stock_file)

page = Nokogiri::HTML(open(windy_url + windy_new))

buffer = page.css("a[class=product-link]")

if stock
  found = 0
  (items_start..items_total).each do |i|
    if stock[i] != buffer[i]['title']
      found += 1
    end
  end
  if found >= threshold
    puts "New Items Found!\n\n"
    (items_start..items_total).each do |i|
      puts buffer[i]['title'], windy_url + buffer[i]['href'], "\n"
    end
  end
end

my_array = []

(items_start..items_total).each do |i|
  my_array[i] = buffer[i]['title']
end

json = JSON.generate(my_array)

File.open(stock_file, 'w') do |f|
  f.write(json)
end
