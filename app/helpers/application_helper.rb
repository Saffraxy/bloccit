module ApplicationHelper
  ##we define a method named form_group_tag which takes two arguments.
  ### The first argument is an array of errors, and the second is a block.
  def form_group_tag(errors, &block)
    css_class = 'form-group'
    css_class << ' has-error' if errors.any?
  ## the content_tag helper method is called. This method is used to build
  ### the HTML and CSS to display the form element and any associated errors.
    content_tag :div, capture(&block), class: css_class
  end
end
