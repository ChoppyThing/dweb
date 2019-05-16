module utils.translation;

import std.typetuple;
import vibe.vibe;
import vibe.web.web;

struct TranslationContext {
	alias languages = TypeTuple!("fr_FR", "en_US");
	mixin translationModule!"base";

	static string determineLanguage(scope HTTPServerRequest req)
	{
		import std.stdio : writeln;
		writeln(req.session);

		if (!req.session) return req.determineLanguageByHeader(languages);
		return req.session.get("language", "");
	}
}
