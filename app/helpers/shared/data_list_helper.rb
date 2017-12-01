module Shared
  module DataListHelper

    def html_list(value, opts=nil)
      case value
      when Hash
        content_tag :ul, class: 'html-list hash' do
          html_list_hash( value, ( opts || {} ) )
        end
      when Array
        content_tag :ul, class: 'html-list' do
          html_list_array( value, ( opts || {} ) )
        end
      else
        if opts == :code
          content_tag :pre do
            "#{value}"
          end
        else
          value.present? ? "#{value}" : "&nbsp;".html_safe
        end
      end
    end

    def html_list_hash(hash, opts={})
      hash.map do |key, value|
        content_tag :li do
          content_tag(:span, "#{key}", class: 'html-list-label') +
          html_list( value, opts.dig(key) )
        end
      end.join.html_safe
    end

    def html_list_array(array, opts={})
      if array.any?
        array.map do |value, i|
          content_tag :li do
            html_list( value, opts )
          end
        end.join.html_safe
      else
        '<li><i>nione</i></li>'.html_safe
      end
    end

  end
end
