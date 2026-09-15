# frozen_string_literal: true

module Admin
  class VariantsController < ApplicationController
    before_action :load_variant, only: %i[show edit update destroy]
    before_action :load_phone, only: %i[index new create]

    def index
      @variants = @phone.variants.order(:storage, :color)
    end

    def show; end

    def new
      @variant = @phone.variants.build
    end

    def create
      @variant = @phone.variants.build(variant_params)

      if @variant.save
        redirect_to admin_phone_path(@phone), notice: "Variant was successfully created."
      else
        flash.now[:alert] = "Please correct the errors below."
        render :new, status: :unprocessable_entity
      end
    end

    def edit
      @phone = @variant.phone
    end

    def update
      @phone = @variant.phone

      if @variant.update(variant_params)
        redirect_to admin_phone_path(@phone), notice: "Variant was successfully updated."
      else
        flash.now[:alert] = "Please correct the errors below."
        render :edit, status: :unprocessable_entity
      end
    end

    def destroy
      phone = @variant.phone

      if @variant.destroy
        redirect_to admin_phone_path(phone), notice: "Variant was successfully deleted."
      else
        redirect_to admin_phone_path(phone), alert: "Unable to delete the variant."
      end
    end

    private

    def variant_params
      params.require(:variant).permit(:color, :storage, :count_on_hand)
    end

    def load_variant
      @variant = Variant.find(params[:id])
    end

    def load_phone
      @phone = Phone.find(params[:phone_id])
    end
  end
end
