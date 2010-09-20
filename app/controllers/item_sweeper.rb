class ItemSweeper < ActionController::Caching::Sweeper
  observe Item # This sweeper is going to keep an eye on the Item model

  # If our sweeper detects that a Item was created call this
  def after_create(item)
    expire_cache_for(item)
  end

  # If our sweeper detects that a Item was updated call this
  def after_update(item)
    expire_cache_for(item)
  end

  # If our sweeper detects that a Item was deleted call this
  def after_destroy(item)
    expire_cache_for(item)
  end

  private
  def expire_cache_for(item)
    # Expire the index page now that we added a new item
    expire_page(:controller => 'items', :action => 'home')
  end
end
