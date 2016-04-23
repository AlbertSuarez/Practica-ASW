json.array!(@submissions) do |submission|
  json.extract! submission, :id, :title, :url, :text, :user_id
  json.url submission_url(submission, format: :json)
end
