class User < ActiveRecord::Base
  has_many :submissions
  validates :name, presence: true
  validates :password, presence: true
end
