class Comment < ActiveRecord::Base
  acts_as_voteable
  belongs_to :user
  belongs_to :submission
  
  validates :content, presence: true
end
