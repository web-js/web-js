convict = require 'convict'

# convict schema
module.exports =
conf = convict
	cwd:
		doc: "The current working directory."
		format: String
		default: process.cwd()

	plugins:
		doc: "Extensions to the WebJS core."
		format: Object
		default: {}

	http:
		port:
			doc: "The port to start the HTTP server on."
			format: "port"
			default: if process.env.NODE_ENV is "development" then 3000 else 80
			env: "PORT"
		ignore:
			doc: "Glob patterns for request path parts that will always return 404."
			format: Array
			default: [ "node_modules", ".*", "package.json" ]
		index:
			doc: "Glob patterns for a filename to look for when the requested path is a directory."
			format: Array
			default: [ "index.js", "index.*" ]
		url_base:
			doc: "Dynamically constructed urls will be prepended with this value."
			format: String
			default: ""
		allow:
			doc: "Glob query to matching valid request paths. Invalid requests are sent 403 Forbidden."
			format: Array
			default: []
		compress:
			doc: "Enable gzip compression."
			format: Boolean
			default: false
		rewrite:
			doc: "Redirect requests by matching file paths."
			format: Array
			default: []
		middleware:
			doc: "List of Connect middleware to use. First checks Express variable, then does regular require. Executes after rewriter/core and before the sanbox/static servers."
			format: Object
			default: {}

	static:
		enabled:
			doc: "Enable or disable the static file server."
			format: Boolean
			default: true
		allow:
			doc: "Glob query matching valid file paths to determine which files should be served statically."
			format: Array
			default: []
		mime_types:
			doc: "Mime types mapped to extensions."
			format: Object
			default: {}
		directory:
			doc: "If the request path is a directory, an html list of files will be shown."
			format: Boolean
			default: true
		headers:
			doc: "Additional headers to add onto static requests."
			format: Object
			default:
				"Cache-Control": "max-age=86400"
		cache:
			doc: "If enabled, sends etag and last modified headers to save on duplicate requests."
			format: Boolean
			default: true

	sandbox:
		enabled:
			doc: "Enable or disable the JavaScript sandbox."
			format: Boolean
			default: true
		allow:
			doc: "Glob query matching valid file paths to determine which files should be sandboxed."
			format: Array
			default: []
		transformers:
			doc: "Modules that transform source code before they are executed."
			format: Object
			default: template: true
		cache:
			doc: "If enabled, sends etag and last modified headers to save on duplicate requests."
			format: Boolean
			default: false