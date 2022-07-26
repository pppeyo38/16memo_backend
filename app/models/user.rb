class User < ApplicationRecord
  has_many :memos, dependent: :destroy
  has_many :color_files, dependent: :destroy
end
