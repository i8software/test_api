module CustomTokenErrorResponse
  def body
    {
      error: 'Invalid email/password provided'
    }
  end
end
