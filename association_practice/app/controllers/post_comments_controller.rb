class PostCommentsController < ApplicationController
  
  def create
    tweet = Tweet.find(params[:tweet_id])
    comment = PostComment.new(post_comment_params)
    comment.user_id = current_user.id
    comment.tweet_id = tweet.id
    comment.save
    redirect_to tweet_path(tweet.id)
    
  end 
  
  def destroy
    PostComment.find_by(id: params[:id], tweet_id: params[:tweet_id])
    redirect_to tweet_path(params[:tweet_id])
    
  end
  
  private
  
  def post_comment_params
    params.require(:post_comment).permit(:comment)
    
  end 
  
end
