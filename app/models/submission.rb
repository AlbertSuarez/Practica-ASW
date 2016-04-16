class Submission < ActiveRecord::Base
  belongs_to :user
  #Maximum defined 200
  validates :title, length: { maximum: 200 }
end
