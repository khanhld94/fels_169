class Admin::StaticPagesController < Admin::BaseController
  def home
    [User, Activity, Word, Category].each do |model|
      instance_variable_set "@#{model.table_name}", model.all
    end
  end
end
