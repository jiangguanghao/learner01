class NotesController < ApplicationController
  def new
    @task = Task.find(params[:task_id])
    @note = Note.new
  end

  def create
    @task = Task.find(params[:task_id])
    @note = Note.new(note_params)
    @note.task = @task
    @note.user = current_user

    if @note.save
      redirect_to task_path(@task)
    else
      render :new
    end
  end

  private

  def note_params
    params.require(:note).permit(:content)
  end

end
