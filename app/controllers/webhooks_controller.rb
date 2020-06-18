class WebhooksController < ApplicationController
  skip_before_action :verify_authenticity_token

  def payload
    request.body.rewind
    payload_body = request.body.read
    if verify_signature(payload_body)
      payload = JSON.parse(params[:payload])
      @event = Event.create(action: payload["action"], number: payload["issue"]["number"])
      render json: @event.as_json , status: :ok
    else
      render json: { error: 'Signature is wrong' }, status: :unprocessable_entity
    end
  end

  def verify_signature(payload_body)
    signature = 'sha1=' + OpenSSL::HMAC.hexdigest(OpenSSL::Digest.new('sha1'), Rails.application.credentials.github[:secret_key], payload_body)
    Rack::Utils.secure_compare(signature, request.headers["X-Hub-Signature"])
  end
end