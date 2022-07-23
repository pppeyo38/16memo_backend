class User < ApplicationRecord
  has_many :memos
  has_many :color_files
end
