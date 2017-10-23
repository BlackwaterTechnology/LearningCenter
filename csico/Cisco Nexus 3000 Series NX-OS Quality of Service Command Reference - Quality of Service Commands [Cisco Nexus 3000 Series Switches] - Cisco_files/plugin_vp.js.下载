/*********************************************************
ADOBE DIGITAL VIRTUAl PROFILE API JAVASCRIPT --------------------------------------
This code must be called by on offer set up in TnT, with the following
defined in it:
<script type="text/javascript">
cdc.util.ensureNamespace("cdc.mbox"); // safe way to make sure cdc.mbox exists
cdc.mbox.adDefaultIntervalUnits = "d"; //d = days, h = hours, m=minutes
cdc.mbox.adDefaultInterval = 24;
if('${profile.cacheinterval}' != ""){ cdc.mbox.adDefaultInterval = parseInt('${profile.cacheinterval}') || 2; }
if('${profile.intervalunit}' != "") { cdc.mbox.adDefaultIntervalUnits = '${profile.intervalunit}'; }
cdc.mbox.adParams = new Array();

cdc.mbox.authState = '${profile.authState}';
cdc.mbox.vp_profileTester = "loadded"//;'${profile.vps.gutcid}';
cdc.mbox.lastVPUpdate = '${profile.lastVPUpdate}';

	jQuery(function(){

	cdc.includer.loadJs('/web/fw/ltc/tools/mbox/plugin_vp.js?2011Jun20',
	{callback: function(){
           cdc.util.checkLogin(function(val){
                   cdc.mbox.adAuthVar = (val == 'valid' ? true : false);
                  }   
           );

	if(typeof(cdc.mbox.ad_ReadVPInfo) != "undefined"){
	cdc.mbox.ad_ReadVPInfo()
	}
      }
   }
   );
 });
</script>
*************************************************************/

//----------------- Mbox functions... -------------
if(typeof(cdc.mbox.vpProfileValues) == "undefined") {
	cdc.mbox.vpProfileValues = ["cps", "vps"];
}

cdc.mbox.adNameValues = [];
cdc.mbox.adCheckTime = function(lastUpdate) {
	if(lastUpdate === "") {
		return true;
	} else {
		var luDate = new Date(lastUpdate);
		if(luDate.toString() == "Invalid Date") {
			return true;
		}
		switch(cdc.mbox.adDefaultIntervalUnits) {
		case("d"):
			luDate.setDate(luDate.getDate() + cdc.mbox.adDefaultInterval);
			break;
		case("h"):
			luDate.setHours(luDate.getHours() + cdc.mbox.adDefaultInterval);
			break;
		case("m"):
			luDate.setMinutes(luDate.getMinutes() + cdc.mbox.adDefaultInterval);
			break;
		default:
			luDate.setDate(luDate.getDate() + cdc.mbox.adDefaultInterval);
			break;
		}
		if(luDate < new Date()) {
			return true;
		}
	}
	return false;
};

cdc.mbox.ad_ReadVPInfo = function() {

	var alreadyLogged = cdc.mbox.authState;
	var tester = cdc.mbox.vp_profileTester;
	var adTimeoutExpired = cdc.mbox.adCheckTime(cdc.mbox.lastVPUpdate);

	/********
	This checks for 3 conditions and if any are met we call the AJAX server again to get fresh data:
	1. A set amout of time has passed
	2. The profile values are blank which means we need to get data
	3. The authenticated state has changed from the last state we recorded
	*********/
	if((adTimeoutExpired) || (tester === "") || (cdc.mbox.adAuthVar && alreadyLogged != "logged") || (!cdc.mbox.adAuthVar && alreadyLogged == "logged")) {
		cdc.mbox.adVPSmartMbox();
		if(typeof(cdc.userInfoDispatcher) != "undefined" && typeof(cdc.userInfoDispatcher.getUserProfile) != "undefined") {
			cdc.sso.addReadyListener(function() {
				cdc.userInfoDispatcher.getUserProfile({
					listOfDataFields: ["cps", // Returns all service fields
					"vps" // Returns all service fields
					],
					"callback": function(userProfile) {
						cdc.mbox.ad_ProcessAPIReturn(userProfile);
					}
				});
			});
		}
	}
};

cdc.mbox.ad_ProcessAPIReturn = function(_j) {

	var ctr = 2;
	var cStr = "";

	cdc.mbox.adParams.splice(0, 0, "profile.lastVPUpdate=" + Date().toString());

	if(cdc.mbox.adAuthVar) {
		cdc.mbox.adParams.splice(0, 0, "profile.authState=logged");
	} else if(!cdc.mbox.adAuthVar) {
		cdc.mbox.adParams.splice(0, 0, "profile.authState=");
	}

	// OLD VP JSON STRUCTURE....
	if(typeof(_j.cacheinterval) != "undefined") {
		cdc.mbox.adParams.splice(0, 0, "profile.cacheinterval=" + _j.cacheinterval);
	}
	if(typeof(_j.intervalunit) != "undefined") {
		cdc.mbox.adParams.splice(0, 0, "profile.intervalunit=" + _j.intervalunit);
	}

	if(typeof(_j.attributes) != "undefined") {
		for(var i = 0; i < _j.attributes.length; i++) {
			cdc.mbox.adParams.splice(0, 0, "profile." + _j.attributes[i].name + "=" + _j.attributes[i].value);
			ctr++;

			//Update every 8 so we don't truncate the call
			if(ctr >= 8) {
				cdc.mbox.adParams.splice(0, 0, "mbox_json_profile_setter");
				if(cdc.mbox.adParams.length > 1) {
					mboxUpdate.apply(this, cdc.mbox.adParams);
				}
				cdc.mbox.adParams = [];
				ctr = 0;
			}
		}
	}

	//NEW VP JSON STRUCTURE...
	cdc.mbox.parseIt(_j, "");

	for(var i = 0; i < cdc.mbox.adNameValues.length; i++) {
		try {
			cdc.mbox.adParams.splice(0, 0, "profile." + cdc.mbox.adNameValues[i]);
			ctr++;
			//Update every 8 so we don't truncate the call
			if(ctr >= 8) {
				cdc.mbox.adParams.splice(0, 0, "mbox_json_profile_setter");
				if(cdc.mbox.adParams.length > 1) {
					mboxUpdate.apply(this, cdc.mbox.adParams);
				}
				cdc.mbox.adParams = [];
				ctr = 0;
			}
		} catch(e) {}
	}
	//Last check...
	if(cdc.mbox.adParams.length > 0) {
		cdc.mbox.adParams.splice(0, 0, "mbox_json_profile_setter");
		mboxUpdate.apply(this, cdc.mbox.adParams);
	}
};

cdc.mbox.parseIt = function(_obj, _id) {
	var old_id;
	var id = _id;
	for(var prop in _obj) {
		if(_obj[prop] == "[object Object]") {
			old_id = id;
			id = id + prop;
			if(id !== "") id = id + ".";
			cdc.mbox.parseIt(_obj[prop], id);
			id = old_id;
		} else {
			if(_obj[prop] != null && _obj[prop] != "null"){
				cdc.mbox.adNameValues.splice(0, 0, id + prop + "=" + _obj[prop]);
			}
		}
	}
};
cdc.mbox.adVPSmartMbox = function() {
	if(typeof(mbox) != "undefined" && !document.getElementById('adJSONDiv')) {
		var d = document.createElement('div');
		d.id = "adJSONDiv";
		document.body.appendChild(d);
		mboxDefine('adJSONDiv', 'mbox_json_profile_setter').setFetcher(new mboxAjaxFetcher());
	}
};
//-------------------------------------------------