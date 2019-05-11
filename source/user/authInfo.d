module user.authInfo;

import vibe.http.router : URLRouter;
import vibe.web.web : noRoute;
import std.stdio : writeln;

static struct AuthInfo {
@safe:
	string username;

	bool isAdmin()
    {
        writeln(this);
        return this.username == "choppy";
    }
	
	bool isUser()
    {
        return this.username == "peter";
    }
}

