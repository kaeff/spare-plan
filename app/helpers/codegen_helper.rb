module CodegenHelper
  def raw_routes
    # See https://github.com/rails/rails/blob/3-2-stable/railties/lib/rails/tasks/routes.rake
    # Attention: RouteInspector has benn moved to action_pack in Rails 4
    # https://github.com/rails/rails/commit/ef91cddb48d1fa8d1a34e8e5ac68fe9eb56c160f

    Rails.application.routes.routes.reject { |r| r.path.spec.to_s =~ %r{/rails/info/properties|^#{Rails.application.config.assets.prefix}} }
  end

  def inspected_routes
    require 'rails/application/route_inspector'
    inspector = Rails::Application::RouteInspector.new

    # Extract controller and action
    inspected_routes = inspector.collect_routes(raw_routes).map do |route|
      route.merge! Hash[[:controller, :action].zip(route.delete(:reqs).try(:split,'#'))]
      route[:path] = ng_path_format(route[:path])
      route
    end
  end

  ##
  # Detects all routes for that need to be declared for $routeProvider
  def routeprovider_routes
    inspected_routes.select { |r| r[:verb] == "GET" || r[:name] == "root" }
  end
 
  ##
  # Detects resources to generate
  # TODO Respect actual actions and verbs
  # @return Hash in the format:
  #{
  #  'Task' => {
  #    path: '/projects/:project_id/tasks/:id',
  #    actions: ['index', 'edit', 'delete']
  #  }
  #}
  def ng_resources
    routes_per_resource.collect do |resource, routes|
      {
        resource => {
          path: ng_path_format(path_for(routes)),
          actions: routes.map { |r| r[:action] }
        }
      }
    end.inject(:merge)
  end

  ##
  # Group routes by resource
  def routes_per_resource
    memo = {}
    raw_routes.each do |route|
      resource = model_class_for(route.defaults[:controller])
      if resource
        memo[resource] = (memo[resource] || []) << {
          path: route.path.spec,
          action: route.defaults[:action],
          verb: route.verb.source.gsub(/[$^]/, '')
        }
      end
    end
    memo
  end

  ##
  # Detects the model class for
  def model_class_for(resource_name)
    return nil unless resource_name

    resource_name.capitalize!
    ctrl = "#{resource_name.pluralize}Controller".safe_constantize
    return nil unless ctrl

    # Try #resource_class on controller
    return ctrl.resource_class.to_s if ctrl.respond_to? :resource_class

    # Check if corresponding model exists
    return resource_name if resource_name.safe_constantize.try {|k| k < ActiveRecord::Base }

    nil
  end

  ##
  # Among all routes for a resource, detects the best path for a
  # ngResource.
  def path_for(routes)
    (routes.find { |r| r[:action] == "show" } || routes.find { |r| r[:action] == "index" }).try { |r| r[:path] } || ''
  end

  ##
  # Converts a rails route path to an angular route path
  def ng_path_format(path)
    path.to_s.gsub(/\([^\)]*\)/, "")
  end
  
  def root_module_name
    Rails.application.class.to_s.deconstantize.downcase
  end
end
