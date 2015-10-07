class Event < ActiveRecord::Base
	has_and_belongs_to_many :users
	belongs_to :organization

	serialize :categories,Array

	has_attached_file :photo, :styles => { :medium => "720x550#", :thumb => "100x100>" }, :default_url => "/default"
    validates_attachment_content_type :photo, :content_type => /\Aimage\/.*\Z/

    def image
    	if photo.url != "/default"
    		photo.url(:medium)
    	else
    		'portfolio/img1.jpg'
    	end
    end


end
