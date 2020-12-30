# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Admin::VariantsController, type: :controller do
  routes { Rails.application.routes }

  let(:phone) { create :phone }

  let(:error_message) { 'Error! Please try again' }
  let(:create_message) { 'Variant was successfully created.' }
  let(:update_message) { 'Variant was successfully updated.' }
  let(:delete_message) { 'Variant was successfully deleted.' }

  describe 'GET index' do
    subject(:index) { get :index, params: { phone_id: phone.id } }

    let!(:variants) { create_list :variant, 2, phone: phone }

    it { is_expected.to be_successful }
    it { is_expected.to render_template :index }

    it 'loads the list of variants' do
      index
      expect(assigns(:variants)).to eq variants
    end
  end

  describe 'GET edit' do
    let(:variant) { create :variant }
    subject(:edit) { get :edit, params: { id: variant.id } }

    it { is_expected.to be_successful }
    it { is_expected.to render_template :edit }

    it 'load the correct variant' do
      edit
      expect(assigns(:variant)).to eq variant
    end
  end

  describe 'PATCH update' do
    let(:variant) { create :variant, :with_phone }
    let(:params) do
      {
        id: variant.id,
        variant: {
          phone_id: variant.phone_id,
          storage: '64 GB',
          color: 'Red',
          count_on_hand: 100
        }
      }
    end

    let(:wrong_params) do
      {
        id: variant.id,
        variant: {
          phone_id: variant.phone_id,
          storage: '64 GB',
          color: 'Red',
          count_on_hand: -100 # negative count_on_hand
        }
      }
    end

    context 'no error in update' do
      subject(:update) { patch :update, params: params }

      it 'redirects back to index' do
        expect(subject).to redirect_to(admin_phone_path(variant.phone_id))
        expect(flash[:notice]).to include(update_message)
      end

      it 'updates the correct attributes' do
        update
        expect(assigns(:variant)).to have_attributes(
          phone_id: variant.phone_id
        )
      end

      it 'saves the record' do
        update
        expect(assigns(:variant)).to_not be_changed
      end
    end

    context 'error in update' do
      subject(:update) { patch :update, params: wrong_params }

      it { is_expected.to render_template :edit }

      it 'shows error alert' do
        update
        expect(flash[:alert]).to include(error_message)
      end
    end
  end

  describe 'GET new' do
    subject(:new) { get :new, params: { phone_id: phone.id } }

    it { is_expected.to be_successful }
    it { is_expected.to render_template :new }

    it 'loads a new variant' do
      new
      expect(assigns(:variant)).to_not be_persisted
    end

    it 'loads the phone' do
      new
      expect(assigns(:phone)).to eq phone
    end
  end

  describe 'POST create' do
    let(:params) do
      {
        phone_id: phone.id,
        variant: {
          phone_id: phone.id,
          storage: '64 GB',
          color: 'Red',
          count_on_hand: 100
        }
      }
    end

    let(:wrong_params) do
      {
        phone_id: phone.id,
        variant: {
          phone_id: phone.id,
          storage: '64 GB',
          color: 'Red',
          count_on_hand: -100 # negative count_on_hand
        }
      }
    end

    context 'no error in save' do
      subject(:create_action) { post :create, params: params }

      it 'redirects back to index' do
        expect(subject).to redirect_to(admin_phone_path(phone.id))
        expect(flash[:notice]).to include(create_message)
      end

      it 'creates the new record' do
        create_action
        expect(assigns(:variant)).to be_persisted
      end

      it 'assigns the correct values' do
        create_action
        expect(assigns(:variant)).to have_attributes params[:variant]
      end
    end

    context 'error in save' do
      subject(:create_action) { post :create, params: wrong_params }

      it { is_expected.to render_template :new }

      it 'shows alert' do
        create_action
        expect(flash[:alert]).to include(error_message)
      end
    end
  end

  describe 'DELETE destroy' do
    let(:variant) { create :variant }
    subject(:destroy) { delete :destroy, params: { id: variant.id } }

    it { is_expected.to redirect_to admin_phone_path(variant.phone_id) }

    it 'destroys the correct object' do
      expect { destroy }
        .to change { Variant.exists? variant.id }
        .from(true).to false
    end

    it 'shows success delete message' do
      destroy
      expect(flash[:notice]).to include(delete_message)
    end
  end
end
