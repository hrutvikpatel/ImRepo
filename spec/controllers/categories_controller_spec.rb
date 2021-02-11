require 'rails_helper'

RSpec.describe CategoriesController, :type => :controller do
  context 'GET #index' do
    it 'returns a success response' do
      create_list(:category, 2)
      get :index
      expect(response).to be_successful
    end
  end
end