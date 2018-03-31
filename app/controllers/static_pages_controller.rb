class StaticPagesController < ApplicationController
  def home
    def home
      if logged_in?
        @micropost = current_user.microposts.build
        @feed_items = current_user.feed.paginate(page: params[:page])
          .per_page Settings.feed.number_feed
      end
    end
  end

  def help
  end

  def about
  end
end
