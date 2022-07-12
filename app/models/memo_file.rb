class MemoFile < ApplicationRecord
  belongs_to :memo
  belongs_to :color_file
end
