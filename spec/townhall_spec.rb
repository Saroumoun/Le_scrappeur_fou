require_relative '../lib/townhall'

describe "the get_townhall_email method" do
  it "should return an array" do
    expect(get_townhall_email("http://www.annuaire-des-mairies.com/95/ableiges.html")).to be_instance_of Array
  end
  it "should not be nil" do 
  	expect(get_townhall_email("http://www.annuaire-des-mairies.com/95/ableiges.html")).not_to be_nil
  end

end