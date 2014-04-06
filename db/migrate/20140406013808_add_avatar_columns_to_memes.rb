class AddAvatarColumnsToMemes < ActiveRecord::Migration
  def self.up
    add_attachment :memes, :avatar
  end

  def self.down
    remove_attachment :memes, :avatar
  end
end
