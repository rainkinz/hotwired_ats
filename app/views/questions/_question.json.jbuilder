json.extract! question, :id, :quiz_id, :content, :image, :created_at, :updated_at
json.url question_url(question, format: :json)
