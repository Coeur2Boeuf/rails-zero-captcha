# Override the form_tag helper to add zero captcha spam protection to forms.
module ActionView
  module Helpers
    module FormTagHelper
      def form_tag_html_with_zero_captcha(options)
        zero_captcha = options.delete(:zero_captcha) || options.delete('zero_captcha')
        html = form_tag_html_without_zero_captcha(options)
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
      
      alias_method :form_tag_html_without_zero_captcha, :form_tag_html
      alias_method :form_tag_html, :form_tag_html_with_zero_captcha

      private

      def zero_captcha_html
        zero_captcha_fields.collect do |name, value|
          content_tag :div do
            hidden_field_tag(name, 'verify') +
            javascript_tag do
              "document.getElementsByName('#{name}')[0].setAttribute('value', '#{value}');".html_safe
            end
          end
        end.join
      end
    end
  end
end
