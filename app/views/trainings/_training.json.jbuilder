json.extract! training, :id, :name, :date_of_completion, :duration, :training_expiry, :type, :training_provider, :created_at, :updated_at
json.url training_url(training, format: :json)
