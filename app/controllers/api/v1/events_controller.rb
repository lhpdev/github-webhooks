module Api
  module V1
    class EventsController < ApplicationController
      http_basic_authenticate_with name: Rails.application.credentials.github[:username], 
                                   password: Rails.application.credentials.github[:password]

      before_action :events

      def index
        render json: @events, status: :ok
      end

      private

      def events
        @events = Event.where(number: params[:id])
      end
    end
  end
end