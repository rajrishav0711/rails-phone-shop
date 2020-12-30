# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Phone, type: :model do
  subject(:phone) { create(:phone, manufacturer: 'Apple') }

  it { validate_presence_of :manufacturer }
  it { validate_presence_of :model }
  it { validate_presence_of :competitor_price }
  it { is_expected.to validate_uniqueness_of(:model).scoped_to(:manufacturer) }

  describe 'associations' do
    it { is_expected.to have_many :variants }
  end

  describe '#name' do
    it 'returns name of the phone' do
      expect(subject.name).to eq 'Apple - Iphone 11'
    end
  end
end
