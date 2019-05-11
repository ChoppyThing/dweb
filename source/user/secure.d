module user.secure;

import vibe.vibe;
import std.stdio : writeln;
import user.authInfo;

import hunt.database;
import dauth;

@path("secure")
class Secure
{
	@method(HTTPMethod.GET)
    @path("login")
    void login(HTTPServerRequest req, HTTPServerResponse res)
    {

        render!"user/login.dt";
    }

	@method(HTTPMethod.POST)
    @path("login/check")
    void loginCheck(HTTPServerRequest req, HTTPServerResponse res)
    {
        if (check(req.form["username"], req.form["password"])) {
            writeln("Correct");

            if (!req.session) {
                req.session = res.startSession();
            }

            AuthInfo auth;
            auth.username = req.form["username"];
            req.session.set("auth", auth);

            res.redirect("/tchoutchou/post");
        } else {
            res.redirect("/secure/login");
        }
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

    private:
    bool check(string login, string password)
    {
        auto db = new Database("mysql://root:test@localhost:3306/train?charset=utf8mb4");

        string sql = "SELECT * FROM user WHERE username ='" ~ login ~ "' LIMIT 1";

        char[] input = cast(char[])password;
        Password pass = toPassword(input);
        // writeln(makeHash(pass).toCryptString());

		foreach(row; db.query(sql))
		{
    		db.close();
            return isSameHash(pass, parseHash(row["password"]));
		}

		db.close();
        return false;
    }
}