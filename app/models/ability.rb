class Ability
  include CanCan::Ability

  def initialize user, namespace
    user ||= User.new
    if namespace == "admin"
      if user.admin?
        can :manage, :all
      else
        cannot :manage, :all
      end
    else
      if user.admin?
        cannot :manage, :all
      else
        can :read, :all
        can :manage, Relationship
        can [:create, :update], Lesson
      end
    end
  end
end
