module home.homepage;

import vibe.vibe;
import database.database;

@path("/")
class Home
{
	DatabaseConnection database;

	this()
	{
		if (!this.database) {
			this.database = new DatabaseConnection();
		}
	}

	@method(HTTPMethod.GET)
	@path("/")
	void homepage(int page = 1)
	{
		auto posts = this.database.getPosts(page);
		auto postCount = this.database.getPostCount();

		render!("home/homepage.dt", posts, postCount, page);
	}
}
