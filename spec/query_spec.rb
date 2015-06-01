require_relative '../tdcli'
require 'spec_helper'
require 'td'
require 'td-client'

def puts(str)
end

describe "Simple Query" do

    query = "sample_datasets www_access".split(" ")
    result = TdCLI.start(query)
    result_length = result.size
    query_length = query.size

    it "should raise" do
        expect{ TdCLI.start() }.to raise_error(TreasureData::NotFoundError)
    end
    
    it "should not raise" do
        expect(result).to_not equal(false)
    end

    it "should return correct result type" do
        expect(result).to be_instance_of(Array)
    end

    it "should return correct number of results " do
        expect(result_length).to equal(5000)
    end

    it "should should have correct number of arguments" do
        expect(query_length).to equal(2)
    end

end

describe "Complex Query" do

    query = "sample_datasets www_access -c 'host,time,path' -M 1412321162 -e presto".split(" ")
    result = TdCLI.start(query)
    result_length = result.size
    query_length = query.size

    it "should raise" do
        expect{ TdCLI.start() }.to raise_error(TreasureData::NotFoundError)
    end
    
    it "should not raise" do
        expect(result).to_not equal(false)
    end

    it "should return correct result type" do
        expect(result).to be_instance_of(Array)
    end

    it "should return correct number of results" do
        expect(result_length).to equal(19)
    end

    it "should should have correct number of arguments" do
        expect(query_length).to equal(8)
    end
end