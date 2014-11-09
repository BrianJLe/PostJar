class Post < ActiveRecord::Base
	attr_accessible :content, :user_id, :avatar
	belongs_to :user
	has_attached_file :avatar, :styles => { :medium => "300x300>", :thumb => "100x100>" }, :default_url => "avatar/missing.jpg"
	has_many :comments
	include PublicActivity::Model
	tracked owner: ->(controller, model) { controller && controller.current_user }



	def self.find_with_filters(filters)
		Rails.logger.info("FILTERS")
		filtered_posts = Post


		if filters[:content] && filters[:content].length > 0
			content = filters[:content]
			filtered_posts = filtered_posts.where("content ILIKE ?", "%#{content}%")
		end

		filtered_posts
	end
end
