class LeasesController < ApplicationController
rescue_from ActiveRecord::RecordInvalid, with: :render_invalid
rescue_from ActiveRecord::RecordNotFound, with: :render_not_found

    def create
        lease = Lease.create!(lease_params)
        render json: lease, status: :created
    end

    def destroy
        lease = Lease.find(params[:id])
        lease.destroy
        render json: {}, status: :ok
    end

    private

    def lease_params
        params.permit(:rent, :apartment_id, :tenant_id)
    end

    def render_invalid(exception)
        render json: {error: exception}, status: :unprocessable_entity
    end

    def render_not_found
        render json: {error: "Lease not found"}, status: :not_found
    end
end
