class Photo < ActiveRecord::Base
  watermarkPath = Rails.root.to_s + "/public/images/watermark.jpg"
  has_attached_file :pic,
                    :styles => {
                        :medium => {:geomertry =>"300x300>",:watermark_path => watermarkPath, :watermark_transparency => "10%"},
                        :thumb  => {:geomertry =>"100x100>"}
                    },
                    :processors => [:watermark],
                    :default_url => "/images/:style/missing.png"

  def self.search(searchTerm)
    if(searchTerm)
      find(:all, :conditions => ['title LIKE ?', "%#{searchTerm}%"])
    else
      find(:all)
    end
  end
end
