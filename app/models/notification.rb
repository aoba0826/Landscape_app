class Notification < ApplicationRecord
  belongs_to :post_image, optional: true
  belongs_to :post_comment, optional: true

  belongs_to :visiter, class_name: 'User', optional: true
  belongs_to :visited, class_name: 'User', optional: true
end
