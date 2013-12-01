class AddAttachmentPicToPhotos < ActiveRecord::Migration
  def self.up
    change_table :photos do |t|
      t.attachment :pic
    end
  end

  def self.down
    drop_attached_file :photos, :pic
  end
end
