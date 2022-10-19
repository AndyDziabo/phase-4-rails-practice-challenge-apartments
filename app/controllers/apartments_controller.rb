class ApartmentsController < ApplicationController
rescue_from ActiveRecord::RecordNotFound, with: :render_not_found
rescue_from ActiveRecord::RecordInvalid, with: :render_invalid

    def index
        render json: Apartment.all, status: :ok
    end

    def show
        apartment = Apartment.find(params[:id])
        render json: apartment, status: :ok
    end

    def create
        apartment = Apartment.create!(apartment_params)
        render json: apartment, status: :created
    end

    def destroy
        apartment = Apartment.find(params[:id])
        apartment.destroy
        render json: {}, status: :ok
    end

    private

    def render_not_found
        render json: {error: "Apartment not found"}, status: :not_found
    end

    def render_invalid(exception)
        render json: {error: exception}, status: :unprocessable_entity
    end

    def apartment_params
        params.permit(:number)
    end
end
