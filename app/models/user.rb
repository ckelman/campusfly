class User < ActiveRecord::Base
	has_and_belongs_to_many :events
  has_and_belongs_to_many :organizations


  # validates :email, presence: true, uniqueness: true
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable, :omniauthable,
         :recoverable, :rememberable, :trackable, :validatable


  def self.from_omniauth(auth)
  	 user = where(auth.slice(:provider, :uid)).first_or_create do |user|
  		user.provider = auth.provider
  		user.uid = auth.uid
  		user.first_name = auth.info.first_name
  		user.last_name = auth.info.last_name
  		# user.email = auth.info.email
  	end
    user.oauth = auth.credentials.token
    user

  end

  def self.new_with_session(params, session)
  	if session["devise.user_attributes"]
  		new(session["devise.user_attributes"], without_protection: :true) do |user|
  			user.attributes = params
  			user.valid?
  		end
  	else
  		super
  	end
  end

  def facebook
    @facebook ||= Koala::Facebook::API.new(oauth)
  end

  def password_required?
    super && provider.blank?
  end

  def image_large
    if oauth
    facebook.get_picture(facebook.get_object("me")["id"], :type => "large")
    else
      "faUser1.png"
    end
  end

  def image
    if oauth
    facebook.get_picture(facebook.get_object("me")["id"])
    else
      "faUser1.png"
    end
  end





end
