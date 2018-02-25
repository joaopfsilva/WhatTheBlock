class PagesController < ApplicationController
	def home
		require 'open-uri'
		require 'nokogiri'

		url = "https://gastracker.io/"

		html_file = open(url).read
		html_doc = Nokogiri::HTML(html_file)

		raw_info = html_doc.search('.dl-horizontal')[1]
		@current_block_number = raw_info.text.split("\n")[2]
		@blocks_left_for_callisto = 5500000 - @current_block_number.to_i
		
		timestamp_now = Time.now.utc
		seconds_left = @blocks_left_for_callisto * 15
		@estimated_days_for_callisto = Time.at(timestamp_now + seconds_left).utc.strftime("%Y/%m/%d %H:%M:%S")


	end
end
