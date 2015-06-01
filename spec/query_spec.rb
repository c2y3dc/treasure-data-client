require_relative '../query'
require 'spec_helper'

describe Query do
    it "should raise" do
        expect(TdCLI.start()).to raise_error("Query Failed")
    end

    it "should not raise" do
        expect(TdCLI.start("sample_datasets www_access")).to_not raise_error("Query Failed")
    end
end