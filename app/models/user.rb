class User < ApplicationRecord
  # Direct associations

  # Indirect associations

  # Validations

  validates :username, :presence => true

  validates :username, :exclusion => { :in => [ 'qwerty', 'abcdef' ]  }

  # Scopes

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
end
