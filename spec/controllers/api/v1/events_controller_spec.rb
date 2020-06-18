require 'rails_helper'

module Api
  module V1
    RSpec.describe EventsController, type: :controller do
      describe "GET #index" do
        before do
          2.times do
            create(:event, number: 1)
            create(:event, number: 2)
          end
        end 

        context 'with correct authentication' do
          before do
            http_login
          end

          context 'fetching events from issue number 1' do
            it "returns status ok" do
              get :index, params: { id: 1 }
              expect(response).to have_http_status(:ok)
            end

            it "returns all events with number: 1" do
              get :index, params: { id: 1 }
              result = JSON.parse(response.body)
              expect(result.count).to be(2)
            end

            it "returns all events with number: 1" do
              get :index, params: { id: 1 }
              result = JSON.parse(response.body)
              first_event = Event.where(number: 1).first
              second_event = Event.where(number: 1).second
              wrong_event = Event.where(number: 2).first
              expect(result).to include(first_event.as_json)
              expect(result).to include(second_event.as_json)
            end

            it "does not return event with issue number: 2" do
              get :index, params: { id: 1 }
              result = JSON.parse(response.body)
              wrong_event = Event.where(number: 2).first
              expect(result).to_not include(wrong_event.as_json)
            end
          end

          context 'fetching events from issue number 2' do
            it "returns all events with number:  2" do
              get :index, params: { id: 2 }
              result = JSON.parse(response.body)
              expect(result.count).to be(2)
            end
          end

          def http_login
            user = Rails.application.credentials.github[:username]
            pw = Rails.application.credentials.github[:password]
            request.env['HTTP_AUTHORIZATION'] = ActionController::HttpAuthentication::Basic.encode_credentials(user,pw)
          end
        end

        context 'without authentication' do
          it "returns status ok" do
            get :index, params: { id: 1 }
            expect(response).to have_http_status(:unauthorized)
          end
        end
      end
    end
  end
end
