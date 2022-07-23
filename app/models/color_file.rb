class ColorFile < ApplicationRecord
  belongs_to :user
  has_many :memos, dependent: :destroy

  validates :name, uniqueness: { scope: :user_id  }
end
