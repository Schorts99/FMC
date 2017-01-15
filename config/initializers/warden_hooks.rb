Warden::Manager.after_set_user do |student, auth, opts|
  auth.cookies.signed["student.id"] = student.id
  auth.cookies.signed["student.expires_at"] = 30.minutes.from_now
end

Warden::Manager.before_logout do |student, auth, opts|
  auth.cookies.signed["student.id"] = nil
  auth.cookies.signed["student.expires_at"] = nil
end
