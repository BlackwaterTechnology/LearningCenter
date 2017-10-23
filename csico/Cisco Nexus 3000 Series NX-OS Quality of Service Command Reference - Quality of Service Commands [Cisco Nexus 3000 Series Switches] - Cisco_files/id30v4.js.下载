cdc.util.ensureNamespace('cdc.cl');                                                                                                                                                                                                 
cdc.cl.id30v4 = {                                                                                                                                                                                                                   
    myObj : "",                                                                                                                                                                                                                     
    makeRequest: function(myObj){                                                                                                                                                                                                   
        var timeout = 5000;                                                                                                                                                                                                         
        this.myObj = myObj;                                                                                                                                                                                                         
        var id = setTimeout( cdc.cl.id30v4.errorHandler, timeout );                                                                                                                                                                 
        jQuery.ajax({                                                                                                                                                                                                               
            type    : 'GET',                                                                                                                                                                                                        
            url     : myObj.id30v4_populardownloadsURL,                                                                                                                                                                             
            dataType: 'jsonp',                                                                                                                                                                                                      
            success : function(data){                                                                                                                                                                                               
                clearTimeout(id);                                                                                                                                                                                                   
                cdc.cl.id30v4.handleResult(data);                                                                                                                                                                                   
            }                                                                                                                                                                                                                       
        });                                                                                                                                                                                                                         
    },                                                                                                                                                                                                                              
    handleResult: function(data){                                                                                                                                                                                                   
        var firstcolumn ="";                                                                                                                                                                                                        
        var secondcolumn="";                                                                                                                                                                                                        
        var generateHTML="";                                                                                                                                                                                                
        var mpd = data.mpd_response; 
        if (jQuery('#shp').attr('class') == 'guest') {
        	var metricsStatus = 'Anonymous';
        } else {
			var metricsStatus = 'LoggedIn';
        }                                                                                                                                                          
                                                                                                                                                                                             
		jQuery('#' + cdc.cl.id30v4.myObj.id30v4_domElement+' .errorTemplate .error').css({'display':'none'});
        if (mpd.error_code == 0){                                                                                                                                                                                                   
            // check for zero results..                                                                                                                                                                                             
            if(mpd.mpdlist.length  ==  0){                                                                                                                                                                                          
                generateHTML += "";// zero results message
                //METRICS zero results state  
                
                trackEvent.event("impression", {
                    "lpos":"shp_tab_downloads",
                    "lid" :"shp_tab_downloads_popular_null",
                    "linktext":"PopularDownloads",
                    "link":"PopularDownloads",     
                     ntpagetag:{
                        "linktext":"PopularDownloads",
                        "link":"PopularDownloads",     
                        "infoSource":"ModuleLoad", 
                        "status" : metricsStatus,     
                        "state": metricsStatus + "Null"    
                     }
                });
            }                                                                                                                                                                                                                       
            // display the results on                                                                                                                                                                                               
            jQuery.each(mpd.mpdlist, function(i){                                                                                                                                                                                   
                if ( i <  cdc.cl.id30v4.myObj.id30v4_noofresults){                                                                                                                                                                  
                    if( i < cdc.cl.id30v4.myObj.id30v4_noofresults/2){                                                                                                                                                              
                        firstcolumn  += '<li><a href="'+mpd.mpdlist[i].URL+'">'+mpd.mpdlist[i].productName+'</a></li>';                                                                                                             
                    }else                                                                                                                                                                                                           
                    {                                                                                                                                                                                                               
                        secondcolumn += '<li><a href="'+mpd.mpdlist[i].URL+'">'+mpd.mpdlist[i].productName+'</a></li>';                                                                                                             
                    }                                                                                                                                                                                                               
                                                                                                                                                                                                                                    
                }                                                                                                                                                                                                                   
            });                                                                                                                                                                                                                     
            generateHTML += ((firstcolumn!="")?'<div class=\'col-2\'><h4 class="sub-head">'+cdc.local.wpx.MRU_MODULE_POPULAR_DOWNLOAD_HEADER+'</h4><ul>'+firstcolumn+'</ul></div>':"")+((secondcolumn!="")?'<div class=\'col-3\'><ul>'+secondcolumn+'</ul></div>':""); 
            //METRICS Anonymous success state 
            trackEvent.event("impression", {
                "lpos":"shp_tab_downloads",
                "lid" :"shp_tab_downloads_popular_success",
                "linktext":"PopularDownloads",
                "link":"PopularDownloads",     
                 ntpagetag:{
                    "linktext":"PopularDownloads",
                    "link":"PopularDownloads",     
                    "infoSource":"ModuleLoad",
                    "status" : metricsStatus,
                    "state": metricsStatus + "Success"    
                 }
            });
                                                                                                                                                                                                                  
        }else                                                                                                                                                                                                                       
        {                                                                                                                                                                                                                           
            generateHTML += "";                                                                                                                                                                                                     
            // error message
            //METRICS Anonymous error state 
            trackEvent.event("impression", {
                "lpos":"shp_tab_downloads",
                "lid" :"shp_tab_downloads_popular_success",
                "linktext":"PopularDownloads",
                "link":"PopularDownloads",     
                 ntpagetag:{
                    "linktext":"PopularDownloads",
                    "link":"PopularDownloads",     
                    "infoSource":"ModuleLoad",
                    "status" : metricsStatus,
                    "state": metricsStatus + "Error"    
                 }
            });
                                                                                                                                                                                                               
        }                                                                                                                                                                                                                           
        // instead of updating id30v4_domElement  can  we update col2 and col3  ?????                                                                                                                                               
        jQuery('#' + cdc.cl.id30v4.myObj.id30v4_domElement ).append(generateHTML); 
            jQuery('.id30v2 .id30v4 .col-2').css('width', '300px');
            jQuery('.id30v2 .id30v4 .col-3').css('margin-top', '39px'); 
            /* to set make all the tab content heights equal */
            jQuery('.c17v2 .infotab').css('height', 'auto');
            cdc.clb.c17v2.setTabHeight();                                                                                                                                                  
    },                                                                                                                                                                                                                              
    errorHandler: function(){                                                                                                                                                                                                       
        //erron handler                                                                                                                                                                                                             
		jQuery('#' + cdc.cl.id30v4.myObj.id30v4_domElement).html("<div><h4 class='sub-head'>Popular Downloads</h4><div class='errorTemplate'><div class='error'>"+cdc.local.wpx.DOWNLD_MODULE_ERROR_MESSAGE+"</div></div></div>");
		jQuery('#' + cdc.cl.id30v4.myObj.id30v4_domElement+' .errorTemplate .error').css({'display':'block'});
		//also replace correct text directly from the RB:cdc.local.wpx.DOWNLD_MODULE_ERROR_MESSAGE	
    }                                                                                                                                                                                                                               
}                                                                                                                                                                                                                                   
jQuery(document).ready(function(){                                                                                                                                                                                                  
    jQuery('.id30v4').each(function(){                                                                                                                                                                                              
        if(document.getElementById(this.id)){                                                                                                                                                                                       
            //var myObj =  document.getElementById(this.id).prefsObj;                                                                                                                                                               
            var myObj = jQuery.parseJSON(jQuery(this).attr('data-config'));                                                                                                                                                                                                 
            cdc.cl.id30v4.makeRequest(myObj);                                                                                                                                                                                       
        }                                                                                                                                                                                                                           
    });                                                                                                                                                                                                                             
});                                                                                                                                                                                                                                 
                                                                                                                                                                                                                                    
                                                                                                                                                                                                                                    