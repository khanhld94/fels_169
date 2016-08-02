class Ability
  include CanCan::Ability

  def initialize user
    user ||= User.new
    can :manage, Category if user.admin?
  end
end
