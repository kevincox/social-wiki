class SubjectsController < ApplicationController
  before_action :set_subject, only: [:new, :show, :edit, :update, :destroy]
  
  def index
    @subjects = Subject.all
  end
  
  def show
    @post = Post.new
  end

  def new
    @subject = Subject.new
  end

  def create
    @subject = Subject.new(subject_params)
    respond_to do |format|
      if @subject.save
        format.html { redirect_to @subject, notice: 'Subject was successfully created.' }
      else
        format.html { render :new }
      end
    end
  end

  def set_subject
    @subject = Subject.find_by_name params[:id]
  end

  def subject_params
    params.require(:subject).permit(:name, :desc)
  end
end
