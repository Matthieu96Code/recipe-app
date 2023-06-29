class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new # guest user (not logged in)

    # check if user is admin and give admin full privellage
    if user.admin?
      can :manage, :all
    else
      can :read, :all
      can :manage, Recipe, user_id: user.id
      can :manage, RecipeFood, user_id: user.id
    end
  end
end
