import std.stdio : writeln;
import vibe.vibe;
import home.homepage;
import admin.admin;
import user.authInfo;
import user.secure;
import utils.localization;

void main()
{
	auto router = new URLRouter;

	router.registerWebInterface(new Home);
	router.registerWebInterface(new Admin);
	router.registerWebInterface(new Secure);
	router.registerWebInterface(new Localization);
	router.get("*", serveStaticFiles("public/"));

	auto settings = new HTTPServerSettings;
	settings.port = 8080;
	settings.bindAddresses = ["::1", "127.0.0.1"];
	settings.sessionStore = new MemorySessionStore;
	listenHTTP(settings, router);

// writeln(settings, router.getAllRoutes());
foreach (route; router.getAllRoutes()) {
	writeln(route);
}

	logInfo("Please open http://127.0.0.1:8080/ in your browser.");
	runApplication();
}
