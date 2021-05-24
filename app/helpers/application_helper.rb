module ApplicationHelper
  def full_title(page_title)
    BASE_TITLE = "BIGBAG Store"
    if page_title.blank?
      BASE_TITLE
    else
      "#{page_title} - #{BASE_TITLE}"
    end
  end
end
