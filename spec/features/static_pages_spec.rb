require 'spec_helper'

describe "Static pages" do

  subject { page }

  describe "Home page" do
    before { visit root_path }
    let(:heading)    { 'IdeaSpark' }
    let(:page_title) { '' }

    describe "without login" do
      it { should have_title('IdeaSpark') }
    end
  end

  describe "About page" do
  end
end
