function mboxPolydor(){this.mboxSegment="seg=";
this.prodCats=["Cloud and Systems Management","Cisco IOS and NX-OS Software","Cisco Interfaces and Modules","Collaboration","Network Management and Automation","Optical Networking","Physical Security","Routers","Security","Service Exchange","Storage Networking","Switches","TelePresence","Servers - Unified Computing","Video","Voice and Unified Communications","WebEx","Wireless"];
this.prodSegs=["csm,","iosnx,","modules,","clab,","netman,","optinet,","physec,","routers,","security,","servexch,","snet,","switches,","tp,","suc,","video,","voice,","webex,","wireless,"];
this.mboxAccess=jQuery("meta[name=accessLevel]").attr("content");
if(this.mboxAccess){this.mboxSegment+=this.mboxAccess+","
}this.mboxIaPath=jQuery("meta[name=iaPath]").attr("content");
if(!this.mboxIaPath){this.mboxIaPath=""
}this.mboxCat=this.mboxIaPath.split("#");
var a;
for(a=0;
a<this.prodCats.length;
a++){if(this.mboxCat[3]==this.prodCats[a]){this.mboxSegment+=this.prodSegs[a]
}}this.prodTargetParams=jQuery("meta[name=targetingParameter]").attr("content");
if(!this.prodTargetParams){this.prodTargetParams=""
}if(this.prodTargetParams!=""){}this.mboxURL=jQuery("link[rel=canonical]").attr("href");
if(!this.mboxURL){this.mboxURL=""
}this.mboxDir=this.mboxURL.split("/");
if(this.mboxDir[this.mboxDir.length-2]){this.mboxSegment+=this.mboxDir[this.mboxDir.length-2]+","
}this.mboxSegment+="polydor"
};