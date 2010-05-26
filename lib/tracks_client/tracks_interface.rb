module Tracks

  class Interface
    
    def initialize(client)
      @client = client
      @lines = 10
    end
    
    def take_command
      puts "Enter Command: "
      cmd_key = gets.chomp
      case cmd_key
      when "l"
        puts "Todos List"
        list_todos_by_context
      when "c"
        puts "Create todo"
      when "h"
        puts "Help menu"
      end
    end
    
    def list_todos_by_context(context_id=nil)
      @client.contexts.each_with_index do |context,ci|
        next unless !context_id || context.id == context_id

        if context.todos.size > 0
          todos = context.todos.map {|t| t.description}
          header = context.name
          list_with_header(todos, header, ci+1)
        end

      end
    end
    
    def list_with_header(list, header, prefix)
      last_index = 0
      puts
      puts "=== #{header} ==="
      while last_index < list.size
        new_index = last_index+@lines
        list[last_index..new_index].each_with_index do |item,i|
          puts "[#{prefix}.#{i+last_index+1}] #{item}"
        end
        last_index = new_index+1
      end
      puts "====#{["="]*header.size}===="
      puts
    end
    
  end
  
end