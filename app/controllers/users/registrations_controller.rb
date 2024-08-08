# frozen_string_literal: true

module Users
  class RegistrationsController < Devise::RegistrationsController
    respond_to :json, :html

    private

    def respond_with(resource, _options = {})
      if resource.persisted?
        render json: {
          status: { code: 200, message: 'Signed up successfully',
                    data: resource }
        }, status: :ok
      else
        render json: {
          status: { message: 'User could not be created successfully',
                    errors: resource.errors.full_messages }
        }
      end
    end
  end
end
