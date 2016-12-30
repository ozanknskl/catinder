class Cat < ApplicationRecord
  belongs_to :user
  belongs_to :cat_type
  belongs_to :location

  validates :name, :color, :age, :user, :cat_type, :location, presence: true

  enum gender: [ :male, :female ]

  has_attached_file :image, styles: { large: "350x350#", medium: "200x200>", small:"100x100>"}
  validates_attachment_content_type :image, content_type: /\Aimage\/.*\Z/


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
    # gender_cats = where("gender ilike ?", "%#{search}%")

    result = name_cats + type_cats.flatten + location_cats.flatten
    result.uniq
  end

  def self.custom_search(hyperactivity, health,location_search,type_search, gender_id)
    #puts custom_search['gender']
    # hyperactivity_cats = csearch['hyperactivity']
    # health_cats = csearch['health']
    gender_cats = (gender_id != "2") ? where("gender = #{gender_id}") : self.all
    type_id = type_search.values[0].to_i
    type_cats = !type_search.values[0].blank? ? CatType.where("id = #{type_id}").collect(&:cats).flatten : self.all
    location_id = location_search.values[0].to_i
    location_cats = !location_search.values[0].blank? ? Location.where("id = #{location_id}").collect(&:cats).flatten : self.all
    hyperactivity_cats = (hyperactivity.to_i != 0) ? where("hyperactivity = #{hyperactivity}") : self.all
    health_cats = (health.to_i != 0) ? where("health = #{health}") : self.all
    result =  location_cats & hyperactivity_cats & health_cats & type_cats & gender_cats
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
    if gender == "male"
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
