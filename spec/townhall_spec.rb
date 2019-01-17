require_relative '../lib/townhall'

describe "the caesar_cipher method" do
  it "should modify the words into caesar alphabet" do
    expect(caesar_cipher("abc", 1)).to eq("bcd")
  end
end