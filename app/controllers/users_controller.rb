class UsersController < ApplicationController
  # GET /users
  # GET /users.xml
  def index
    @users = User.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @users }
    end
  end

  def login
    @user = User.new
  end
  
  def process_login
    if user = User.authenticate(params[:user])
      session[:id] = user.id # Remember the user's id during this session 
      if user.type == "Mentor"
        session[:usertype] = :mentor
      elsif user.type == "Mentee"
        session[:usertype] = :mentee
      else
        session[:usertype] = :unknown
      end
      redirect_to session[:return_to] || '/', :notice => "Logged in."
    else
      redirect_to :action => 'login', :username => params[:user][:username], :notice => "Invalid login information."
    end
  end
  
  def logout
    reset_session
    redirect_to '/users/login' , :notice => "Logged out."
  end

  def forgot
    @user = User.new
  end

  def process_forgot
    # Match the given email address to the correct user
    @user = User.where(:email => params[:user][:email]).first

    if (@user != nil)
      # Create a new password reset request, remove old requests
      random = Digest::SHA1.hexdigest Time.now.to_s
      @passreset = PasswordReset.new(:user_id => @user.id, :code => random)
      PasswordReset.destroy_all(:user_id => @user.id)

      if (@passreset.save)
        Notifier.forgot_password_email(@user, @passreset).deliver
        redirect_to '/users/forgot', :notice => 'Password reset email sent!'
      else
        redirect_to '/users/forgot', :notice => 'You have already made a password reset request. Check your email, or contact an administrator for assistance.'
      end
    else
      redirect_to '/users/forgot', :notice => 'An account with that email address could not be found.'
    end
  end

  def reset
    @passreset = PasswordReset.where(:code => params[:code]).first
    
    if (@passreset != nil)
      @user = User.where(:id => @passreset.user_id).first
      
      if (@user != nil)
        random = Digest::SHA1.hexdigest Time.now.to_s
        
        if (@user.update_attribute(:password, random[0..11]))
          Notifier.new_password_email(@user).deliver
          @passreset.delete
          redirect_to '/users/login', :notice => 'Your password has been reset. Check your email for your new password.'
        else
          redirect_to '/users/forgot', :notice => 'Your password could not be reset.\nTry again, or contact an administrator for assistance.'
        end
      else
        redirect_to '/users/forgot', :notice => 'No reset request was made for your account.\nTry again, or contact an administrator for assistance.'
      end
    else
      redirect_to '/users/forgot', :notice => 'No reset request was made for your account.\nTry again, or contact an administrator for assistance.'
    end
  end

  # GET /users/1
  # GET /users/1.xml
  def show
    @user = User.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @user }
    end
  end

  # GET /users/new
  # GET /users/new.xml
  def new
    @user = User.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @user }
    end
  end

  # GET /users/1/edit
  def edit
    @user = User.find(params[:id])
  end

  # POST /users
  # POST /users.xml
  def create
    @user = User.new(params[:user])

    respond_to do |format|
      if @user.save
        format.html { redirect_to(@user, :notice => 'User was successfully created.') }
        format.xml  { render :xml => @user, :status => :created, :location => @user }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @user.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /users/1
  # PUT /users/1.xml
  def update
    @user = User.find(params[:id])

    respond_to do |format|
      if @user.update_attributes(params[:user])
        format.html { redirect_to(@user, :notice => 'User was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @user.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /users/1
  # DELETE /users/1.xml
  def destroy
    @user = User.find(params[:id])
    @user.destroy

    respond_to do |format|
      format.html { redirect_to(users_url) }
      format.xml  { head :ok }
    end
  end
end
