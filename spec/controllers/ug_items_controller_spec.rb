require 'spec_helper'

describe UgItemsController do

  before(:each) do
    session[:logged_in] = true
  end

  def mock_ug_item(stubs={})
    @mock_ug_item ||= mock_model(UgItem, stubs)
  end

  describe "GET index" do
    it "assigns all ug_items as @ug_items" do
      ApplicationController.stub!(:require_login).and_return(false)
      UgItem.stub(:find).with(:all).and_return([mock_ug_item])
      get :index
      assigns[:ug_items].should == [mock_ug_item]
    end
  end

  describe "GET show" do
    it "assigns the requested ug_item as @ug_item" do
      ApplicationController.stub!(:require_login).and_return(false)
      UgItem.stub(:find).with("37").and_return(mock_ug_item)
      get :show, :id => "37"
      assigns[:ug_item].should equal(mock_ug_item)
    end
  end

  describe "GET new" do
    it "assigns a new ug_item as @ug_item" do
      ApplicationController.stub!(:require_login).and_return(false)
      UgItem.stub(:new).and_return(mock_ug_item)
      get :new
      assigns[:ug_item].should equal(mock_ug_item)
    end
  end

  describe "GET edit" do
    it "assigns the requested ug_item as @ug_item" do
      ApplicationController.stub!(:require_login).and_return(false)
      UgItem.stub(:find).with("37").and_return(mock_ug_item)
      get :edit, :id => "37"
      assigns[:ug_item].should equal(mock_ug_item)
    end
  end

  describe "POST create" do

    describe "with valid params" do
      it "assigns a newly created ug_item as @ug_item" do
        ApplicationController.stub!(:require_login).and_return(false)
        UgItem.stub(:new).with({'these' => 'params'}).and_return(mock_ug_item(:save => true))
        post :create, :ug_item => {:these => 'params'}
        assigns[:ug_item].should equal(mock_ug_item)
      end

      it "redirects to the created ug_item" do
        ApplicationController.stub!(:require_login).and_return(false)
        UgItem.stub(:new).and_return(mock_ug_item(:save => true))
        post :create, :ug_item => {}
        response.should redirect_to(ug_item_url(mock_ug_item))
      end
    end

    describe "with invalid params" do
      it "assigns a newly created but unsaved ug_item as @ug_item" do
        ApplicationController.stub!(:require_login).and_return(false)
        UgItem.stub(:new).with({'these' => 'params'}).and_return(mock_ug_item(:save => false))
        post :create, :ug_item => {:these => 'params'}
        assigns[:ug_item].should equal(mock_ug_item)
      end

      it "re-renders the 'new' template" do
        ApplicationController.stub!(:require_login).and_return(false)
        UgItem.stub(:new).and_return(mock_ug_item(:save => false))
        post :create, :ug_item => {}
        response.should render_template('new')
      end
    end

  end

  describe "PUT update" do

    describe "with valid params" do
      it "updates the requested ug_item" do
        ApplicationController.stub!(:require_login).and_return(false)
        UgItem.should_receive(:find).with("37").and_return(mock_ug_item)
        mock_ug_item.should_receive(:update_attributes).with({'these' => 'params'})
        put :update, :id => "37", :ug_item => {:these => 'params'}
      end

      it "assigns the requested ug_item as @ug_item" do
        ApplicationController.stub!(:require_login).and_return(false)
        UgItem.stub(:find).and_return(mock_ug_item(:update_attributes => true))
        put :update, :id => "1"
        assigns[:ug_item].should equal(mock_ug_item)
      end

      it "redirects to the ug_item" do
        ApplicationController.stub!(:require_login).and_return(false)
        UgItem.stub(:find).and_return(mock_ug_item(:update_attributes => true))
        put :update, :id => "1"
        response.should redirect_to(ug_item_url(mock_ug_item))
      end
    end

    describe "with invalid params" do
      it "updates the requested ug_item" do
        ApplicationController.stub!(:require_login).and_return(false)
        UgItem.should_receive(:find).with("37").and_return(mock_ug_item)
        mock_ug_item.should_receive(:update_attributes).with({'these' => 'params'})
        put :update, :id => "37", :ug_item => {:these => 'params'}
      end

      it "assigns the ug_item as @ug_item" do
        ApplicationController.stub!(:require_login).and_return(false)
        UgItem.stub(:find).and_return(mock_ug_item(:update_attributes => false))
        put :update, :id => "1"
        assigns[:ug_item].should equal(mock_ug_item)
      end

      it "re-renders the 'edit' template" do
        ApplicationController.stub!(:require_login).and_return(false)
        UgItem.stub(:find).and_return(mock_ug_item(:update_attributes => false))
        put :update, :id => "1"
        response.should render_template('edit')
      end
    end

  end

  describe "DELETE destroy" do
    it "destroys the requested ug_item" do
      ApplicationController.stub!(:require_login).and_return(false)
      UgItem.should_receive(:find).with("37").and_return(mock_ug_item)
      mock_ug_item.should_receive(:destroy)
      delete :destroy, :id => "37"
    end

    it "redirects to the ug_items list" do
      ApplicationController.stub!(:require_login).and_return(false)
      UgItem.stub(:find).and_return(mock_ug_item(:destroy => true))
      delete :destroy, :id => "1"
      response.should redirect_to(ug_items_url)
    end
  end

end
