module ApplicationCable
  class Connection < ActionCable::Connection::Base
    identified_by :current_user

    def connect
      @params = request.params
      connecting_user = verify_user
      reject_unauthorized_connection if connecting_user.nil?
    end

    private

    def user_from_doorkeeper_bearer
      bearer = @params[:bearer]
      token = Doorkeeper::AccessToken.find_by(token: bearer)
      if token && token.accessible?
        user = User.find_by_id(token.resource_owner_id)
        return user
      end
      nil
    end

    def verify_user
      user_from_doorkeeper_bearer
    rescue
      return nil
    end
  end
end
