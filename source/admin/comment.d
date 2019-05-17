module admin.comment;

import std.stdio : writeln;
import vibe.vibe;
import vibe.web.auth;
import user.authInfo;

import database.comment;

@requiresAuth
@path("tchoutchou/comment")
class Comment
{
	@safe:
	@noRoute AuthInfo authenticate(scope HTTPServerRequest req, scope HTTPServerResponse res)
	{
		if (!req.session || !req.session.isKeySet("auth")) {
			res.redirect("/secure/login?from=" ~ req.requestURI);
			return AuthInfo.init;
		}
		return req.session.get!AuthInfo("auth");
	}

	@system
	@auth(Role.admin)
	@method(HTTPMethod.GET)
	@path("/")
	void list(int page = 1)
	{
		auto commentConnection = new CommentConnection();

		auto comments = commentConnection.getComments();

		render!("admin/comment/list.dt", comments);
	}
}
