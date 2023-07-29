class CreateArticles < ActiveRecord::Migration[7.0]
  def change
    create_table :articles do |t|
      t.belongs_to :user, foreign_key:  true
      t.string :title
      t.text :content

      t.timestamps
    end
  end
end
