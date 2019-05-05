module admin.admin;

import std.stdio : writeln;
import vibe.vibe;

@path("tchoutchou")
class Admin
{
	@method(HTTPMethod.GET)
	@path("post")
	void post()
	{
        writeln("test post");
		render!"admin/post.dt";
	}

	@method(HTTPMethod.GET)
	@path("dashboard")
	void dashboard()
	{
		render!"admin/dashboard.dt";
	}
}
