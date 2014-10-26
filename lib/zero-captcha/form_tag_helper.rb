# Override the form_tag helper to add zero captcha spam protection to forms.
module ActionView
  module Helpers
    module FormTagHelper
      def form_tag_with_zero_captcha(url_for_options = {}, options = {}, *parameters_for_url, &block)
        zero_captcha = options.delete(:zero_captcha)
        html = form_tag_without_zero_captcha(url_for_options, options, *parameters_for_url, &block)
        if zero_captcha
          captcha = "".respond_to?(:html_safe) ? zero_captcha_html.html_safe : zero_captcha
          if block_given?
            html.insert(html.index('</form>'), captcha)
          else
            html += captcha
          end
        end
        html
      end
      alias_method_chain :form_tag, :zero_captcha

    private
      def zero_captcha_html
        zero_captcha_fields.collect do |name, value|
          content_tag :div do
            hidden_field_tag(name, 'verify') +
            javascript_tag do
              "jQuery('input[name=#{name}]').val('#{value}')".html_safe
            end
          end
        end.join
      end
    end
  end
end