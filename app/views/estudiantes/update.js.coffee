$("#student-avatar .circle").css
	"background": "url(<%= @student.avatar.url(:medium) %>)"
	"background-size": "cover"
$("#student-cover").css
	"background": "url(<%= @student.cover.url(:medium) %>)"
	"background-size": "cover"
	"background-position": "center"