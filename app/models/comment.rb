class Comment < ActiveRecord::Base
    belongs_to :user
    belongs_to :post
    attr_accessible :content, :post_id
    include PublicActivity::Model
    tracked owner: ->(controller, model) { controller && controller.current_user }
end
