#!/usr/bin/env ruby

require 'td'
require 'td-client'
require 'thor'

cln = TreasureData::Client.new(ENV['TREASURE_DATA_API_KEY'])
job = cln.query('testdb', 'SELECT COUNT(1) FROM www_access')
until job.finished?
  sleep 2
  job.update_progress!
end
job.update_status!  # get latest info
job.result_each { |row| p row }
 
class MyCLI < Thor
    class_option :verbose, :type => :boolean

    desc "hello NAME", "say hello to NAME"
    option :from, :default => "Ervin"
    option :yell, :type => :boolean
    def hello(name)
        puts "> saying hello" if options[:verbose]
        output = []
        output << "from: #{options[:from]}" if options[:from]
        output << "Hello #{name}"
        output = output.join("\n")
        puts options[:yell] ? output.upcase : output
        puts "> done saying hello" if options[:verbose]
    end
    
    desc "goodbye", "say goodbye to the world"
    def goodbye
        puts "> saying goodbye" if options[:verbose]
        puts "Goodbye World"
        puts "> done saying goodbye" if options[:verbose]
    end
end
 
MyCLI.start(ARGV)
