# frozen_string_literal: true

require "rails_helper"

RSpec.describe Price, type: :model do
  it { is_expected.to belong_to(:variant) }
  it { is_expected.to have_one(:phone).through(:variant) }
end
