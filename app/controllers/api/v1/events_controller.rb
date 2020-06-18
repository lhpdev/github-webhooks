module Api
  module V1
    class EventsController < ApplicationController
      skip_before_action :verify_authenticity_token

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