module CustomTokenResponse
  def body
    user_details = User.find(@token.resource_owner_id)
    # call original `#body` method and merge its result with the additional data hash
    super.merge({
	  email: user_details.email,
	  id: user_details.id
    })
  end
end
