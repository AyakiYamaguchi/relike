class Memo < ApplicationRecord
  validates :content, presence: true
  belongs_to :remind_list
end
