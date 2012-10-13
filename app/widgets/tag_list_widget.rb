class TagListWidget < Apotomo::Widget

  def display(entity)
    @tags = Item.tag_counts_on(entity.to_sym)
    render
  end

end
