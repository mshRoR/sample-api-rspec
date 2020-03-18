require 'rails_helper'

RSpec.describe 'Comments API', type: :request do
  let!(:articles) { create_list(:article, 10) }
  let(:article_id) { articles.first.id }
  let!(:comments) { create_list(:comment, 5, article_id: article_id) }
  let(:comment_id) { comments.first.id }

  describe 'POST /articles/:article_id/comments' do
    let(:valid_attributes) { { comment: { article_id: article_id, body: 'article comment' } } }
    let(:invalid_attributes) { { comment: { body: nil } } }

    context 'when request attributes are valid' do
      before { post "/articles/#{article_id}/comments", params: valid_attributes }

      it 'create a article comment' do
        expect(json['body']).to eq(valid_attributes[:comment][:body])
      end

      it 'returns http status code 201' do
        expect(response).to have_http_status(201)
      end
    end

    context 'when request attributes are invalid' do
      before { post "/articles/#{article_id}/comments", params: invalid_attributes }

      it 'returns status code 422' do
        expect(response).to have_http_status(:unprocessable_entity)
      end

      it 'returns validation failure message' do
        expect(json['message']).to match(/Body can't be blank/)
      end
    end
  end

  describe 'PUT /articles/:article_id/comments/:id' do
    let(:valid_attributes) { { comment: { body: 'comment in a article' } } }

    before { put "/articles/#{article_id}/comments/#{comment_id}", params: valid_attributes }

    context 'when article exists' do
      it 'returns http status code 204' do
        expect(response).to have_http_status(204)
      end

      it 'updates an comment' do
        cmt = Comment.find(comment_id)
        expect(cmt.body).to eq(valid_attributes[:comment][:body])
      end
    end

    context 'when the article does not exists' do
      let(:comment_id) { 0 }

      it 'returns http status code 404' do
        expect(response).to have_http_status(404)
      end

      it 'returns a not found message' do
        # expect(response.body).to match(/Couldn't find Comment with 'id'=0/)
        expect(json['message']).to match(/Couldn't find Comment with 'id'=0/)
      end
    end
  end

  describe 'DELETE /articles/:article_id/comments/:id' do
    before { delete "/articles/#{article_id}/comments/#{comment_id}", params: {} }

    it 'returns http status code 204' do
      expect(response).to have_http_status(204)
    end
  end
end
