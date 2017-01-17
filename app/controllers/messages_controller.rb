class MessagesController < ApplicationController
  before_action :find_conversation!, except: [:index]

  def create
    @conversation ||= Conversation.create(sender_id: current_user.id,
                                        receiver_id: @receiver.id)
    @message = current_user.messages.build(message_params)
    @message.conversation_id = @conversation.id
    @message.save!

    flash[:success] = "Your message was sent!"
    redirect_to conversation_path(@conversation)
  end

  def new
    redirect_to conversation_path(@conversation) and return if @conversation
    @message = current_user.messages.build
  end

  def index
    @availableusers = User.all
  end

  private

  def message_params
    params.require(:message).permit(:body)
  end

  def find_conversation!
  if params[:receiver_id]
    @receiver = User.find(params[:receiver_id])
    redirect_to(conversations_path) and return unless @receiver
    @conversation = Conversation.between(current_user.id, @receiver.id)[0]
  else
    @conversation = Conversation.find(params[:conversation_id])
    redirect_to(conversations_path) and return unless @conversation && @conversation.participates?(current_user)
  end
end
end
