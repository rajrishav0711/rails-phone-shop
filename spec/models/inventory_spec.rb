# frozen_string_literal: true

require "rails_helper"

RSpec.describe Inventory, type: :model do
  subject(:inventory) { build(:variant).inventory }

  it { is_expected.to belong_to(:variant) }
  it { is_expected.to validate_presence_of(:count_on_hand) }
  it { is_expected.to validate_numericality_of(:count_on_hand).is_greater_than_or_equal_to(0) }
end
