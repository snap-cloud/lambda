class RenameNoncesTable < ActiveRecord::Migration
  def change
    rename_table :dce_lti_nonces, :nonces
  end
end
