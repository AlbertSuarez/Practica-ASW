json.array!(@submissions) do |submission|
  json.extract! submission, :id, :title, :url, :user_id
  json.url submission_url(submission, format: :json)
end
