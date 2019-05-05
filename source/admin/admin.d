module admin.admin;

import vibe.vibe;

@path("tchoutchou")
class Admin
{
	@method(HTTPMethod.GET)
	@path("post")
	void post()
	{
		render!"admin/post.dt";
	}

	@method(HTTPMethod.GET)
	@path("dashboard")
	void dashboard()
	{
		render!"admin/dashboard.dt";
	}
}
