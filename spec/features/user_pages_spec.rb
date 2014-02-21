require 'spec_helper'

describe "User pages" do
  include  ApplicationHelper

  subject { page }

  describe "profile page" do
    let(:user) { FactoryGirl.create(:user) }
    before { visit profile_path }

    it { should have_content(user.name) }
    it { should have_title(user.name) }
  end

  describe "signup page" do
    before do
      visit about_path
      visit signup_path
    end

    let(:submit) { "Sign up" }

    it { should have_content('Sign up') }
    it { should have_title(full_title('Sign up')) }
    
    describe "with invalid information" do
      before { click_button submit }
      
      describe "should not create a user" do
        it { should_not change(User, :count) }
        
        describe "after submission" do
          it { should have_title('Sign up') }
          it { should have_content('error') }
        end
      end
    end

    describe "with valid information" do
      before do
        fill_in "Name", :with => "Erick"
        fill_in "Email", :with => "user@example.com"
        fill_in "Password", :with => "cmbjxccwtn"
        fill_in "Confirmation", :with => "cmbjxccwtn"
        click_button submit
      end

      describe "should create a user" do
        it { should change(User, :count).by(1)
        
        describe "after saving the user" do
          let(:user) { User.find_by(email: 'user@example.com') }

          it "should redirect to about path" do
            response.should redirect_to about_path
          end
          it { should have_link('Sign out') }
          it { should have_selector('div.alert.alert-success', text: 'Welcome to IdeaSpark') }
        end

        describe "followed by signout" do
          before { click_link "Sign out" }
          it { should have_link('Sign in') }
        end
      end
    end
  end
end
