import bb.cascades 1.3
import bb.core 1.3

Sheet 
{
    id: aboutSheet
    
	Page
	{	        
	    attachedObjects: 
	        [
	            Invocation 
	            {
	                id: inviteWeb
	                query
	                {
	                    mimeType: "text/html"
	                    uri: "http://pronic.si"
		                invokeActionId: "bb.action.OPEN"                
	                }
	            },
	            Invocation 
	            {
	                id: inviteToDownload
	                query
	                {
	                    mimeType: "text/plain"
	                    data: "Protect your pictures, sounds and videos with Secure Pictures! You can download it at " +
                        "http://appworld.blackberry.com/webstore/content/59943975"                   
	                }
	            }
	        ]
	
	    titleBar: 
	        TitleBar 
	        {
	     		title: "About"
	     		appearance: TitleBarAppearance.Plain
	     		
	      		acceptAction: 
	     		    ActionItem 
	     		    {
	           			title: "Close"
	           			imageSource: "asset:///images/close.png"
	           			onTriggered: 
	           			    {
	                  			aboutSheet.close();
	                	    	aboutSheet.destroy();
	                  		}
	           		}
	     	}
		        
		ScrollView 
		{
			Container
			{
                topPadding: 20.0
                leftPadding: 20.0
                rightPadding: 20.0
                bottomPadding: 20.0
	            
	            ImageView
				{
					id: aboutLogo
					imageSource: "asset:///images/camera_shot.png"
					horizontalAlignment: HorizontalAlignment.Center					
				}
					
				Label
				{
					text: "Secure Pictures"
					
					textStyle
					{
						base: SystemDefaults.TextStyles.TitleText
						fontWeight: FontWeight.W900
						color: Color.create("#c32c2b")
					}
					
					horizontalAlignment: HorizontalAlignment.Center
				}
													
				Label
				{
				    id: hwLabel
					text: "v" + util.version;
					textStyle
					{
						base: SystemDefaults.TextStyles.SmallText
						fontWeight: FontWeight.Bold
						color: Color.Black
					}
					
					horizontalAlignment: HorizontalAlignment.Center
				}
				
				Label
				{
				    id: osLabel
					text: "Device: " + util.hardwareInfo + "/" + util.hardwareNumber + "   OS Version: " + util.osVersion;
					textStyle
					{
						base: SystemDefaults.TextStyles.SmallText
						fontWeight: FontWeight.Bold
						color: Color.Black
					}
					
					horizontalAlignment: HorizontalAlignment.Center
				}
				
				Divider 
				{
	    	    }
				
				Label 
				{
				    id: bodyLabel1
				    multiline: true
					text: "Ultimate solution to"
					horizontalAlignment: HorizontalAlignment.Fill
					textFormat: TextFormat.Html
					textStyle
					{
                        base: SystemDefaults.TextStyles.TitleText
						fontWeight: FontWeight.W900
						textAlign: TextAlign.Center
                        color: Color.create("#c32c2b")
					}
				}
				
				Label 
				{
				    id: bodyLabel2
				    multiline: true
					text: "protect your"
					horizontalAlignment: HorizontalAlignment.Fill
					textFormat: TextFormat.Html
					textStyle
					{
                        base: SystemDefaults.TextStyles.TitleText
						fontWeight: FontWeight.W900
						textAlign: TextAlign.Center
                        color: Color.create("#c32c2b")
					}
				}
				
				Label 
				{
				    id: bodyLabel3
				    multiline: true
					text: "pictures, sounds and videos!"
					horizontalAlignment: HorizontalAlignment.Fill
					textFormat: TextFormat.Html
					textStyle
					{
                        base: SystemDefaults.TextStyles.TitleText
						fontWeight: FontWeight.W900
						textAlign: TextAlign.Center
                        color: Color.create("#c32c2b")
					}
				}
				
				Divider 
				{
	    	    }
	
                ImageView
                {
                    imageSource: "asset:///images/logo.png"
                    horizontalAlignment: HorizontalAlignment.Center					
                }
                
				Label
				{
				    id: footerLabel
					text: "© Copyright Pronic, Meselina Ponikvar Verhovsek s.p. 2014. All rights reserved."
						
					textStyle
					{
						base: SystemDefaults.TextStyles.SmallText
						fontWeight: FontWeight.Normal
						color: Color.create("#a3a3a3")
					}
					
					textFormat: TextFormat.Html
					horizontalAlignment: HorizontalAlignment.Center
					multiline: true
				}
				
			}
		}
    
	actions: 
	    [
	        InvokeActionItem 
	        {
	            id: contactUsAction
	      		title: "Contact Us"
	      		ActionBar.placement: ActionBarPlacement.OnBar
	      		imageSource: "asset:///images/contact_us.png"
	            query
	            {
	                invokeTargetId: "sys.pim.uib.email.hybridcomposer"
	                invokeActionId: "bb.action.SENDEMAIL"
                    uri: "mailto:info@pronic.si?subject=Help%20about%20Secure%20Pictures"
	        	}
	      	},
	        InvokeActionItem 
	        {
	            id: reviewAction
	      		title: "Review App"
	      		ActionBar.placement: ActionBarPlacement.Signature
	      		imageSource: "asset:///images/review.png"
	            query
	            {
	                invokeTargetId: "sys.appworld"
	                invokeActionId: "bb.action.OPEN"
                    uri: "appworld://content/59943975"
	        	}
	      	},
            InvokeActionItem 
            {
                id: browseAction
                title: "Visit Web"
                ActionBar.placement: ActionBarPlacement.OnBar
                imageSource: "asset:///images/browse.png"
                query
                {
                    invokeTargetId: "sys.browser"
                    invokeActionId: "bb.action.OPEN"
                    uri: "http://pronic.si"
                }
}
	    ]
	}
	
}