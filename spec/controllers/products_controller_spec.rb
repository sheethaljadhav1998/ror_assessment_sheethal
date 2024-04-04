RSpec.describe ProductsController, type: :controller do
  let(:valid_attributes) { { name: 'Test Product', description: 'Test Description' } }

  describe 'GET #index' do
    it 'assigns all products as @products' do
      product = Product.create!(valid_attributes)
      get :index
      expect(assigns(:products)).to eq([product])
    end
  end

  describe 'POST #create' do
    context 'with valid params' do
      it 'creates a new product' do
        expect {
          post :create, params: { product: valid_attributes }
        }.to change(Product, :count).by(1)
      end

      it 'notifies third parties' do
        expect_any_instance_of(ProductsController).to receive(:notify_third_parties)
        post :create, params: { product: valid_attributes }
      end
    end

    context 'with invalid params' do
      it 'returns unprocessable entity status' do
        post :create, params: { product: { name: '' } }
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end

  describe 'PATCH #update' do
    let(:product) { Product.create!(valid_attributes) }
    let(:new_attributes) { { name: 'Updated Product' } }

    context 'with valid params' do
      it 'updates the requested product' do
        patch :update, params: { id: product.to_param, product: new_attributes }
        product.reload
        expect(product.name).to eq('Updated Product')
      end

      it 'notifies third parties' do
        expect_any_instance_of(ProductsController).to receive(:notify_third_parties)
        patch :update, params: { id: product.to_param, product: new_attributes }
      end
    end

    context 'with invalid params' do
      it 'returns unprocessable entity status' do
        patch :update, params: { id: product.to_param, product: { name: '' } }
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end
end
