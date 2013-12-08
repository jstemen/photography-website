class Photo < ActiveRecord::Base
  has_attached_file :pic, :styles => { :medium => "300x300>", :thumb => "100x100>" }, :default_url => "/images/:style/missing.png"

  def self.search(searchTerm)
    if(searchTerm)
      find(:all, :conditions => ['title LIKE ?', "%#{searchTerm}%"])
    else
      find(:all)
    end
  end
end
