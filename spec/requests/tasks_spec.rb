require "rails_helper"

RSpec.describe "Tasks API", type: :request do
  before do
    10.times { create_list(:task, 10) }
  end

  describe "Get /tasks" do
    before { get "tasks" }

    it "returns a tasks json object" do
      expect(json).not_to be_empty
      expect(json.size).to eq 10
    end
      
    it "returns a 200" do
      expect(response).to have_http_status(200)
    end

  end

  describe "GET /tasks/id" do
    before { get "/tasks/#{Task.first.id}" }

    context "record exists" do
      it "returns tasks" do
        expect(json).not_to be_empty
        expect(json["id"]).to eq Task.first.id
      end
    end

    context "record does not exits" do
      it "returns a 404 w/ message" do
        get "/tasks/#{Task.last.id + 1}"

        expect(response).to have_http_status(404)
        expect(response.body).to match(/Could not find Task/)
      end
    end
  end

  describe "POST /tasks" do
    before do
      user = create(:user)
      post "/tasks", params: { title: "Write tests", user_id: user.id }
    end

    it "creates task" do
      expect(json["title"]).to eq("Write tests")
      expect(response).to have_http_status(201)
    end

  end

  describe "PUT /tasks/id" do
    it "updates record and returns 204" do
      put "/tasks/#{Task.first.id}", params: { title: "Test Title" }

      expect(response.body).to be_empty
      expect(response).to have_http_status(204)
    end
  end

  describe "DELETE /tasks/id" do
    it "deletes record and returns 204" do
      delete "/tasks/#{Task.last.id}"

      expect(response).to have_http_status(204)
      expect(Task.count).to eq 9
    end
  end
end
