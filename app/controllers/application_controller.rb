class ApplicationController < ActionController::Base
  protect_from_forgery

  before_filter :init_spa

  def angular
  end

  private

  # AngularJS automatically sends CSRF token as a header called X-XSRF
  # this makes sure rails gets it
  def verified_request?
    !protect_against_forgery? || request.get? ||
      form_authenticity_token == params[request_forgery_protection_token] ||
      form_authenticity_token == request.headers['X-XSRF-Token']
  end

  # Intercept all HTML requests to render the angular view
  # TODO Include target controller's resource to save additional request
  # TODO For server-side rendering, respond with ready-to initialize rendered interpretation
  def init_spa
    if request.format == "text/html"
      render action: "angular"
    end
  end
 end
