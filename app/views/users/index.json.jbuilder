json.array!(@users) do |user|
  json.extract! user, :id, :name, :about, :email, :password
  json.url user_url(user, format: :json)
end
