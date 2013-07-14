class TodosController < ApplicationController

  # Initial display of todo list and primary access
  def index

    # Handle to a brand new todo
    @newtodo = Todo.new

    # Handles to unfinished todos in each quadrant
    # TODO: Possibly faster to have 1 database query and split it afterwards
    @is_todos = Todo.where(done: false, important: true, soon: true)
    @in_todos = Todo.where(done: false, important: true, soon: false)
    @ns_todos = Todo.where(done: false, important: false, soon: true)
    @nn_todos = Todo.where(done: false, important: false, soon: false)

    @todos = Todo.all

    # Handles to all finished todos
    @dones = Todo.where(done: true)
  end

  # Creates a new todo, initial fields
  def create
    @newtodo = Todo.create(todo_params)
    @newtodo.save

    redirect_to todos_path
  end

  def new
    @newtodo = Todo.new
  end

  def destroy
    Todo.delete(params[:id])
    redirect_to todos_path
  end

  # Allow for "mass" param setting
  private
  def todo_params
    params.require(:todo).permit(:description)
  end

end
