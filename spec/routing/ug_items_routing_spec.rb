require 'spec_helper'

describe UgItemsController do
  describe "routing" do
    it "recognizes and generates #index" do
      { :get => "/ug_items" }.should route_to(:controller => "ug_items", :action => "index")
    end

    it "recognizes and generates #new" do
      { :get => "/ug_items/new" }.should route_to(:controller => "ug_items", :action => "new")
    end

    it "recognizes and generates #show" do
      { :get => "/ug_items/1" }.should route_to(:controller => "ug_items", :action => "show", :id => "1")
    end

    it "recognizes and generates #edit" do
      { :get => "/ug_items/1/edit" }.should route_to(:controller => "ug_items", :action => "edit", :id => "1")
    end

    it "recognizes and generates #create" do
      { :post => "/ug_items" }.should route_to(:controller => "ug_items", :action => "create") 
    end

    it "recognizes and generates #update" do
      { :put => "/ug_items/1" }.should route_to(:controller => "ug_items", :action => "update", :id => "1") 
    end

    it "recognizes and generates #destroy" do
      { :delete => "/ug_items/1" }.should route_to(:controller => "ug_items", :action => "destroy", :id => "1") 
    end
  end
end
