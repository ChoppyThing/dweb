module database.database;

import hunt.database;

class DatabaseConnection
{
    string connection;

    this()
    {
        this.connection = "mysql://root:test@localhost:3306/train?charset=utf8mb4";
    }

    public:
        auto getPosts()
        {
            auto db = new Database(this.connection);

            string sql = "SELECT * FROM post LIMIT 10";

            return db.query(sql);
        }

        auto getPost(int id)
        {
            auto db = new Database(this.connection);

            Statement stmt = db.prepare("SELECT * FROM post WHERE id = :id");
            stmt.setParameter("id", id);

            return stmt.fetch();
        }

        void savePost(string title, string note)
        {
            auto db = new Database(this.connection);

            Statement stmt = db.prepare("INSERT INTO post(title, note) VALUES(:title, :note)");
            stmt.setParameter("title", title);
            stmt.setParameter("note", note);

            stmt.execute();

            db.close();
        }

        void savePost(int id, string title, string note)
        {
            auto db = new Database(this.connection);

            Statement stmt = db.prepare("UPDATE post SET title = :title, note = :note WHERE id = :id");
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
