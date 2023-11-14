require "rails_helper"

RSpec.describe ApplicationMailer, type: :mailer do
  class TestMailer < ApplicationMailer
    def test_email
      mail(to: 'test@example.com', subject: 'Test email')
    end
  end

  before do
    allow_any_instance_of(Mail::Message).to receive(:deliver)
  end

  it 'inherits from ActionMailer::Base' do
    expect(ApplicationMailer).to be < ActionMailer::Base
  end

  it 'sets the default from email' do
    expect(ApplicationMailer.default[:from]).to eq('from@example.com')
  end


end
