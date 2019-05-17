module database.comment;

import database.database;
import hunt.database;

class CommentConnection: DatabaseConnection
{
    int perPage = 20;

	public:
        auto getComments(int page = 1)
        {
            auto db = new Database(this.connection);

            int offset = (page - 1) * this.perPage;

            Statement stmt = db.prepare("
                SELECT * FROM comment AS c
                LIMIT :limit OFFSET :offset
            ");
            stmt.setParameter("limit", this.perPage);
            stmt.setParameter("offset", offset);

            return stmt.query();
        }

        auto getCommentsByPost(int post)
        {
            auto db = new Database(this.connection);

            Statement stmt = db.prepare("
                SELECT * FROM comment AS c
                WHERE post_id = :post_id
            ");
            stmt.setParameter("post_id", post);

            return stmt.query();
        }
}
