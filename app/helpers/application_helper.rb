module ApplicationHelper
  def gravatar_for(user, add_styles = '')
    email_address = user.email
    hash = Digest::MD5.hexdigest(email_address)
    image_src = "https://www.gravatar.com/avatar/#{hash}"
    image_tag(image_src, alt: user.username, class: "rounded mx-auto d-block shadow #{add_styles}")
  end
end
