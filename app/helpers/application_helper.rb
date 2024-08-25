module ApplicationHelper
  def page_title(title = "")
    base_title = t("defaults.title")
    title.empty? ? base_title : "#{title} | #{base_title}"
  end
end
