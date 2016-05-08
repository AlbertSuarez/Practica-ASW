json.array!(@submissions) do |submission|
  json.extract! submission, :id, :title, :url, :text, :user_id
  json.url submission_url(submission, format: :json)
  json.set! "_links" do
    json.set! "user" do
      json.set! "href", "/users/"+submission.user_id.to_s+".json"
    end
  end
end
