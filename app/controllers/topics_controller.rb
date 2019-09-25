class TopicsController < ApplicationController
    def index
        @topics = Topic.where(is_completed: false).order('created_at DESC')
    end

    def new
        @topic = Topic.new
        @topic.notes.build
    end

    def create
        @topic = Topic.new(set_params)
        if  @topic.save
            notes = params[:topic][:notes]
            notes.each {|n| @topic.notes.create(description: n[:description])}
            flash[:success] = "The topic was created successfully."
            redirect_to topic_path(@topic)
        else
            render "new"
        end     
    end

    def show
        @topic = Topic.find(params[:id])
    end

    def update_approval
        @topic = Topic.find(params[:id])
        
        if @topic.toggle(:is_approved).save 
            flash[:success] = "The topic was updated successfully."
        else
            flash.now[:error] = "topic could not be saved."
        end
        render "show"
    end

    def finish
        @topic = Topic.find(params[:id])
        
        if @topic.toggle(:is_completed).save
            flash[:success] = "The topic was updated successfully."
        else
            flash.now[:error] = "The topic could not be saved."
        end
        redirect_to topic_path(@topic)
    end

    def finished_topics
        @topics = Topic.where(is_completed: true).order('created_at DESC')
        render "completed"
    end


    private
    def set_params
        params.require(:topic).permit(:title, :url, notes_atributes: [:description])
    end

end
