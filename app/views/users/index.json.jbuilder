json.array!(@users) do |user|
  json.extract! user, :id, :name, :about, :email, :password
  json.set! "_links" do
    json.set! "self" do
      json.set! "href", user_url(user, format: :json)
    end
  end
end
