class User < ApplicationRecord
    before_save { self.email = email.downcase }
    has_secure_password
    validate :has_email
    validates :password, presence: true, length: { minimum: 6 }
    def User.digest(string)
        cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST :
                                                      BCrypt::Engine.cost
        BCrypt::Password.create(string, cost: cost)
      end

      def has_email # Checks that email has a ValidEmail in database
        errors.add(:base, 'Email must be approved') unless ValidEmail.where(:email => self.email).exists?
      end
end
