require 'spec_helper'

describe "AuthenticationPages" do
  describe "GET /authentication_pages" do
    it "works! (now write some real specs)" do
      # Run the generator again with the --webrat flag if you want to use webrat methods/matchers
      get authentication_pages_index_path
      expect(response.status).to be(200)
    end
  end
end
