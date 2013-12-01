class CreatePhotos < ActiveRecord::Migration
  def change
    create_table :photos do |t|
      t.string :title
      t.string :photographer
      t.float :price

      t.timestamps
    end
  end
end
