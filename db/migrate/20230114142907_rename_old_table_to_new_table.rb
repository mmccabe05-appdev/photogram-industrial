class RenameOldTableToNewTable < ActiveRecord::Migration[6.1]
  def change
    rename_table :follow_request, :follow_requests

  end
end
