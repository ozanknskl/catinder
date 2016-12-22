class Cat < ApplicationRecord
  belongs_to :user
  belongs_to :cat_type
  belongs_to :location

  validates :name, :color, :age, presence: true

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
