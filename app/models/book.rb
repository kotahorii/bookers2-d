class Book < ApplicationRecord
	scope :latest, -> {order(created_at: :desc)}
	scope :rate, -> {order(rate: :desc)}

	belongs_to :user
	has_many :favorites, dependent: :destroy
	has_many :book_comments, dependent: :destroy


  def favorited_by?(user)
    favorites.where(user_id: user.id).exists?
  end

  def self.search_category(keyword)
  	where(["category like?", "#{keyword}"])
  end

	validates :title, presence: true
	validates :body, presence: true, length: {maximum: 200}
	validates :rate, numericality: {
    less_than_or_equal_to: 5,
    greater_than_or_equal_to: 1}, presence: true
end
