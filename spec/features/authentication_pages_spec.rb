require 'spec_helper'

describe "Authentication page" do
  subject { page }

  describe "signin page" do
    before { visit signin_path }

    describe "with invalid information" do
      before { click_button "Sign in" }

      it { should have_title('Sign in') }
      it { should have_selector('div.alert.alert-error') }

      describe "after visiting another page" do
        before { visit root_path }
        it { should_not have_selector('div.alert.alert-error') }
      end
    end

    describe "with valid information" do
      let(:user) { FactoryGirl.create(:user) }
      before do
        sign_in user
        visit profile_path
      end
      
      it { should have_title(user.name) }
      it { should have_link('Profile', :href => profile_path) }
      it { should have_link('Settings', :href => profile_edit_path) }
      it { should have_link('Sign out', :href => signout_path) }
      it { should_not have_link('Sign in', :href => signin_path) }
    end
  end

  describe "authorization" do
    describe "for non-signed-in users" do
      let(:user) { FactoryGirl.create(:user) }

      describe "in the Users controller" do
        describe "visiting the edit page" do
          before { visit profile_edit_path }
          it { should have_title('Sign in') }
        end
      end
      
      describe "submitting to the update action", type: :request do
        before { patch user_path(user) }
        specify { expect(response).to redirect_to(signin_path) }
      end
    end
  end
end
