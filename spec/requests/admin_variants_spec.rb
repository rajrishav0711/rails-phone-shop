# frozen_string_literal: true

require "rails_helper"

RSpec.describe "Admin::Variants", type: :request do
  let(:phone) { create(:phone) }

  describe "GET /admin/phones/:phone_id/variants" do
    it "returns the variants for the phone" do
      variant = create(:variant, phone: phone)

      get admin_phone_variants_path(phone)

      expect(response).to have_http_status(:ok)
      expect(response.body).to include(variant.storage, variant.color)
    end
  end

  describe "POST /admin/phones/:phone_id/variants" do
    let(:valid_attributes) do
      { storage: "64 GB", color: "Red", count_on_hand: 100 }
    end

    it "creates a variant for the phone" do
      expect {
        post admin_phone_variants_path(phone), params: { variant: valid_attributes }
      }.to change(Variant, :count).by(1)

      variant = Variant.order(:id).last
      expect(variant.phone).to eq(phone)
      expect(response).to redirect_to(admin_phone_path(phone))
    end

    it "renders errors for invalid data" do
      post admin_phone_variants_path(phone), params: {
        variant: { storage: "64 GB", color: "Red", count_on_hand: -1 }
      }

      expect(response).to have_http_status(:unprocessable_entity)
      expect(response.body).to include("Count on hand")
    end
  end

  describe "GET /admin/variants/:id/edit" do
    it "returns the edit form" do
      variant = create(:variant, phone: phone)

      get edit_admin_variant_path(variant)

      expect(response).to have_http_status(:ok)
      expect(response.body).to include("Edit Variant", variant.name)
    end
  end

  describe "PATCH /admin/variants/:id" do
    it "updates the variant" do
      variant = create(:variant, phone: phone)

      patch admin_variant_path(variant), params: {
        variant: { storage: "128 GB", color: "Blue", count_on_hand: 25 }
      }

      expect(response).to redirect_to(admin_phone_path(phone))
      expect(variant.reload).to have_attributes(
        storage: "128 GB",
        color: "Blue",
        count_on_hand: 25
      )
    end

    it "renders errors for invalid data" do
      variant = create(:variant, phone: phone)

      patch admin_variant_path(variant), params: {
        variant: { count_on_hand: -100 }
      }

      expect(response).to have_http_status(:unprocessable_entity)
    end
  end

  describe "DELETE /admin/variants/:id" do
    it "deletes the variant" do
      variant = create(:variant, phone: phone)

      expect {
        delete admin_variant_path(variant)
      }.to change(Variant, :count).by(-1)

      expect(response).to redirect_to(admin_phone_path(phone))
    end
  end
end
