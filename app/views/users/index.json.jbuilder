json.array!(@users) do |user|
  json.extract! user, :id, :username, :password, :email, :up_vote, :down_vote
  json.url user_url(user, format: :json)
end
