require_relative '../lib/deputy'

describe "the join_name_and_email method" do
  it "should return an array" do
    expect(join_name_and_email).to be_instance_of Array
  end
  it "should not be nil" do 
  	expect(join_name_and_email).not_to be_nil
  end

end