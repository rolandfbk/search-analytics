require 'rails_helper'

RSpec.describe Analytic, type: :model do
  user = User.create(name: 'Grabrielle')
  subject do
    Analytic.new(user_id: user.id, search: 'What is a good car?')
  end
  before { subject.save }

  it 'search should be present' do
    subject.search = nil
    expect(subject).to_not be_valid
  end
end
