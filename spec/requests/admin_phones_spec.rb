# frozen_string_literal: true

require "rails_helper"

RSpec.describe "Admin::Phones", type: :request do
  describe "GET /admin/phones" do
    it "returns the phone list" do
      phones = create_list(:phone, 2)

      get admin_phones_path

      expect(response).to have_http_status(:ok)
      expect(response.body).to include(phones.first.name, phones.last.name)
    end
  end

  describe "POST /admin/phones" do
    let(:valid_attributes) do
      { manufacturer: "Apple", model: "iPhone 15", manufacture_year: 2023 }
    end

    it "creates a phone" do
      expect {
        post admin_phones_path, params: { phone: valid_attributes }
      }.to change(Phone, :count).by(1)

      expect(response).to redirect_to(admin_phones_path)
      expect(flash[:notice]).to eq("Phone was successfully created.")
    end

    it "renders errors for invalid data" do
      post admin_phones_path, params: { phone: { manufacture_year: 2070 } }

      expect(response).to have_http_status(:unprocessable_entity)
      expect(response.body).to include("Manufacturer", "Model")
    end
  end

  describe "GET /admin/phones/:id/edit" do
    it "returns the edit form" do
      phone = create(:phone)

      get edit_admin_phone_path(phone)

      expect(response).to have_http_status(:ok)
      expect(response.body).to include("Edit Phone", phone.name)
    end
  end

  describe "PATCH /admin/phones/:id" do
    it "updates the phone" do
      phone = create(:phone)

      patch admin_phone_path(phone), params: {
        phone: { manufacturer: "Samsung", model: "Galaxy S25", manufacture_year: 2025 }
      }

      expect(response).to redirect_to(admin_phones_path)
      expect(phone.reload).to have_attributes(
        manufacturer: "Samsung",
        model: "Galaxy S25",
        manufacture_year: 2025
      )
    end

    it "renders errors for invalid data" do
      phone = create(:phone)

      patch admin_phone_path(phone), params: { phone: { manufacture_year: 2070 } }

      expect(response).to have_http_status(:unprocessable_entity)
    end
  end

  describe "DELETE /admin/phones/:id" do
    it "deletes the phone and its variants" do
      phone = create(:phone)
      create(:variant, phone: phone)

      expect {
        delete admin_phone_path(phone)
      }.to change(Phone, :count).by(-1)
        .and change(Variant, :count).by(-1)

      expect(response).to redirect_to(admin_phones_path)
      expect(flash[:notice]).to eq("Phone was successfully deleted.")
    end
  end
end
