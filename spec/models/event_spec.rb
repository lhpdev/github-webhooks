require 'rails_helper'

RSpec.describe Event, type: :model do
  let(:event) { build(:event) }

  it 'is valid with valid attributes' do
    expect(event).to be_valid
  end

  it "is not valid without a title" do
    event.number = nil
    expect(event).to_not be_valid
  end

  it "is not valid without a description" do
    event.action = nil
    expect(event).to_not be_valid
  end
end
