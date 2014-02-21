require 'spec_helper'

describe "User pages" do
  include  ApplicationHelper

  subject { page }

  describe "profile page" do
    let(:user) { FactoryGirl.create(:user) }
    before { visit user_path(user) }

    it { should have_content(user.name) }
    it { should have_title(user.name) }
  end

  describe "edit" do
    let(:user) { FactoryGirl.create(:user) }

    before do
      sign_in user
      visit profile_edit_path
    end

    describe "page" do
      it { should have_content("Update your profile") }
      it { should have_title(full_title("Edit profile")) }
      it { should have_link('change', href: 'http://gravatar.com/emails') }
    end

    describe "with invalid information" do
      before { click_button "Save changes" }

      it { should have_content('error') }
    end

    describe "with valid information" do
      let(:new_name) { "new test name" }
      let(:new_email) { "newtest@example.com" }
      before do
        fill_in "Name", :with => new_name
        fill_in "Email", :with => new_email
        fill_in "Password", :with => user.password
        fill_in "Confirm Password", :with => user.password
        click_button "Save changes"
      end

      it { should have_title(new_name) }
      it { should have_selector('div.alert.alert-success') }
      it { should have_link('Sign out', :href => signout_path) }
      specify { expect(user.reload.name).to eq new_name }
      specify { expect(user.reload.email).to eq new_email }
    end
  end

  describe "forbidden attributes", type: :request do
    let(:user) { FactoryGirl.create(:user) }
    let(:params) do
      { user: { admin: true, password: user.password,
                password_confirmation: user.password } }
    end

    before do
      sign_in user, no_capybara: true
      patch user_path(user), params
    end

    specify { expect(user.reload).not_to be_admin }
  end

  describe "signup page" do
    before { visit signup_path }

    it { should have_content('Sign up') }
    it { should have_title(full_title('Sign up')) }
    
    describe "fill form" do
      let(:submit) { "Sign up" }
    
      describe "with invalid information" do
        it "should not create a user" do
          expect { click_button submit }.not_to change(User, :count)
        end
       
        describe "after submission" do
          before { click_button submit } 

          it { should have_title('Sign up') }
          it { should have_content('error') }
        end
      end

      describe "with valid information" do
        before do
          fill_in "Name", :with => "Erick"
          fill_in "Email", :with => "user@example.com"
          fill_in "Password", :with => "cmbjxccwtn"
          fill_in "Confirmation", :with => "cmbjxccwtn"
        end

        it "should create a user" do
          expect { click_button submit }.to change(User, :count).by(1)
        end

        describe "after saving the user" do
          before { click_button submit }

          let(:user) { User.find_by(email: 'user@example.com') }

          it { should have_link('Sign out') }
          it { should have_content(user.name) }
          it { should have_selector('div.alert.alert-success', text: 'Welcome to IdeaSpark') }

          describe "followed by signout" do
            before { click_link "Sign out" }
            it { should have_link('Sign in') }
          end
        end
      end
    end
  end
end
