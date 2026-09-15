# frozen_string_literal: true

module Admin
  class PhonesController < ApplicationController
    before_action :load_phone, only: %i[show edit update destroy]

    def index
      @phones = Phone.order(:manufacturer, :model)
    end

    def show; end

    def new
      @phone = Phone.new
    end

    def create
      @phone = Phone.new(phone_params)

      if @phone.save
        redirect_to admin_phones_path, notice: "Phone was successfully created."
      else
        flash.now[:alert] = "Please correct the errors below."
        render :new, status: :unprocessable_entity
      end
    end

    def edit; end

    def update
      if @phone.update(phone_params)
        redirect_to admin_phones_path, notice: "Phone was successfully updated."
      else
        flash.now[:alert] = "Please correct the errors below."
        render :edit, status: :unprocessable_entity
      end
    end

    def destroy
      if @phone.destroy
        redirect_to admin_phones_path, notice: "Phone was successfully deleted."
      else
        redirect_to admin_phones_path, alert: "Unable to delete the phone."
      end
    end

    private

    def phone_params
      params.require(:phone).permit(:manufacturer, :model, :manufacture_year)
    end

    def load_phone
      @phone = Phone.find(params[:id])
    end
  end
end
