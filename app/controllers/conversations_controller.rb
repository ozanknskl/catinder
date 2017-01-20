class ConversationsController < ApplicationController
  before_action :set_conversation, except: [:index]
  before_action :check_participating!, except: [:index]
  before_action :group_messages, only: [:show]

  def index
    @conversations = Conversation.participating(current_user).order('updated_at DESC')
    @users = User.first(3)
  end

  def show
    @message = Message.new

    # time = message.created_at
    # if time.day == Time.now.day
    #   @message_time = time.to_s(:time)
    # else
    #   @message_time = time.to_s(:short)
    # end

    # @conversation.messages.each do |message|
    #
    #   if message
    #     old_message = message
    #     old_time = old_message.created_at
    #   end
    #   message = Message.new
    #   time = message.created_at
    #   if time.day == Time.now.day
    #     if old_time.to_s(:time) == time.to_s(:time)
    #       @message_time = ""
    #     else
    #       @message_time = time.to_s(:time)
    #     end
    #   else
    #      @message_time = time.to_s(:short)
    #   end
    #
    # end
  end

  private

  def group_messages

    @messages_array = []
    message_hash = {}
    @conversation.messages.each do |message|
      if message == @conversation.messages.first
        message_hash = {:user => message.user, :created_at => message.created_at, :contents => [message.body]}
      else
        # binding.pry
        if message_hash[:created_at].to_s(:time) == message.created_at.to_s(:time)
          message_hash[:contents].push(message.body)

        else
          @messages_array.push(message_hash)
          message_hash = {:user => message.user, :created_at => message.created_at, :contents => [message.body]}
        end
      end
    end

    @messages_array.push(message_hash)
  end

  def set_conversation
    @conversation = Conversation.find(params[:id])
  end

  def check_participating!
    redirect_to conversations_path unless @conversation && @conversation.participates?(current_user)
  end
end
