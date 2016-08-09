PublicActivity::Activity.class_eval do
  scope :all_activity, -> user_id{where "owner_id IN (SELECT followed_id
    FROM relationships WHERE follower_id = #{user_id})
    OR owner_id = #{user_id} AND owner_type = 'User'"}
end
