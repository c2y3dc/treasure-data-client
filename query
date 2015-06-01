#!/usr/bin/env ruby

require 'td'
require 'td-client'
require 'thor'
require 'terminal-table'
require 'csv'

class TdCLI < Thor
    default_task :my_default
    
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

            # See if it's CSV or tabular and ouput it
            if options[:format] == "csv"
                csv_string = CSV.generate do |csv|
                    job.result_each { |row| csv << row }
                end
                puts options[:column] #headings
                puts csv_string
            else
                puts Terminal::Table.new :rows => job.result, :headings => options[:column].split(',')
            end
        end 

        # Work around for running Thor without explicitly calling method
        def method_missing(method, *args)
            args = ["my_default", method.to_s] + args
            TdCLI.start(args)
        end
end
 
TdCLI.start(ARGV)

