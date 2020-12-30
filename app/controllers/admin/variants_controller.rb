# frozen_string_literal: true

module Admin
  class VariantsController < ApplicationController
    before_action :load_variant, only: %i[show edit update destroy]
    before_action :load_phone, only: %i[index new create]

    # GET /admin/phones/1/variants
    def index
      @variants = @phone.variants
    end

    # GET /admin/variants/1
    def show; end

    # GET /admin/phones/1/variants/new
    def new
      @variant = @phone.variants.build
    end

    # POST /admin/phones/1/variants
    def create
      @variant = @phone.variants.build(variant_params)

      if @variant.save
        redirect_to admin_phone_path(@variant.phone_id), notice: 'Variant was successfully created.'
      else
        flash.now[:alert] = 'Error! Please try again'
        render action: 'new'
      end
    end

    # GET /admin/variants/:1/edit
    def edit; end

    # PATCH /admin/variants/1
    def update
      if @variant.update(variant_params)
        redirect_to admin_phone_path(@variant.phone_id), notice: 'Variant was successfully updated.'
      else
        flash.now[:alert] = 'Error! Please try again'
        render action: 'edit'
      end
    end

    # DELETE admin/variants/1
    def destroy
      if @variant.destroy
        redirect_to admin_phone_path(@variant.phone_id), notice: 'Variant was successfully deleted.'
      else
        redirect_to admin_phone_path(@variant.phone_id), alert: 'Error! Please try again'
      end
    end

    private

    # Only allow a trusted parameter "white list" through.
    # @returns [ActionController::Parameters]
    def variant_params
      params.require(:variant).permit(:phone_id, :color, :storage, :count_on_hand)
    end

    # @returns [Variant]
    def load_variant
      @variant = Variant.find(params[:id])
    end

    # @returns [Phone]
    def load_phone
      @phone = Phone.find(params[:phone_id])
    end
  end
end
