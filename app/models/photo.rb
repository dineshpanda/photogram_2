class Photo < ApplicationRecord
  # Direct associations

  belongs_to :owner,
             :required => false,
             :class_name => "User",
             :counter_cache => true

  # Indirect associations

  # Validations

  validates :image, :presence => true

  validates :owner_id, :presence => true

  # Scopes

end
