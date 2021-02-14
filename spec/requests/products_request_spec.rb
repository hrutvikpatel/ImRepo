require 'rails_helper'

RSpec.describe 'Products', type: :request do
  context 'GET #index' do
    context 'has no data' do
      it 'should return success response' do
        get products_path
        expect(response).to have_http_status(200)
      end
  
      it 'should render no products found if there are no products in db' do
        get products_path
        expect(response.body).to include('No images found!')
      end

      it 'should render no products found if search query is provided' do
        get products_path, params: { search: Faker::Lorem.word }
        expect(response.body).to include('No images found!')
      end
    end

    context 'has data' do
      before(:each) do
        category = Category.create(name: 'Dog')
        product = Product.new(title: 'doggo', description: 'playful doggo', price: 10, categories: [category])
        product.image.attach(io: File.open('app/assets/dummy/Herding-Australian-Shepherd.jpg'), filename: 'Herding-Australian-Shepherd.jpg')
        product.save!
      end

      it 'should retrieve all products' do
        get products_path
        expect(response.body).to include('doggo')
      end

      it 'should retrieve searched product by title' do
        get products_path, params: { search: 'doggo' }
        expect(response.body).to include('doggo')
      end

      it 'should retrieve searched product by description' do
        get products_path, params: { search: 'playful' }
        expect(response.body).to include('playful')
      end

      it 'should render no products found when search term is not alike any title or description' do
        get products_path, params: { search: 'bagel' }
        expect(response.body).to include('No images found!')
      end
    end
  end
end
