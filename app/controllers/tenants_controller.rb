class TenantsController < ApplicationController
rescue_from ActiveRecord::RecordNotFound, with: :render_not_found
rescue_from ActiveRecord::RecordInvalid, with: :render_invalid

    def index
        render json: Tenant.all, status: :ok
    end

    def show
        tenant = Tenant.find(params[:id])
        render json: tenant, status: :ok
    end

    def create
        tenant = Tenant.create!(tenant_params)
        render json: tenant, status: :created
    end

    def destroy
        tenant = Tenant.find(params[:id])
        tenant.destroy
        render json: {}, status: :ok
    end

    private

    def render_not_found
        render json: {error: "Tenant not found"}, status: :not_found
    end

    def render_invalid(exception)
        render json: {error: exception}, status: :unprocessable_entity
    end

    def tenant_params
        params.permit(:name, :age)
    end
end
