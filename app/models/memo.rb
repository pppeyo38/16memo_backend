class Memo < ApplicationRecord
  belongs_to :user
  belongs_to :tag
  belongs_to :color_file
end
