class FriendshipDecorator < Draper::Decorator
  delegate_all

  def student_view
    (h.current_student == object.student) ? object.friend : object.student
  end

  def status_or_buttons
  	return buttons_pending if object.pending? && object.student != h.current_student
    return buttons_accepted if object.active?
    return unblock_button if object.block? && object.student != h.current_student
  	return status
  end

  def status
  	return "Espernado respuesta" if object.pending?
  end

  def buttons_pending
  	(confirm_button + denegate_button).html_safe
  end

  def buttons_accepted
    (delete_button + block_button).html_safe
  end

  def unblock_button
    h.link_to "Desbloquear", h.friendship_path(object), method: :delete, class:"mdl-button mdl-js-button mdl-button--raised mdl-button--colored"
  end

  def block_button
    h.link_to "Bloquear", h.friendship_path(object, status: 0), method: :patch, class:"mdl-button mdl-js-button mdl-button--raised mdl-button--accent"
  end

  def delete_button
    h.link_to "Eliminar", h.friendship_path(object), method: :delete, class:"right-space mdl-button mdl-js-button mdl-button--raised mdl-button--accent"
  end

  def confirm_button
  	h.link_to "Aceptar", h.friendship_path(object, status: 1), method: :patch, class:"right-space mdl-button mdl-js-button mdl-button--raised mdl-button--colored"
  end

  def denegate_button
  	h.link_to "Rechazar", h.friendship_path(object), method: :delete, class:"mdl-button mdl-js-button mdl-button--raised mdl-button--accent"
  end

  # Define presentation-specific methods here. Helpers are accessed through
  # `helpers` (aka `h`). You can override attributes, for example:
  #
  #   def created_at
  #     helpers.content_tag :span, class: 'time' do
  #       object.created_at.strftime("%a %m/%d/%y")
  #     end
  #   end

end
