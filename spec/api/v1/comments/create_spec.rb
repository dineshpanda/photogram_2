require 'rails_helper'

RSpec.describe "comments#create", type: :request do
  subject(:make_request) do
    jsonapi_post "/api/v1/comments", payload
  end

  describe 'basic create' do
    let(:params) do
      attributes_for(:comment)
    end
    let(:payload) do
      {
        data: {
          type: 'comments',
          attributes: params
        }
      }
    end

    it 'works' do
      expect(CommentResource).to receive(:build).and_call_original
      expect {
        make_request
        expect(response.status).to eq(201), response.body
      }.to change { Comment.count }.by(1)
    end
  end
end
