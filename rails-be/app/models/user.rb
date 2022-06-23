class User < ApplicationRecord
  has_secure_password
  has_many :orders 

  validates :login_id , presence: true , uniqueness: true
  validates :password , presence: true, allow_nil: true
  validates :role , presence: true , inclusion: { in: [0 , 1 , 2 ,3] }
  validates :status , presence: true , inclusion: { in: [0 ,1] }
  validates :display_name , uniqueness: true

  def is_admin?
    role == 0
  end

  def is_staff?
    [1,2].include? role
  end

  def is_table?
  role == 3
  end

end
