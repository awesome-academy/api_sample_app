require 'rails_helper'

RSpec.describe "Api::V1::Users", type: :request do
  let(:body_response) {JSON.parse response.body, symbolize_names: true}
  let(:valid_attributes) {
    {first_name: "John", last_name: "Henry", email: "example@test.com", password: "123123@aA"}
  }
  let(:invalid_attributes) {
    {first_name: "", last_name: "Henry", email: "example@test.com", password: "123123@aA"}
  }
  let(:new_attributes) {
    {first_name: "Nicky", last_name: "Valad", email: "nicky.valad@test.com", password: "123123Aa@"}
  }

  describe "GET #index" do
    it "when get users infors success" do
      user = User.create! valid_attributes
      get api_v1_users_url, as: :json
      expect(response).to be_successful
      expect(body_response.size).to eql 1
    end
  end

  describe "GET #show" do
    it "when get user infor success" do
      user = User.create! valid_attributes
      get api_v1_user_url(user), as: :json
      expect(response).to be_successful
      expect(body_response).to eql UserSerializer.new(user).as_json
    end

    it "when get user not found" do
      get api_v1_user_url(id: 100), as: :json
      expect(response).to have_http_status(:not_found)
      expect(body_response).to eql({})
    end
  end

  describe "POST #create" do
    context "with valid parameters" do
      it "creates a new User" do
        expect {
          post api_v1_users_url,
            params: {user: valid_attributes}, as: :json
        }.to change(User, :count).by(1)
      end

      it "renders a JSON response with the new user" do
        post api_v1_users_url,
          params: {user: valid_attributes}, as: :json
        expect(response).to have_http_status(:created)
        expect(response.content_type).to match(a_string_including("application/json"))
        expect(body_response).to eql UserSerializer.new(User.last).as_json
      end
    end

    context "with invalid parameters" do
      it "does not create a new User" do
        expect {
          post api_v1_users_url,
            params: {user: invalid_attributes}, as: :json
        }.to change(User, :count).by(0)
      end

      it "renders a JSON response with errors for the new user" do
        post api_v1_users_url,
        params: {user: invalid_attributes}, as: :json
        expect(response).to have_http_status(:unprocessable_entity)
        expect(response.content_type).to match(a_string_including("application/json"))
        expect(body_response[:error][:first_name]).to eql(["can't be blank"])
      end
    end
  end

  describe "PATCH #update" do
    it "updates the requested user" do
      user = User.create! valid_attributes
      patch api_v1_user_url(user), params: {user: new_attributes}, as: :json
      user.reload
      expect(response).to have_http_status(:ok)
      expect(response.content_type).to match(a_string_including("application/json"))
      expect(body_response).to eql UserSerializer.new(user).as_json
    end

    it "renders a JSON response with errors for the user" do
      user = User.create! valid_attributes
      patch api_v1_user_url(user),
        params: {user: invalid_attributes}, as: :json
      expect(response).to have_http_status(:unprocessable_entity)
      expect(response.content_type).to match(a_string_including("application/json"))
      expect(body_response[:error][:first_name]).to eql(["can't be blank"])
    end
  end

  describe "DELETE #destroy" do
    it "destroys the requested user" do
      user = User.create! valid_attributes
      expect {
        delete api_v1_user_url(user), as: :json
      }.to change(User, :count).by(-1)
    end
    it "response status code" do
      user = User.create! valid_attributes
      delete api_v1_user_url(user), as: :json
      expect(response).to have_http_status(204)
    end
  end
end
