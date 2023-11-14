require 'rails_helper'

RSpec.describe ApplicationJob, type: :job do
  it 'inherits from ActiveJob::Base' do
    expect(described_class.new).to be_a(ActiveJob::Base)
  end


end
