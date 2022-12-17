json.post @post, :id, :title, :body

json.comments @post.comments, :id, :body, :created_at
json.author @post.author, :id, :email
json.users @post.users, :id, :email
json.comments_users_emails @post.comments.map{ |comment| { :"email_#{ comment.user.id }" => comment.user.email } }