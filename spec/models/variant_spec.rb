# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Variant, type: :model do
  subject(:variant) { create(:variant, color: 'Red') }

  describe 'associations' do
    it { is_expected.to belong_to :phone }
  end

  it { validate_presence_of :storage }
  it { validate_presence_of :color }
  it { validate_presence_of :count_on_hand }
  it { is_expected.to validate_uniqueness_of(:phone_id).scoped_to(%i[storage color]) }
  it { is_expected.to validate_numericality_of(:count_on_hand).is_greater_than_or_equal_to(0) }

  describe '#name' do
    it 'returns name of the variant' do
      expect(subject.name).to eq 'Red - 250 GB'
    end
  end
end
