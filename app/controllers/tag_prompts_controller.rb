class TagPromptsController < ApplicationController
  skip_before_action :verify_authenticity_token

  def action_allowed?
    return true
  end

  # GET /tag_prompts/view
  def show
    @popup = false
    if params.key?(:popup) and params[:popup].to_s.downcase == 'true'
      @popup = true
      render layout: false
    end
  end


  def index
    @tagprompts = TagPrompt.all.order("prompt asc")
    if params.key?(:prompt) and !params[:prompt] == ""
      @tagprompts.where!("prompt LIKE ?", "%#{params[:prompt]}%")
    end
    if params.key?(:desc) and !params[:desc] == ""
      @tagprompts.where!("desc LIKE ?", "%#{params[:desc]}%")
    end
    if params.key?(:control_type) and !params[:control_type] == ""
      @tagprompts.where!("control_type LIKE ?", "%#{params[:control_type]}%")
    end
    render json:@tagprompts
  end

  def create
    @tagprompt = TagPrompt.new(prompt: params[:prompt], desc: params[:desc], control_type: params[:control_type])
    @tagprompt.save
    render json: @tagprompts
  end

  def update
    @tagprompt = TagPrompt.find(params[:id])
    @tagprompt.update(prompt: params[:prompt], desc: params[:desc], control_type: params[:control_type])
    render json: @tagprompts
  end

  def destroy
    @tagprompt = TagPrompt.find(params[:id])
    @tagprompt.destroy
    render nothing: true, status: 200
  end
end
