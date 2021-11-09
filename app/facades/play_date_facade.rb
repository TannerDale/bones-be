class PlayDateFacade
  class << self
    def user_play_dates(params)
      if params[:status] == 'invited'
        PlayDate.users_invited(params[:user_id])
      else
        PlayDate.for_user(params[:user_id])
      end
    end
  end
end
