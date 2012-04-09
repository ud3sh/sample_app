# == Schema Information
#
# Table name: users
#
#  id         :integer         not null, primary key
#  name       :string(255)
#  email      :string(255)
#  created_at :datetime        not null
#  updated_at :datetime        not null
#

class User < ActiveRecord::Base 

  #note password, and password_confirmation are virtual in that they are
  #not mapped to a db column.  By convention, they are mapped to password_digest
  attr_accessible(:name, :email, :password, :password_confirmation)
  validates(:name, presence: true, length:{maximum:50})

  #constant regex for vaid email
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates(:email, presence: true, format: { with:VALID_EMAIL_REGEX }, uniqueness: {case_sensitive: false } )

  #validate the virtual attribute password
  validates :password, length: { minimum: 6 }
  validates :password_confirmation, presence: true

  #https://github.com/rails/rails/blob/master/activemodel/lib/active_model/secure_password.rb?version=3.2#
  has_secure_password()
end