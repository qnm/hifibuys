require 'spec_helper'

describe EntitiesController do

  def mock_entity(stubs={})
    @mock_entity ||= mock_model(Entity, stubs)
  end

  describe "GET index" do
    it "assigns all entities as @entities" do
      Entity.stub(:find).with(:all).and_return([mock_entity])
      get :index
      assigns[:entities].should == [mock_entity]
    end
  end

  describe "GET show" do
    it "assigns the requested entity as @entity" do
      Entity.stub(:find).with("37").and_return(mock_entity)
      get :show, :id => "37"
      assigns[:entity].should equal(mock_entity)
    end
  end

  describe "GET new" do
    it "assigns a new entity as @entity" do
      Entity.stub(:new).and_return(mock_entity)
      get :new
      assigns[:entity].should equal(mock_entity)
    end
  end

  describe "GET edit" do
    it "assigns the requested entity as @entity" do
      Entity.stub(:find).with("37").and_return(mock_entity)
      get :edit, :id => "37"
      assigns[:entity].should equal(mock_entity)
    end
  end

  describe "POST create" do

    describe "with valid params" do
      it "assigns a newly created entity as @entity" do
        Entity.stub(:new).with({'these' => 'params'}).and_return(mock_entity(:save => true))
        post :create, :entity => {:these => 'params'}
        assigns[:entity].should equal(mock_entity)
      end

      it "redirects to the created entity" do
        Entity.stub(:new).and_return(mock_entity(:save => true))
        post :create, :entity => {}
        response.should redirect_to(entity_url(mock_entity))
      end
    end

    describe "with invalid params" do
      it "assigns a newly created but unsaved entity as @entity" do
        Entity.stub(:new).with({'these' => 'params'}).and_return(mock_entity(:save => false))
        post :create, :entity => {:these => 'params'}
        assigns[:entity].should equal(mock_entity)
      end

      it "re-renders the 'new' template" do
        Entity.stub(:new).and_return(mock_entity(:save => false))
        post :create, :entity => {}
        response.should render_template('new')
      end
    end

  end

  describe "PUT update" do

    describe "with valid params" do
      it "updates the requested entity" do
        Entity.should_receive(:find).with("37").and_return(mock_entity)
        mock_entity.should_receive(:update_attributes).with({'these' => 'params'})
        put :update, :id => "37", :entity => {:these => 'params'}
      end

      it "assigns the requested entity as @entity" do
        Entity.stub(:find).and_return(mock_entity(:update_attributes => true))
        put :update, :id => "1"
        assigns[:entity].should equal(mock_entity)
      end

      it "redirects to the entity" do
        Entity.stub(:find).and_return(mock_entity(:update_attributes => true))
        put :update, :id => "1"
        response.should redirect_to(entity_url(mock_entity))
      end
    end

    describe "with invalid params" do
      it "updates the requested entity" do
        Entity.should_receive(:find).with("37").and_return(mock_entity)
        mock_entity.should_receive(:update_attributes).with({'these' => 'params'})
        put :update, :id => "37", :entity => {:these => 'params'}
      end

      it "assigns the entity as @entity" do
        Entity.stub(:find).and_return(mock_entity(:update_attributes => false))
        put :update, :id => "1"
        assigns[:entity].should equal(mock_entity)
      end

      it "re-renders the 'edit' template" do
        Entity.stub(:find).and_return(mock_entity(:update_attributes => false))
        put :update, :id => "1"
        response.should render_template('edit')
      end
    end

  end

  describe "DELETE destroy" do
    it "destroys the requested entity" do
      Entity.should_receive(:find).with("37").and_return(mock_entity)
      mock_entity.should_receive(:destroy)
      delete :destroy, :id => "37"
    end

    it "redirects to the entities list" do
      Entity.stub(:find).and_return(mock_entity(:destroy => true))
      delete :destroy, :id => "1"
      response.should redirect_to(entities_url)
    end
  end

end
