require 'rails_helper'

RSpec.describe 'Analytic page test', type: :feature do
  describe 'new page' do
    before :each do
      @user = User.create(name: 'Grabrielle', email: 'gabrielle@test.com', password: '123456789', role: 'admin')
      @analytic = @user.analytics.create(search: 'How is Emil Hajric doing?')

      visit new_user_session_path
      fill_in 'Email', with: 'gabrielle@test.com'
      fill_in 'Password', with: '123456789'
      click_on 'Log in'
    end

    it 'check analytics#new path' do
      visit root_path
      expect(current_path).to eq(root_path)
      expect(page).to have_text('View Analytics')
    end

    it 'Should display the button and the input text field' do
      visit root_path
      fill_in 'analytic[search]', with: 'How is Emil Hajric doing?'
      expect(page).to have_button('Search')
      expect(page).to have_field('analytic[search]', with: 'How is Emil Hajric doing?')
    end

    it "Should navigate to recipe food's new page" do
      visit root_path
      click_link 'View Analytics'
      expect(current_path).to eq("/analytics")
    end
  end

  describe 'index page' do
    before :each do
      @user = User.create(name: 'Grabrielle', email: 'gabrielle@test.com', password: '123456789' , role: 'admin')
      @analytic = @user.analytics.create(search: 'How is Emil Hajric doing?')

      visit new_user_session_path
      fill_in 'Email', with: 'gabrielle@test.com'
      fill_in 'Password', with: '123456789'
      click_on 'Log in'
    end

    it 'check analytics#index path' do
      visit "/analytics"
      expect(current_path).to eq("/analytics")
      expect(page).to have_text('Trending searches')
    end

    it 'Should display "How is Emil Hajric doing?"' do
      visit "/analytics"
      expect(page).to have_content('How is Emil Hajric doing?')
    end
  end
end
