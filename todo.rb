require 'active_record'

class Todo < ActiveRecord::Base
  def due_today?
    due_date == Date.today
  end

  def to_displayable_string
    display_status = completed ? "[X]" : "[ ]"
    display_date = due_today? ? nil : due_date
    "#{id}#{display_status} #{todo_text} #{display_date}"
  end
  
  def self.overdue
    where("due_date < ?", Date.today)
  end
  def self.duetoday
    where("due_date = ?", Date.today)
  end
  def self.duelater
    where("due_date > ?", Date.today)
  end

  def self.show_list
    puts "My Todo-list\n\n"

    puts "Overdue\n"
    puts overdue.map {|todo| todo.to_displayable_string }
    puts "\n\n"

    puts "Due Today\n"
    puts duetoday.map {|todo| todo.to_displayable_string }
    puts "\n\n"

    puts "Due Later\n"
    puts duelater.map {|todo| todo.to_displayable_string }
    puts "\n\n"

  end
  
  #method to add task in todo
  def self.add_task(h)
    Todo.create!(todo_text: h[:todo_text], due_date: Date.today + h[:due_in_days], completed: false)
  end
  # method to mark as complet based on the record ID
  def self.mark_as_complete(todo_id)
    todo = Todo.find(todo_id)
    todo.completed = true
    todo.save
    todo
  end

end
