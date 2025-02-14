module ApplicationHelper
  def user_from_version(version)
    begin
      User.find_by(id: version.whodunnit)
    rescue ActiveRecord::RecordNotFound
      nil
    end
  end

  def user_email_from_version(version)
    user = user_from_version(version)
    user&.email || "Unknown User"
  end
end
