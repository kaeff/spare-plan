#module Sprockets
  #module Helpers
    #include ::CodegenHelper
  #end
#end
module CodegenHelper
  def raw_routes
    # See https://github.com/rails/rails/blob/3-2-stable/railties/lib/rails/tasks/routes.rake
    # Attention: RouteInspector has benn moved to action_pack in Rails 4
    # https://github.com/rails/rails/commit/ef91cddb48d1fa8d1a34e8e5ac68fe9eb56c160f

    Rails.application.routes.routes
  end

  def inspected_routes
    require 'rails/application/route_inspector'
    inspector = Rails::Application::RouteInspector.new

    inspected_routes = inspector.collect_routes(raw_routes).map do |route|
      route.merge! Hash[[:controller, :action].zip(route.delete(:reqs).try(:split,'#'))]
      route[:path].gsub! /\([^)]*\)/, ""
      route
    end
  end

  def routeprovider_routes
    inspected_routes.select { |r| r[:verb] == "GET" || r[:name] == "root" }
  end
end
