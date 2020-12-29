# frozen_string_literal: true

module Admin
  class PhonesController < ApplicationController
    before_action :load_phone, only: %i[show edit update destroy]

    # GET /admin/phones
    def index
      @phones = Phone.order(:manufacturer)
    end

    # GET /admin/phones/1
    def show; end

    # GET /admin/phones/new
    def new
      @phone = Phone.new
    end

    # POST /admin/phones
    def create
      @phone = Phone.new(phone_params)

      if @phone.save
        redirect_to admin_phones_path, notice: 'Phone was successfully created.'
      else
        flash.now[:alert] = 'Error! Please try again'
        render action: 'new'
      end
    end

    # GET /admin/phones/1/edit
    def edit; end

    # PATCH /admin/phones/1
    def update
      if @phone.update(phone_params)
        redirect_to admin_phones_path, notice: 'Phone was successfully updated.'
      else
        flash.now[:alert] = 'Error! Please try again'
        render action: 'edit'
      end
    end

    # DELETE admin/phones/1
    def destroy
      if @phone.destroy
        redirect_to admin_phones_path, notice: 'Phone was successfully deleted.'
      else
        redirect_to admin_phones_path, alert: 'Error! Please try again'
      end
    end

    private

    # Only allow a trusted parameter "white list" through.
    # @returns [ActionController::Parameters]
    def phone_params
      params.require(:phone).permit(:manufacturer, :model, :manufacture_year)
    end

    # @returns [Phone]
    def load_phone
      @phone = Phone.find(params[:id])
    end
  end
end
