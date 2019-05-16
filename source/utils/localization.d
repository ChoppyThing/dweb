module utils.localization;

import vibe.vibe;

@path("/language")
class Localization
{
  @method(HTTPMethod.GET)
	@path(":locale")
	void homepage(scope HTTPServerRequest req, scope HTTPServerResponse res)
	{
    if (!req.session) {
        req.session = res.startSession();
    }

    req.session.set("language", req.params["locale"]);

		res.redirect("/");
	}
}
