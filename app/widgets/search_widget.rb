class SearchWidget < Apotomo::Widget
  helper Ransack::Helpers::FormHelper

  def display
    @q = Item.search(params[:q])
    render
  end

end
