module database.post;

import database.database;
import hunt.database;

class PostConnection: DatabaseConnection
{
	public:
        auto getPostCount()
        {
            auto db = new Database(this.connection);
            Statement stmt = db.prepare("SELECT COUNT(*) AS number FROM post");

            return stmt.fetch()["number"];
        }

        auto getPosts(int page = 1)
        {
            auto db = new Database(this.connection);

            int offset = (page - 1) * this.perPage;

            Statement stmt = db.prepare("SELECT * FROM post LIMIT :limit OFFSET :offset");
            stmt.setParameter("limit", this.perPage);
            stmt.setParameter("offset", offset);

            return stmt.query();
        }

        auto getPost(int id)
        {
            auto db = new Database(this.connection);

            Statement stmt = db.prepare("SELECT * FROM post WHERE id = :id");
            stmt.setParameter("id", id);

            return stmt.fetch();
        }

        void savePost(string title, string note, string category)
        {
            auto db = new Database(this.connection);

            Statement stmt = db.prepare("INSERT INTO post(title, note, category_id)
                VALUES(:title, :note, :category_id)");
            stmt.setParameter("title", title);
            stmt.setParameter("note", note);
            stmt.setParameter("category_id", category);

            stmt.execute();

            db.close();
        }

        void savePost(int id, string title, string note, string category)
        {
            auto db = new Database(this.connection);

            Statement stmt = db.prepare("UPDATE post SET title = :title, note = :note, category_id = :category_id
                WHERE id = :id");
            stmt.setParameter("category_id", category);
            stmt.setParameter("title", title);
            stmt.setParameter("note", note);
            stmt.setParameter("id", id);

            stmt.execute();

            db.close();
        }
}