Hanami::Model.migration do
  change do
    drop_table?   :avatars
    create_table? :avatars do
      primary_key :id
      foreign_key :user_id, :users, on_delete: :cascade, null: false

      column :url, String
    end

    alter_table :users do
      add_foreign_key :avatar_id, :avatars, on_delete: :cascade
    end
  end
end
