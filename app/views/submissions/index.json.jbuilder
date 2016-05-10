json.array!(@submissions) do |submission|
  json.extract! submission, :id, :title, :url, :text, :user_id
  json.set! "_links" do
    json.set! "self" do
      json.set! "href", submission_url(submission, format: :json)
    end
    json.set! "user" do
      json.set! "href", user_url(submission.user, format: :json)
    end
  end
end
