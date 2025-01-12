class ReplacePrimaryKeyInUserArticles < ActiveRecord::Migration[6.1]
  def up
    execute "DROP INDEX user_id_and_article_id_idx"
    execute "ALTER TABLE user_articles DROP CONSTRAINT user_articles_pkey"
    execute "ALTER TABLE user_articles ADD PRIMARY KEY (id)"
  end

  def down
    execute "ALTER TABLE user_articles DROP CONSTRAINT user_articles_pkey"
    execute "CREATE INDEX user_articles_pkey ON user_articles (user_id, article_id)"
  end
end
