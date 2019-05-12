module admin.admin;

import std.stdio : writeln;
import vibe.vibe;
import vibe.web.auth;
import user.authInfo;

import hunt.database;

import database.database;


@requiresAuth
@path("tchoutchou")
class Admin
{
	DatabaseConnection database;

	this()
	{
		if (!this.database) {
			this.database = new DatabaseConnection();
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
	void post()
	{
		auto posts = this.database.getPosts();
		render!("admin/post.dt", posts);
	}

	@auth(Role.admin)
	@method(HTTPMethod.GET)
	@path("post/add")
	void addPost()
	{
		render!"admin/addPost.dt";
	}

	@system
	@auth(Role.admin)
	@method(HTTPMethod.POST)
	@path("post/add")
	void createPost(scope HTTPServerRequest req, scope HTTPServerResponse res)
	{
		this.database.savePost(req.form["title"], req.form["note"]);

		res.redirect("/tchoutchou/post");
	}

	@system
	@auth(Role.admin)
	@method(HTTPMethod.GET)
	@path("post/edit")
	void editPost(int id, scope HTTPServerRequest req, scope HTTPServerResponse res)
	{
		auto post = this.database.getPost(id);
		render!("admin/editPost.dt", post);
	}

	@system
	@auth(Role.admin)
	@method(HTTPMethod.POST)
	@path("post/edit")
	void createditPostePost(int id, scope HTTPServerRequest req, scope HTTPServerResponse res)
	{
		this.database.savePost(id, req.form["title"], req.form["note"]);

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
		auto categories = this.database.getCategories();
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
		this.database.saveCategory(req.form["name"], req.form["slug"]);

		res.redirect("/tchoutchou/category");
	}
}
