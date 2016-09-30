module Api
  module V1
    class SessionsController < ApplicationController
      skip_before_action :authenticate

      def create
        user = User.find_by(name: user_params[:name])
        if user.authenticate(user_params[:password])
          jwt = Auth.issue({user: user.id})
          render json: {jwt: jwt}
        end
      end

    private
      def user_params
        params.require(:user).permit(:name, :password)
      end

    end
  end
end
