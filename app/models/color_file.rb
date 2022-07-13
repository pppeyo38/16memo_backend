class ColorFile < ApplicationRecord
  belongs_to :user
  has_many :memos
end
