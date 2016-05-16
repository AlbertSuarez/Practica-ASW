json.array!(@users) do |user|
  json.extract! user, :id, :name, :about, :created_at
  json.set! "_links" do
    json.set! "self" do
      json.set! "href", user_url(user, format: :json)
    end
  end
end
