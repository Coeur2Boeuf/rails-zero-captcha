require 'zero-captcha/form_tag_helper'

module ZeroCaptcha
  module SpamProtection
    # change this in controller by overriding `zero_captcha_fields`
    # to force forms to feed through specific values
    def zero_captcha_fields
      timestamp = Time.current.to_i
      return { 
        :_zc_field => OpenSSL::HMAC.hexdigest('sha256', Rails.application.secret_key_base, "#{timestamp}"),
        :_zc_timestamp => timestamp
      } 
    end

    # change this in controller by overriding `zero_captcha_fields`
    # to force forms to feed through specific values
    def protect_from_spam_with_zero_captcha
      if request.post?
        head :ok if params[:_zc_timestamp].present? && Time.at(params[:_zc_timestamp].to_i) < 20.minutes.ago 
        head :ok if params[:_zc_field].present? && params[:_zc_field] != OpenSSL::HMAC.hexdigest('sha256', Rails.application.secret_key_base, "#{params[:_zc_timestamp]}")
      end
    end

    def require_zero_captcha
      head :ok if zero_captcha_fields.any? { |name, value| !params.has_key?(name) }
    end

    def self.included(base) # :nodoc:
      base.send :helper_method, :zero_captcha_fields
    end
  end
end

ActionController::Base.send(:include, ZeroCaptcha::SpamProtection) if defined?(ActionController::Base)
