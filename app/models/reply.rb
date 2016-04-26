class Reply < ActiveRecord::Base
  acts_as_voteable
  belongs_to :user
  belongs_to :comment
  
  validates :content, presence: true
end
