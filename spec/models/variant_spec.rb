# frozen_string_literal: true

require "rails_helper"

RSpec.describe Variant, type: :model do
  subject(:variant) { build(:variant, color: "Red") }

  describe "associations" do
    it { is_expected.to belong_to(:phone) }
    it { is_expected.to have_one(:price).dependent(:destroy) }
    it { is_expected.to have_one(:inventory).dependent(:destroy) }
  end

  it { is_expected.to validate_presence_of(:storage) }
  it { is_expected.to validate_presence_of(:color) }
  it { is_expected.to validate_presence_of(:count_on_hand) }
  it { is_expected.to validate_uniqueness_of(:phone_id).scoped_to(%i[storage color]) }

  it "does not allow negative count on hand" do
    variant.count_on_hand = -1

    expect(variant).not_to be_valid
    expect(variant.errors[:count_on_hand]).to include("must be greater than or equal to 0")
  end

  describe "#name" do
    it "returns the variant name" do
      expect(variant.name).to eq("Red - 250 GB")
    end
  end
end
