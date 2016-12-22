json.extract! cat, :id, :user_id, :cat_type_id, :location_id, :name, :age, :color, :hyperactivity, :health, :about, :created_at, :updated_at
json.url cat_url(cat, format: :json)