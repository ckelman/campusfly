class Organization < ActiveRecord::Base

	has_and_belongs_to_many :users
	has_many :events, dependent: :destroy

	has_attached_file :photo, :styles => { :medium => "250x250#", :thumb => "100x100>" }, :default_url => "/images/original/missing.png"
    validates_attachment_content_type :photo, :content_type => /\Aimage\/.*\Z/

    validates :name, presence: true, uniqueness: true

end
