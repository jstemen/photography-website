json.array!(@users) do |user|
  json.extract! user, :first_name, :lastName, :email_address, :password
  json.url user_url(user, format: :json)
end
