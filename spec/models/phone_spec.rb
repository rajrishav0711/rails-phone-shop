# frozen_string_literal: true

require "rails_helper"

RSpec.describe Phone, type: :model do
  subject(:phone) { build(:phone, manufacturer: "Apple") }

  it { is_expected.to validate_presence_of(:manufacturer) }
  it { is_expected.to validate_presence_of(:model) }
  it { is_expected.to validate_uniqueness_of(:model).scoped_to(:manufacturer) }

  describe "associations" do
    it { is_expected.to have_many(:variants).dependent(:destroy) }
  end

  describe "#name" do
    it "returns the phone name" do
      expect(phone.name).to eq("Apple - iPhone 11")
    end
  end
end
