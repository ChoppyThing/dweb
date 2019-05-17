module database.category;

import database.database;
import hunt.database;

class CategoryConnection: DatabaseConnection
{
	public:
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

		auto getCategoryBySlug(string slug)
        {
            auto db = new Database(this.connection);

            Statement stmt = db.prepare("SELECT * FROM category WHERE slug = :slug");
            stmt.setParameter("slug", slug);

            return stmt.fetch();
        }

		auto getPostsByCategory(string category, int page = 1)
        {
            auto db = new Database(this.connection);

            auto categoryEntity = this.getCategoryBySlug(category);

            int offset = (page - 1) * this.perPage;

            Statement stmt = db.prepare("SELECT * FROM post WHERE category_id = :category_id LIMIT :limit OFFSET :offset");
            stmt.setParameter("category_id", categoryEntity["id"]);
            stmt.setParameter("limit", this.perPage);
            stmt.setParameter("offset", offset);

            return stmt.query();
        }
}