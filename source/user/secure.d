module user.secure;

import vibe.vibe;

@path("secure")
class Secure
{
	@method(HTTPMethod.POST)
    @path("login")
    void login(HTTPServerRequest req, HTTPServerResponse res)
    {
        res.redirect("/");
    }

    /*@path("logout")
    void logout(HTTPServerRequest req, HTTPServerResponse res)
    {
        /*if (res) {
            if (res.session) res.terminateSession();
        }*/
/*
        res.redirect("/");
    }*/
}

