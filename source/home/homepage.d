module home.homepage;

import vibe.vibe;
import database.category;
import database.comment;
import database.post;
import utils.translation;

@translationContext!TranslationContext
@path("/")
class Home
{
	PostConnection postConnection;

	this()
	{
		if (!this.postConnection) {
			this.postConnection = new PostConnection();
		}
	}

	@method(HTTPMethod.GET)
	@path("/")
	void homepage(int page = 1)
	{
		auto categoryConnection = new CategoryConnection();

		auto posts = postConnection.getPosts(page);
		auto postCount = postConnection.getPostCount();
		auto categories = categoryConnection.getCategories();

		render!("home/homepage.dt", posts, postCount, page, categories);
	}

	@method(HTTPMethod.GET)
	@path("/note/:post")
	void note(HTTPServerRequest req, HTTPServerResponse res)
	{
		auto commentConnection = new CommentConnection();
		auto categoryConnection = new CategoryConnection();

		auto post = postConnection.getPost(to!int(req.params["post"]));
		auto categories = categoryConnection.getCategories();
		auto comments = commentConnection.getCommentsByPost(to!int(req.params["post"]));

		render!("home/note.dt", post, comments, categories);
	}

	@method(HTTPMethod.GET)
	@path("/category/:category")
	void category(HTTPServerRequest req, HTTPServerResponse res, int page = 1)
	{
		auto categoryConnection = new CategoryConnection();

		auto posts = categoryConnection.getPostsByCategory(req.params["category"], page);
		auto postCount = postConnection.getPostCount();
		auto categories = categoryConnection.getCategories();

		render!("home/homepage.dt", posts, postCount, page, categories);
	}
}

