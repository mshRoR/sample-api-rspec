require 'rails_helper'

RSpec.describe 'Articles API', type: :request do
  let!(:articles) { create_list(:article, 10) }
  let(:article_id) { articles.first.id }

  describe 'GET /articles' do
    before { get '/articles' }

    it 'returns articles' do
      # json is a custom spec helper method
      expect(json).not_to be_empty
      expect(json.size).to eq(10)
    end

    it 'returns status code 200' do
      expect(response).to have_http_status(:ok)
    end
  end

  describe 'GET /articles/:id' do
    before { get "/articles/#{article_id}" }

    context 'When the record exists' do
      it 'returns the article' do
        expect(json).not_to be_empty
        expect(json['id']).to eq(article_id)
      end
      
      it 'returns status code 200' do
        expect(response).to have_http_status(:ok)
      end
    end

    context 'When the record does not exists' do
      let(:article_id) { 100 }

      it 'returns status code 404' do
        expect(response).to have_http_status(:not_found)
      end

      it 'returns a not found message' do
        expect(response.body).to match(/Couldn't find Article/)
      end
    end
  end

  describe 'POST /articles' do
    let(:params) { { article: { title: 'article title', description: 'article description' } } }
    
    context 'when the request is valid' do
      before { post '/articles', params: params }

      it 'creates a article' do
        # puts json.inspect
        # puts json['title'].inspect
        # puts params.inspect
        # puts params[:article][:title]
        expect(json['title']).to eq(params[:article][:title])
      end

      it 'returns status code 201' do
        expect(response).to have_http_status(:created)
      end
    end

    context 'when the request is invalid' do
      let(:invalid_attributes) { { article: { title: nil } } }
      before { post '/articles', params: invalid_attributes }

      it 'returns status code 422' do
        expect(response).to have_http_status(:unprocessable_entity)
      end

      it 'returns a validation failure message' do
        # raise response.body.inspect
        expect(json['message']).to match(/Validation failed: Title can't be blank, Description can't be blank/)
      end
    end
  end

  describe 'PUT /articles/:id' do
    let(:valid_attributes) { { article: { title: 'hello' } } }

    before { put "/articles/#{article_id}", params: valid_attributes }

    context 'when article exists' do
      it 'update the articles' do
        expect(response.body).to be_empty
      end

      it 'returns http status 204' do
        expect(response).to have_http_status(204)
      end
    end
  end

  describe 'DELETE /articles/:id' do
    before { delete "/articles/#{article_id}" }

    it 'returns status code 204' do
      expect(response).to have_http_status(204)
    end
  end
end
