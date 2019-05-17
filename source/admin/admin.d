module admin.admin;

import std.stdio : writeln;
import vibe.vibe;
import vibe.web.auth;
import user.authInfo;

import database.post;
import database.category;

@requiresAuth
@path("tchoutchou")
class Admin
{
	PostConnection postConnection;

	this()
	{
		if (!this.postConnection) {
			this.postConnection = new PostConnection();
		}
	}

	@safe:
	@noRoute AuthInfo authenticate(scope HTTPServerRequest req, scope HTTPServerResponse res)
	{
		if (!req.session || !req.session.isKeySet("auth")) {
			res.redirect("/secure/login?from=" ~ req.requestURI);
			return AuthInfo.init;
		}
		return req.session.get!AuthInfo("auth");
	}

	/**
	 * Post
	 */
	@system
	@auth(Role.admin)
	@method(HTTPMethod.GET)
	@path("post")
	void post(int page = 1)
	{
		auto posts = this.postConnection.getPosts(page);
		auto postCount = this.postConnection.getPostCount();
		render!("admin/post.dt", posts, postCount, page);
	}

	@system
	@auth(Role.admin)
	@method(HTTPMethod.GET)
	@path("post/add")
	void addPost()
	{
		auto categoryConnection = new CategoryConnection();
		auto categories = categoryConnection.getCategories();
		render!("admin/addPost.dt", categories);
	}

	@system
	@auth(Role.admin)
	@method(HTTPMethod.POST)
	@path("post/add")
	void createPost(scope HTTPServerRequest req, scope HTTPServerResponse res)
	{
		this.postConnection.savePost(req.form["title"], req.form["note"], req.form["category"]);

		res.redirect("/tchoutchou/post");
	}

	@system
	@auth(Role.admin)
	@method(HTTPMethod.GET)
	@path("post/edit")
	void editPost(int id, scope HTTPServerRequest req, scope HTTPServerResponse res)
	{
		auto categoryConnection = new CategoryConnection();
		auto categories = categoryConnection.getCategories();
		auto post = this.postConnection.getPost(id);
		render!("admin/editPost.dt", post, categories);
	}

	@system
	@auth(Role.admin)
	@method(HTTPMethod.POST)
	@path("post/edit")
	void createditPostePost(int id, scope HTTPServerRequest req, scope HTTPServerResponse res)
	{
		this.postConnection.savePost(id, req.form["title"], req.form["note"], req.form["category"]);

		res.redirect("/tchoutchou/post");
	}

	/**
	 * Dashboard
	 */
	@auth(Role.admin)
	@method(HTTPMethod.GET)
	@path("dashboard")
	void dashboard()
	{
		render!"admin/dashboard.dt";
	}

	/**
	 *	Category
	 */
	@system
	@auth(Role.admin)
	@method(HTTPMethod.GET)
	@path("category")
	void category()
	{
		auto categoryConnection = new CategoryConnection();
		auto categories = categoryConnection.getCategories();
		render!("admin/category.dt", categories);
	}

	@auth(Role.admin)
	@method(HTTPMethod.GET)
	@path("category/add")
	void addCategory()
	{
		render!"admin/addCategory.dt";
	}

	@system
	@auth(Role.admin)
	@method(HTTPMethod.POST)
	@path("category/add")
	void addCategory(scope HTTPServerRequest req, scope HTTPServerResponse res)
	{
		auto categoryConnection = new CategoryConnection();
		categoryConnection.saveCategory(req.form["name"], req.form["slug"]);

		res.redirect("/tchoutchou/category");
	}
}
