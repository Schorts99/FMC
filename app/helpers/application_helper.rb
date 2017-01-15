module ApplicationHelper
	def resource
		@resource ||= Student.new
	end

	def resource_name
		:student
	end

	def resource_class
		Student
	end

	def circle_img url, size= 50
		div = content_tag(:div, "", class:"circle cover", style:"height: #{size}px; width: #{size}px; background-image: url(#{url})")
		div.html_safe
	end
end