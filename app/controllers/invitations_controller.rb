class InvitationsController < ApplicationController
  def new
    @invitation = Invitation.new
  end

  def create
    @invitation = Invitation.new(params[:invitation])
    @invitation.sender = current_user
    if @invitation.save
      Mailer.invitation(@invitation, signup_url).deliver
      redirect_to posts_url, :notice => "Thank you, invitation sent."
    else
      render :action => 'new'
    end
  end
end
