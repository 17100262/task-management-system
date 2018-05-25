class CreateSkillUsers < ActiveRecord::Migration[5.1]
  def change
    create_table :skill_users do |t|
      t.references :skill, foreign_key: true
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
