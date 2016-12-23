class Cat < ApplicationRecord
  belongs_to :user
  belongs_to :cat_type
  belongs_to :location

  validates :name, :color, :age, presence: true

  enum gender: [ :male, :female ]

  CAT_HEALTHS_ARR = [["Unhealthy",1],["Not so healthy",2],["Average",3],["Just a few problems",4],["Perfect",5]]
  # Cat healths
  CAT_HEALTHS_HASH = {
    1 => 'Unhealthy',
    2 => 'Not so healthy'
  }

  def self.search(search)
    # where("name ILIKE ? OR age ILIKE ? OR location ILIKE ? OR gender ILIKE ? OR cat_type ILIKE ?", "%#{search}% , %#{search}%, %#{search}%, %#{search}%, %#{search}%")
    name_cats =  where("name ilike ?", "%#{search}%")
    type_cats = CatType.where("name ilike ?", "%#{search}%").collect(&:cats)
    location_cats = Location.where("country ilike ? or city ilike ?",
                                   "%#{search}%", "%#{search}%").collect(&:cats)
    result = name_cats + type_cats.flatten + location_cats.flatten
    result.uniq
  end

  def show_hyperactivity
    if hyperactivity == 1
      "Low"
    elsif hyperactivity == 2
      "Medium"
    else
      "High"
    end
  end

  def show_gender
    if gender == 1
      "Male"
    else
      "Female"
    end
  end

  def show_health
    if health == 1
      "Unhealthy"
    elsif health == 2
      "Not so healthy"
    elsif health == 3
      "Average"
    elsif health == 4
      "Just a few problems"
    else
      "Perfect"
    end
  end


end
