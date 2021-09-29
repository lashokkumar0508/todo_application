require "./connect_db.rb"
require "./todo.rb"

connect_db!
Todo.show_list_with_ID

puts "Which todo do you want to mark as complete? (Enter id): "
todo_id = gets.strip.to_i

todo = Todo.mark_as_complete(todo_id)
puts todo.to_displayable_string
