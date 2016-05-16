class Profile < ActiveRecord::Base
  has_one :user
  has_many :statuses
  acts_as_gmappable :check_process=>false
  
  validates_presence_of :country, :city
  accepts_nested_attributes_for :user
  has_attached_file :image,
       :styles => {
       :thumb=> ["100x100^",:png],
       :small  => ["400x400>",:png] }
  
  self.per_page = 5
       
  def gmaps4rails_address
    # describe how to retrieve the address from your model, if you use directly a db column, you can dry your code, see wiki
    "#{self.street}, #{self.city}, #{self.zipcode}, #{self.country}" 
  end
  
  def gmaps4rails_infowindow
    html = "<h2>#{self.user.first_name}, #{self.user.last_name}</h2><br>"
    html += "#{ActionController::Base.helpers.link_to (I18n.t :view_profile),Rails.application.routes.url_helpers.profile_path(self)}"
    html
  end
  
  def last_status_message
    self.statuses.last.message if !self.statuses.empty?
  end
  
  def last_statuses(number)
    return self.statuses.last(number).reverse if !self.statuses.empty?
    []
  end

end
