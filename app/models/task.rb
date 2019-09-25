class Task < ActiveRecord::Base
  belongs_to :user

  def slug
    name.downcase.gsub(" ", "-")+"{id}"
  end

  def self.find_by_slug(slug)
    Task.all.find do |task|
      task.slug == slug
    end
  end
end
