require 'spec_helper'

describe "Static pages" do
  include ApplicationHelper 

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
    before { visit about_path }

    it { should have_selector('h1', :text => 'About') }
    it { should have_title(full_title('About')) }
  end
end
