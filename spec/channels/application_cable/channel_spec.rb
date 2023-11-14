require 'rails_helper'

module ApplicationCable
  RSpec.describe Channel, type: :channel do
    it 'inherits from ActionCable::Channel::Base' do
      expect(described_class).to be < ActionCable::Channel::Base
    end
  end
end
