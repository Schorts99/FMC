json.post do
  json.id @post.id
  json.body @post.body
  json.student_id @post.student_id
  json.created_at @post.created_at
  json.updated_at @post.updated_at
end
