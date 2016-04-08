class User < ActiveRecord::Base

  before_save { self.email = email.downcase }
  before_save :capname

  def capname
    if name
      fix_array = []
      name.split.each do |fix|
        fix_array << fix.capitalize
      end
      self.name = fix_array.join(" ")
    end
  end

##self.name = name.split.capitalize.join(' ')

  validates :name, length: {minimum: 1, maximum: 100 }, presence: true
  validates :password, presence: true, length: { minimum: 6 }, if: "password_digest.nil?"
  validates :password, length: { minimum: 6 }, allow_blank: true
  validates :email, presence: true,
            uniqueness: { case_sensitive: false },
            length: { minimum: 3, maximum: 254 }
  has_secure_password


end
