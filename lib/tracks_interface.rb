module Tracks

  class Interface
    
    def initialize(client)
      @client = client
      @lines = 10
    end
    
    def list_todos_by_context
      @client.contexts.each_with_index do |context,ci|
        if context.todos.size > 0
          todos = context.todos.map {|t| t.description}
          header = context.name
          list_with_header(todos, header, ci+1)
        end
      end
    end
    
    def list_with_header(list, header, prefix)
      last_index = 0
      puts "=== #{header} ==="
      while last_index < list.size
        new_index = last_index+@lines
        list[last_index..new_index].each_with_index do |item,i|
          puts "[#{prefix}:#{i+last_index+1}] #{item}"
        end
        last_index = new_index+1
        gets
      end
    end
    
  end
  
end