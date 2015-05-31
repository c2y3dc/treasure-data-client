#!/usr/bin/env ruby

require 'td'
require 'td-client'
require 'thor'

class TdCLI < Thor 
    option :column, :default => "*", :aliases => :c
    option :min, :default => "NULL", :aliases => :m
    option :MAX, :default => "NULL", :aliases => :M
    option :format, :default => "tabular", :aliases => :f
    option :engine, :default => :hive, :aliases => :e

    desc "my_default", "Where the magic happens"
    def my_default(*args)
        db_name = args[0]
        table_name = args[1]

        cln = TreasureData::Client.new(ENV['TREASURE_DATA_API_KEY'])
        # https://github.com/treasure-data/td-client-ruby/blob/master/lib/td/client.rb#L179
        job = cln.query(db_name, "SELECT #{options[:column]} FROM #{table_name} WHERE TD_TIME_RANGE(time, #{options[:min]}, #{options[:MAX]})", nil, nil, nil, {:type => options[:engine].to_sym})
        until job.finished?
            sleep 1
            job.update_progress!
        end
        job.update_status!  # get latest info
        job.result_each { |row| p row }
    end 
end
 
TdCLI.start(ARGV)

