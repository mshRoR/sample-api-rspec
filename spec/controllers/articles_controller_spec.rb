require 'rails_helper'

RSpec.describe ArticlesController, type: :controller do

  describe "GET index" do
    let!(:articles) { create_list(:article, 10) }
    
    it "assign @articles" do
      get :index

      expect(assigns(:articles)).to eq(articles)
    end
  end
end
