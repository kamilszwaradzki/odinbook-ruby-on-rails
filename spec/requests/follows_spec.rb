require 'rails_helper'

RSpec.describe "Follows", type: :request do
  describe "GET /index" do
    it "returns http success" do
      get "/follows/index"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /create" do
    it "returns http success" do
      get "/follows/create"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /update" do
    it "returns http success" do
      get "/follows/update"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /destroy" do
    it "returns http success" do
      get "/follows/destroy"
      expect(response).to have_http_status(:success)
    end
  end

end
