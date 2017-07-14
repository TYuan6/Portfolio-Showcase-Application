class PagesController < ApplicationController
  #before_filter :authenticate_user! 
  
  helper_method :getUserName
  
  def getUserName(portfolio)
    @currentUser=User.find_by_id(portfolio.user_id)
    return @currentUser.first_name
  end
  
  def home
    if !user_signed_in?
      redirect_to new_user_session_path
    end
  end
  
  def styles
  end
  
  def about
  end
  
  def publicPortfolios
    @publicPortfolios = Array.new
    if !params[:search].blank?    
      portfolios = Portfolio.where(:name => params[:search], :public_view => true)
      if portfolios != nil
       portfolios.each do |haha|
          @publicPortfolios << haha
        end
      end
      user_results = User.where(:email => params[:search])
      user_results.each do |result|
        portfolios = Portfolio.where(:public_view => true, :user_id => result.id)
        if(portfolios != nil)
          portfolios.each do |haha|
            @publicPortfolios << haha
          end
        end
      end
      @publicPortfolios.uniq{|x| x.id}
      return
    end
   
     @publicPortfolios=Portfolio.where('updated_on > :cutoff and public_view =:pView',:cutoff => 1.week.ago,:pView => true)
  end

  
end
