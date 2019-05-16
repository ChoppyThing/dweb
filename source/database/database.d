module database.database;

import hunt.database;

class DatabaseConnection
{
    string connection;
    int perPage = 5;

    this()
    {
        this.connection = "mysql://root:test@localhost:3306/train?charset=utf8mb4";
    }

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

            string sql = "SELECT * FROM post LIMIT 10";
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

        /**
         *  Category
         */
        auto getCategories()
        {
            auto db = new Database(this.connection);

            string sql = "SELECT * FROM category LIMIT 10";

            return db.query(sql);
        }

        void saveCategory(string name, string slug)
        {
            auto db = new Database(this.connection);

            Statement stmt = db.prepare("INSERT INTO category(name, slug) VALUES(:name, :slug)");
            stmt.setParameter("name", name);
            stmt.setParameter("slug", slug);

            stmt.execute();

            db.close();
        }
}
