#!/usr/bin/env ruby

require 'td'
require 'td-client'
cln = TreasureData::Client.new(ENV['TREASURE_DATA_API_KEY'])
job = cln.query('testdb', 'SELECT COUNT(1) FROM www_access')
until job.finished?
  sleep 2
  job.update_progress!
end
job.update_status!  # get latest info
job.result_each { |row| p row }

