require 'rails_helper'

module ApplicationCable
  RSpec.describe Connection, type: :channel do
    it 'inherits from ActionCable::Connection::Base' do
      expect(described_class).to be < ActionCable::Connection::Base
    end

  end
end
