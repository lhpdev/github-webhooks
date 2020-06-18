class Event < ApplicationRecord
  validates :number, :action, presence: true
end
