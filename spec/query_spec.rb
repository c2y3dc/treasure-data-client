require_relative '../tdcli'
require 'spec_helper'
require 'td'
require 'td-client'

def puts(str)
end

describe "Query" do
    query1 = "sample_datasets www_access".split(" ")

    query2 = "sample_datasets www_access -c 'host,time,path' -M 1412321162 -e presto".split(" ")
    result1 = TdCLI.start(query1)
    result1_length = result1.size
    result2 = TdCLI.start(query2)
    result2_length = result2.size
    query1_length = query1.size
    query2_length = query2.size

    it "should raise" do
        expect{ TdCLI.start() }.to raise_error(TreasureData::NotFoundError)
    end
    
    it "should not raise" do
        expect(result1).to_not equal(false)
    end

    it "should return correct result type" do
        expect(result1).to be_instance_of(Array)
    end

    it "should return correct result type (alt case)" do
        expect(result2).to be_instance_of(Array)
    end

    it "should return correct number of results " do
        expect(result1_length).to equal(5000)
    end

    it "should return correct number of results (alt case)" do
        expect(result2_length).to equal(19)
    end

    it "should should have correct number of arguments" do
        expect(query1_length).to equal(2)
    end

    it "should should have correct number of arguments (alt)" do
        expect(query2_length).to equal(8)
    end

end