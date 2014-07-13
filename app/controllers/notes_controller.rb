class NotesController < ApplicationController
  before_action :set_note, only: [:show, :destroy]
  after_filter :cors_set_access_control_headers
  skip_before_filter :verify_authenticity_token

  

  def index
    @notes = Note.all
    render json: { notes: @notes.as_json(only: [:id, :title]) }    
  end


  def show
    render json: { note: @note.as_json(only: [:id, :title]) }
  end

  def create

    if request.method == "OPTIONS"
      render nothing: true
    else
      @note = Note.new(note_params)
      if @note.save
        render json: { note: @note.as_json(only: [:id, :title]) }, status: :created 
      else
        render json: @note.errors, status: :unprocessable_entity
      end
    end
  end

  def destroy   
    @note.destroy 
    render json: { nothing: true }, status: :no_content
  end

  private

  def set_note
    @note = Note.find(params[:id])
  end

  def note_params
    params.require(:note).permit(:title)
  end

  # For all responses in this controller, return the CORS access control headers.
  def cors_set_access_control_headers
    headers['Access-Control-Allow-Origin'] = '*'
    headers['Access-Control-Allow-Methods'] = 'GET, POST, DELETE, OPTIONS'
    headers['Access-Control-Max-Age'] = "1728000"
    headers['Access-Control-Allow-Headers'] =
      %w{ Date X-Apiary-Ratelimit-Limit X-Apiary-Transaction-Id X-Apiary-Ratelimit-Remaining Content-Length Connection Content-Type}.join(",")
  end
end
