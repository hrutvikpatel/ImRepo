require 'rails_helper'

RSpec.describe 'Categories', type: :request do
  context 'GET #index' do
    it 'returns a success response' do
      skip
      Category.create([{ name: 'Shark' }, { name: 'Muffin' }])
      get categories_path
      expect(response.body).to include 'Shark'
      expect(response.body).to include 'Muffin'
    end

    it 'returns no categories found when there are no categories' do
      skip
      get categories_path
      expect(response.body).to include 'No categories found!'
    end

    it 'returns searched category that exists' do
      Category.create([{ name: 'Shark' }, { name: 'Muffin' }])
      get categories_path, params: { search: 'Shark' }
      expect(response.body).to include 'Shark'
      expect(response.body).to_not include 'Muffin'
    end

    it 'returns no categories found when searched' do
      skip
      Category.create([{ name: 'Shark' }, { name: 'Muffin' }])
      get categories_path, params: { search: 'Banana' }
      expect(response.body).to include 'No categories found!'
    end
  end

  context 'GET #show' do
  end
end
