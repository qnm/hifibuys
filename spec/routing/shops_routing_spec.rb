require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe ShopsController do
  describe "route generation" do
    it "maps #index" do
      route_for(:controller => "shops", :action => "index").should == "/shops"
    end

    it "maps #new" do
      route_for(:controller => "shops", :action => "new").should == "/shops/new"
    end

    it "maps #show" do
      route_for(:controller => "shops", :action => "show", :id => "1").should == "/shops/1"
    end

    it "maps #edit" do
      route_for(:controller => "shops", :action => "edit", :id => "1").should == "/shops/1/edit"
    end

    it "maps #create" do
      route_for(:controller => "shops", :action => "create").should == {:path => "/shops", :method => :post}
    end

    it "maps #update" do
      route_for(:controller => "shops", :action => "update", :id => "1").should == {:path =>"/shops/1", :method => :put}
    end

    it "maps #destroy" do
      route_for(:controller => "shops", :action => "destroy", :id => "1").should == {:path =>"/shops/1", :method => :delete}
    end
  end

  describe "route recognition" do
    it "generates params for #index" do
      params_from(:get, "/shops").should == {:controller => "shops", :action => "index"}
    end

    it "generates params for #new" do
      params_from(:get, "/shops/new").should == {:controller => "shops", :action => "new"}
    end

    it "generates params for #create" do
      params_from(:post, "/shops").should == {:controller => "shops", :action => "create"}
    end

    it "generates params for #show" do
      params_from(:get, "/shops/1").should == {:controller => "shops", :action => "show", :id => "1"}
    end

    it "generates params for #edit" do
      params_from(:get, "/shops/1/edit").should == {:controller => "shops", :action => "edit", :id => "1"}
    end

    it "generates params for #update" do
      params_from(:put, "/shops/1").should == {:controller => "shops", :action => "update", :id => "1"}
    end

    it "generates params for #destroy" do
      params_from(:delete, "/shops/1").should == {:controller => "shops", :action => "destroy", :id => "1"}
    end
  end
end
