class Location < ApplicationRecord
  has_many :cats
  def city_and_country
    "#{city} , #{country}"
  end
end
