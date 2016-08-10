module ApplicationHelper
  def full_title page_title = ""
    base_title = t "static_pages.framgia"
    page_title.empty? ? base_title : page_title + " | " + base_title
  end

  def link_to_add_fields name, f, association
    new_object = f.object.send(association).build
    id = new_object.object_id
    fields = f.fields_for association, new_object, child_index: id do |builder|
      render association.to_s.singularize + "_fields", f: builder
    end
    link_to name, "#", class: "add_fields", data: {id: id, fields: fields.gsub("\n", "")}
  end

  def link_to_add_fields_search name, f, type
    new_object = f.object.send "build_#{type}"
    id = "new_#{type}"
    fields = f.send "#{type}_fields", new_object, child_index: id do |builder|
      render type.to_s + "_fields", f: builder
    end
    link_to name, "#", class: "add_fields", 
      data: {id: id, fields: fields.gsub("\n", "")}
  end

  def get_correct_answer word
    word.word_answers.find_by is_correct: true
  end
  
  def lesson_status_class lesson
    lesson.finished? ? "btn btn-danger" : "btn btn-warning"
  end

  def correct_answer_class word_answer
    if word_answer.nil?
      word_answer = "glyphicon glyphicon-remove"
    else
      word_answer.is_correct? ? "glyphicon glyphicon-ok" 
        : "glyphicon glyphicon-remove"
    end
  end

  def correct_answer_background_class word_answer
    if word_answer.nil?
      word_answer = "danger"
    else
      word_answer.is_correct? ? "success" : "danger"
    end
  end

  def current_user_activity_owner? a
    current_user.id == a.owner.id
  end
end
