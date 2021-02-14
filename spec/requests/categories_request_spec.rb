require 'rails_helper'

RSpec.describe 'Categories', type: :request do
  context 'GET #index' do
    context 'has no data' do
      it 'should return success response' do
        get categories_path
        expect(response).to have_http_status(200)
      end
  
      it 'should render no categories found when there are no categories' do
        get categories_path
        expect(response.body).to include('No categories found!')
      end

      it 'should render no categories found if search query is provided' do
        get categories_path, params: { search: Faker::Lorem.word }
        expect(response.body).to include('No categories found!')
      end
    end

    context 'has data' do
      before(:each) do
        Category.create([{ name: 'Shark' }, { name: 'Muffin' }])
      end

      it 'should retrieve all categories' do
        get categories_path
        expect(response.body).to include('Shark')
        expect(response.body).to include('Muffin')
      end

      it 'should retrieve searched category by name' do
        get categories_path, params: { search: 'Shark' }
        expect(response.body).to include('Shark')
      end

      it 'should render no categories found when search term is not alike any category name' do
        get categories_path, params: { search: 'bagel' }
        expect(response.body).to include('No categories found!')
      end
    end

  end

  context 'GET #show' do
    context 'has no data' do
      it 'should return category not found and redirect to categories index' do
        get category_path(1)
        expect(response).to redirect_to(categories_path)
        # TODO: FIGURE OUT HOW TO TEST THE FLASH MESSAGE LATER
      end
    end

    context 'has data' do
      
    end
  end
end
