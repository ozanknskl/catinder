class Location < ApplicationRecord
  def city_and_country
    "#{city} , #{country}"
  end
end
