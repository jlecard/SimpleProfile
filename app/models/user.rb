class User < ActiveRecord::Base
  belongs_to :profile
  
  acts_as_authentic do |c|
    c.login_field = :email
    c.validate_login_field = false
  end
  validates_presence_of :last_name, :email, :crypted_password
  validates_uniqueness_of :email
  
  def full_name
    "#{self.first_name} #{self.last_name}"
  end
  
  def last_login
    if !self.last_login_at.nil? and  self.last_login_at < self.current_login_at
      return self.current_login_at
    end
    self.last_login_at
  end

end
