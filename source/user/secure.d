module user.secure;

import vibe.vibe;
import std.stdio : writeln;

@path("secure")
class Secure
{
	@method(HTTPMethod.GET)
    @path("login")
    void login(HTTPServerRequest req, HTTPServerResponse res)
    {
writeln(res);
        render!"user/login.dt";
    }

	@method(HTTPMethod.POST)
    @path("login_check")
    void loginCheck(HTTPServerRequest req, HTTPServerResponse res)
    {
        enforceHTTP("username" in req.form && "password" in req.form,
            HTTPStatus.badRequest, "Missing username/password field.");

        // todo: verify user/password here
        if (req.form["username"] == "choppy" && req.form["password"] == "test") {
            writeln("right");
        } else {
            res.redirect("/secure/login");
        }
writeln(req.form);
        auto session = res.startSession();
        session.set("username", req.form["username"]);
        session.set("password", req.form["password"]);
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

