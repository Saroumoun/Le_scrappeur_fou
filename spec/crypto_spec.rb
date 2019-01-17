require_relative '../lib/crypto'

describe "the crypto_master method" do
  it "should return an array" do
    expect(crypto_master).to be_instance_of Array
  end
  it "should not be nil" do 
  	expect(crypto_master).not_to be_nil
  end

end
