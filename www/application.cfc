component {

	// application variables
	this.name = "Blossoms Planner";
	this.applicationtimeout = createTimeSpan(0,2,0,0);
	this.sessionmanagement = true;
	this.sessiontimeout = createTimeSpan(0,1,0,0);
	this.clientstorage = "cookie";
	this.clientmanagement = true;
	this.datasource = "blossomsplanner";
	this.googleMapKey = "GOOGLE_MAPS_API_KEY";
	this.loginstorage = "session";
	this.serverSideFormValidation = "yes";
	this.setclientcookies = "yes";
	this.setdomaincookies = "yes";
	this.scriptprotect = "all";
	this.welcomefilelist = "";
	this.smtpserversettings = {server="",username="",password=""};
	this.timeout = "60";
	this.debuggingipaddress = "127.0.0.1";
	this.enablerobustexception  = "yes";
	this.securejson = true;
	this.securejsonprefix = "//";

	this.mappings["/mapping_name"] = getDirectoryFromPath(getCurrentTemplatePath());
	this.customtagpaths = "tags";

	// orm settings
	this.ormEnabled = true;
	this.ormsettings = {
		autoGenMap=true,
		cacheConfig="Ehcache",
		cfclocation="model",
		datasource="blossomsplanner",
		dbcreate="update",
		eventhandling = true,
		eventhandler = "model.EventHandler",
		flushAtRequestEnd=true,
		logsql=false,
		secondaryCacheEnabled=false,
		useDbForMapping=true
	};

	/**
	 * @hint The application first starts: the first request for a page is processed or the first CFC method is invoked by an event gateway instance, or a web services or Flash Remoting CFC.
	 */
	public boolean function onApplicationStart(){
		ormReload();
		return true;
	}

	/**
	 * @hint The application ends: the application times out, or the server is stopped
	 */
	public void function onApplicationEnd(ApplicationScope){

	}

	/**
	 * @hint The onRequestStart method finishes. (This method can filter request contents.)
	 */
	public void function onRequest(String targetPage){
		include arguments.targetPage;
	}

	/**
	 * @hint A request starts
	 */
	public boolean function onRequestStart(String targetPage){
		if( structKeyExists(url,"reinit") )
			onApplicationStart();
		return true;
	}

	/**
	 * @hint All pages in the request have been processed:
	 */
	public void function onRequestEnd(String targetPage){

	}

	/**
	 * @hint A session starts
	 */
	public void function onSessionStart(){
		session.user={};
	}

	/**
	 * @hint A session ends
	 */
	public void function onSessionEnd(SessionScope,ApplicationScope){

	}

	/**
	 * @hint ColdFusion received a request for a non-existent page.
	 */
	public boolean function onMissingTemplate(String targetPage) {

		return true;
	}

	/**
	 * @hint An exception that is not caught by a try/catch block occurs.
	 */
	public void function onError(Exception,EventName) {
		WriteDump(arguments);
	}

	/**
	 * @hint Handles missing method exceptions
	 */
	public void function onMissingMethod(String method,Struct args) {

	}

	/**
	 * @hint HTTP or AMF calls are made to an application.
	 */
	public void function onCFCRequest(String cfcname,String method,Struct args){

	}
}
