# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Admin::PhonesController, type: :controller do
  routes { Rails.application.routes }

  let(:phone) { create :phone }

  let(:params) do
    {
      id: phone.id,
      phone: { manufacturer: 'Apple', model: 'Iphone 11', manufacture_year: 2019 }
    }
  end

  let(:wrong_params) do
    {
      id: phone.id,
      phone: { manufacture_year: 2070 }
    }
  end

  let(:error_message) { 'Error! Please try again' }
  let(:create_message) { 'Phone was successfully created.' }
  let(:update_message) { 'Phone was successfully updated.' }
  let(:delete_message) { 'Phone was successfully deleted.' }

  describe 'GET index' do
    subject(:index) { get :index }

    let(:phones) { create_list :phone, 2 }

    it { is_expected.to be_successful }
    it { is_expected.to render_template :index }

    it 'loads the list of phones' do
      index
      expect(assigns(:phones)).to eq phones
    end
  end

  describe 'GET edit' do
    subject(:edit) { get :edit, params: { id: phone.id } }

    it { is_expected.to be_successful }
    it { is_expected.to render_template :edit }

    it 'load the correct object' do
      edit
      expect(assigns(:phone)).to eq phone
    end
  end

  describe 'PATCH update' do
    context 'no error in update' do
      subject(:update) { patch :update, params: params }

      it 'redirects back to index' do
        expect(subject).to redirect_to(admin_phones_path)
        expect(flash[:notice]).to include(update_message)
      end

      it 'updates the correct attributes' do
        update
        expect(assigns(:phone)).to have_attributes params[:phone]
      end

      it 'saves the record' do
        update
        expect(assigns(:phone)).to_not be_changed
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
    subject(:new) { get :new }

    it { is_expected.to be_successful }
    it { is_expected.to render_template :new }

    it 'loads a new phone' do
      new
      expect(assigns(:phone)).to_not be_persisted
    end
  end

  describe 'POST create' do
    context 'no error in save' do
      subject(:create_action) { post :create, params: params }

      it 'redirects back to index' do
        expect(subject).to redirect_to(admin_phones_path)
        expect(flash[:notice]).to include(create_message)
      end

      it 'creates the new record' do
        create_action
        expect(assigns(:phone)).to be_persisted
      end

      it 'assigns the correct values' do
        create_action
        expect(assigns(:phone)).to have_attributes params[:phone]
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
    subject(:destroy) { delete :destroy, params: { id: phone.id } }

    it { is_expected.to redirect_to admin_phones_path }

    it 'destroys the correct object' do
      expect { destroy }
        .to change { Phone.exists? phone.id }
        .from(true).to false
    end

    it 'shows success delete message' do
      destroy
      expect(flash[:notice]).to include(delete_message)
    end
  end
end
