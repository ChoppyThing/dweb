module home.homepage;

import vibe.vibe;

@path("/")
class Home
{
	@method(HTTPMethod.GET)
	@path("/")
	void homepage()
	{
		render!"home/homepage.dt";
	}
}
