require 'rails_helper'

RSpec.describe WebhooksController, type: :request do
  describe 'POST payload' do
    context 'when it has correct github webhooks signature' do 
      before(:each) do
        allow_any_instance_of(WebhooksController).to receive(:verify_signature).and_return(true)
      end

      let!(:event) { create(:event) }

      it "creates a new event" do
        fixture_path = "#{Rails.root}/spec/fixtures/github_webhooks/issue.json"
        payload_fixture = File.read(fixture_path)
        expect {    
          post "/webhooks/payload", :params => { payload: payload_fixture }
        }.to change { Event.all.count }.by 1 
        expect(response).to have_http_status(:ok)
      end

      it "responds created event as json" do
        fixture_path = "#{Rails.root}/spec/fixtures/github_webhooks/issue.json"
        payload_fixture = File.read(fixture_path) 
        post "/webhooks/payload", :params => { payload: payload_fixture }
        expect(response.body).to include(Event.last.to_json)
      end
    end

    context 'when it does not have correct github webhooks signature' do
      before(:each) do
        allow_any_instance_of(WebhooksController).to receive(:verify_signature).and_return(false)
      end

      it "does not create a new event" do
        fixture_path = "#{Rails.root}/spec/fixtures/github_webhooks/issue.json"
        payload_fixture = File.read(fixture_path)
        expect {    
          post "/webhooks/payload", :params => { payload: payload_fixture }
        }.to change { Event.all.count }.by 0 
        expect(response).to have_http_status(:unprocessable_entity)
      end

      it "responds created event as json" do
        fixture_path = "#{Rails.root}/spec/fixtures/github_webhooks/issue.json"
        payload_fixture = File.read(fixture_path) 
        post "/webhooks/payload", :params => { payload: payload_fixture }
        expect(response.body).to include({ error: 'Signature is wrong' }.to_json)
      end
    end
  end
end
