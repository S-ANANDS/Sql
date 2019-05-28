require 'pry'
require 'sqlite3'

def sql(file)
  SQLite3::Database.open (file)
end

def insertion(task)
  db = sql('database.db')
  db.execute "INSERT INTO Tasks(Id,Name,Status) VALUES (NULL,?,'Notcompleted')", [task]
end

def all_data
  db = sql('database.db')
  db.execute 'SELECT * FROM Tasks'
end

def sel_information(t_no)
  db = sql('database.db')
  a = db.execute "SELECT * FROM Tasks WHERE Id = ? ",[t_no]
end

def mark_finished(t_no)
  db = sql('database.db')
  db.execute "UPDATE Tasks SET Status = 'Completed' WHERE Id = ? ", [t_no]
end

def delete(t_no)
  db = sql('database.db')
  db.execute 'DELETE FROM Tasks WHERE ID = ?',[t_no]
end

def completed
  db = sql('database.db')
  db.execute "SELECT * FROM Tasks WHERE Status = ? ",'Completed'
end

def ncompleted
  db = sql('database.db')
  db.execute "SELECT * FROM Tasks WHERE Status = ? ",'Notcompleted'
end

puts "What do you want to do?
      1. Add a task
      2. See all tasks
      3. See a specific task
      4. Mark a task as finished
      5. Remove a task
      6. All the Completed Tasks
      7.All the Incomplete Tasks
      8.Exit"

db = sql('database.db')
a=db.execute "CREATE TABLE IF NOT EXISTS Tasks(Id INTEGER PRIMARY KEY,
        Name VARCHAR,Status TEXT)"
choice=0

while (choice!= 8)
  puts "      "
  puts 'Enter your choice'
  choice = gets.chomp
  case choice
  when '1'
    puts 'Description of the task '
    task = gets.chomp
      insertion(task)
  when '2'
    puts "All the data"
    print all_data
    puts "      "
  when '3'
    puts 'Enter the task number'
    t_no = gets.chomp
    a = sel_information(t_no)
    puts "Id = #{a[0][0]} Name = #{a[0][1]} Status = #{a[0][2]} "
  when '4'
    puts 'Enter the tak number'
    t_no = gets.chomp
    mark_finished(t_no)
    puts "Updated Coloum"
    print sel_information(t_no)
  when '5'
    puts 'Enter the task to be deleted'
    t_no = gets.chomp
    delete(t_no)
  when '6'
    puts "All the completed Tasks"
    print completed
  when '7'  
    puts "All the completed Tasks"
    print ncompleted
  when '8'
    puts "Good bye"  
  break
  else
    puts 'Enter a Valid choice'
  end
end
