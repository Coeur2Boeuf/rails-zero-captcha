require 'zero-captcha/form_tag_helper'

module ZeroCaptcha
  module SpamProtection
    def zero_captcha_fields
      { :_zc_field => '5b5cd0da3121fc53b4bc84d0c8af2e81' } # change this in controller by overriding `zero_captcha_fields`
    end

    def protect_from_spam_with_zero_captcha
      head :ok if zero_captcha_fields.any? { |name, value| params[name] && params[name] != value }
    end

    def require_zero_captcha
      head :ok if zero_captcha_fields.any? { |name, value| !params.has_key?(name) }
    end

    def self.included(base) # :nodoc:
      base.send :helper_method, :zero_captcha_fields

      if base.respond_to? :before_filter
        base.send :prepend_before_filter, :protect_from_spam_with_zero_captcha, :only => [:create, :update]
      end
    end
  end
end

ActionController::Base.send(:include, ZeroCaptcha::SpamProtection) if defined?(ActionController::Base)
