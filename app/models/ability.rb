class Ability
  include CanCan::Ability

  def initialize user
    user ||= User.new
    can [:new, :create], Category if user.admin?
  end
end
