require 'spec_helper'

describe EntityTypesController do

  def mock_entity_type(stubs={})
    @mock_entity_type ||= mock_model(EntityType, stubs)
  end

  describe "GET index" do
    it "assigns all entity_types as @entity_types" do
      EntityType.stub(:find).with(:all).and_return([mock_entity_type])
      get :index
      assigns[:entity_types].should == [mock_entity_type]
    end
  end

  describe "GET show" do
    it "assigns the requested entity_type as @entity_type" do
      EntityType.stub(:find).with("37").and_return(mock_entity_type)
      get :show, :id => "37"
      assigns[:entity_type].should equal(mock_entity_type)
    end
  end

  describe "GET new" do
    it "assigns a new entity_type as @entity_type" do
      EntityType.stub(:new).and_return(mock_entity_type)
      get :new
      assigns[:entity_type].should equal(mock_entity_type)
    end
  end

  describe "GET edit" do
    it "assigns the requested entity_type as @entity_type" do
      EntityType.stub(:find).with("37").and_return(mock_entity_type)
      get :edit, :id => "37"
      assigns[:entity_type].should equal(mock_entity_type)
    end
  end

  describe "POST create" do

    describe "with valid params" do
      it "assigns a newly created entity_type as @entity_type" do
        EntityType.stub(:new).with({'these' => 'params'}).and_return(mock_entity_type(:save => true))
        post :create, :entity_type => {:these => 'params'}
        assigns[:entity_type].should equal(mock_entity_type)
      end

      it "redirects to the created entity_type" do
        EntityType.stub(:new).and_return(mock_entity_type(:save => true))
        post :create, :entity_type => {}
        response.should redirect_to(entity_type_url(mock_entity_type))
      end
    end

    describe "with invalid params" do
      it "assigns a newly created but unsaved entity_type as @entity_type" do
        EntityType.stub(:new).with({'these' => 'params'}).and_return(mock_entity_type(:save => false))
        post :create, :entity_type => {:these => 'params'}
        assigns[:entity_type].should equal(mock_entity_type)
      end

      it "re-renders the 'new' template" do
        EntityType.stub(:new).and_return(mock_entity_type(:save => false))
        post :create, :entity_type => {}
        response.should render_template('new')
      end
    end

  end

  describe "PUT update" do

    describe "with valid params" do
      it "updates the requested entity_type" do
        EntityType.should_receive(:find).with("37").and_return(mock_entity_type)
        mock_entity_type.should_receive(:update_attributes).with({'these' => 'params'})
        put :update, :id => "37", :entity_type => {:these => 'params'}
      end

      it "assigns the requested entity_type as @entity_type" do
        EntityType.stub(:find).and_return(mock_entity_type(:update_attributes => true))
        put :update, :id => "1"
        assigns[:entity_type].should equal(mock_entity_type)
      end

      it "redirects to the entity_type" do
        EntityType.stub(:find).and_return(mock_entity_type(:update_attributes => true))
        put :update, :id => "1"
        response.should redirect_to(entity_type_url(mock_entity_type))
      end
    end

    describe "with invalid params" do
      it "updates the requested entity_type" do
        EntityType.should_receive(:find).with("37").and_return(mock_entity_type)
        mock_entity_type.should_receive(:update_attributes).with({'these' => 'params'})
        put :update, :id => "37", :entity_type => {:these => 'params'}
      end

      it "assigns the entity_type as @entity_type" do
        EntityType.stub(:find).and_return(mock_entity_type(:update_attributes => false))
        put :update, :id => "1"
        assigns[:entity_type].should equal(mock_entity_type)
      end

      it "re-renders the 'edit' template" do
        EntityType.stub(:find).and_return(mock_entity_type(:update_attributes => false))
        put :update, :id => "1"
        response.should render_template('edit')
      end
    end

  end

  describe "DELETE destroy" do
    it "destroys the requested entity_type" do
      EntityType.should_receive(:find).with("37").and_return(mock_entity_type)
      mock_entity_type.should_receive(:destroy)
      delete :destroy, :id => "37"
    end

    it "redirects to the entity_types list" do
      EntityType.stub(:find).and_return(mock_entity_type(:destroy => true))
      delete :destroy, :id => "1"
      response.should redirect_to(entity_types_url)
    end
  end

end
