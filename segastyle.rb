#!/usr/bin/ruby

=begin
    segastyle.rb - Checks for new items on windygaming.com

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

item_url = 'http://www.segastyle.com/store/index.php?' \
    'route=product/product&product_id=76'

page = Nokogiri::HTML(open(item_url))

buffer = page.css('div.description span:nth-child(3)')[0]
    .next_sibling.text.strip.gsub(/\n  +/, "\n")

puts item_url if buffer.include? 'In Stock'
