require 'rails_helper'

RSpec.describe 'Analytics', type: :request do
  before :each do
    @user = User.create(name: 'Grabrielle', email: 'gabrielle@test.com', password: '123456789', role: 'admin')
    @analytic = @user.analytics.create(search: 'How is Emil Hajric doing?')
    
    post user_session_path, params: { user: { email: @user.email, password: @user.password } }
  end

  describe 'GET #index' do
    before(:example) { get analytics_path }

    it 'is a success' do
      expect(response).to have_http_status(:ok)
    end

    it "renders 'index' template" do
      expect(response).to render_template('index')
    end

    it "should include 'Trending searches'" do
      expect(response.body).to include('Trending searches')
    end

    it "should include 'How is Emil Hajric doing?'" do
      expect(response.body).to include('How is Emil Hajric doing?')
    end
  end

  describe 'GET #new' do
    before(:example) { get root_path }

    it 'is a success' do
      expect(response).to have_http_status(:ok)
    end

    it "renders 'show' template" do
      expect(response).to render_template('new')
    end

    it 'should include "View Analytics"' do
      expect(response.body).to include('View Analytics')
    end
  end

  describe 'POST #create' do
    before(:example) { post analytics_path, params: { usersearch: 'How is Emil Hajric doing?' } }

    it 'is a success' do
      expect(response).to have_http_status(:ok)
    end
  end

  describe 'GET #user_search' do
    before(:example) { get user_search_analytics_path, params: { user_id: @user.id } }

    it 'is a success' do
      expect(response).to have_http_status(:ok)
    end
  end
end
