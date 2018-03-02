import bb.cascades 1.3

Sheet 
{
    id: helpSheet
    
	Page
	{
	    
	    titleBar: 
	        TitleBar
	        {
	        	appearance: TitleBarAppearance.Plain
	        	title: "Help"
	        	acceptAction: 
	        	    ActionItem 
	        	    {
	             		title: "Close"
	           			imageSource: "asset:///images/close.png"
	                	onTriggered: 
	                	    {
	                	    	helpSheet.close();
	                	    	helpSheet.destroy();
	                 	    }
	                }
	        }
	    
		Container
		{
			ScrollView 
			{
				preferredWidth: config.screenWidth
				preferredHeight: config.screenHeight
				scrollViewProperties.pinchToZoomEnabled: true
	            scrollViewProperties.scrollMode: ScrollMode.Both
	            
				Container
				{    
					WebView 
					{
					    id: webview
					    
					    translationX: 1.5 * util.screenWidth
					    
					    animations: 
					        [
					            TranslateTransition 
					            {
                     				id: webviewAnimation
                     				toX: 0
                     				duration: 700
                     				easingCurve: StockCurve.Linear
                     			}
					        ]
	                }
				}
			}
	    }
		
		actions: 
		    [
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
	          	},
		        InvokeActionItem 
		        {
		            id: bbmChannelAction
		      		title: "BBM Channel"
		      		ActionBar.placement: ActionBarPlacement.Signature
		      		imageSource: "asset:///images/channel.png"
		            query
		            {
		                invokeTargetId: "sys.bbm.channels.card.previewer"
		                invokeActionId: "bb.action.OPENBBMCHANNEL"
		                uri: "bbmc:C0033F51C"
		        	}
		      	},
                InvokeActionItem 
                {
                    id: reviewAction
                    title: "Review App"
                    ActionBar.placement: ActionBarPlacement.OnBar
                    imageSource: "asset:///images/review.png"
                    query
                    {
                        invokeTargetId: "sys.appworld"
                        invokeActionId: "bb.action.OPEN"
                        uri: "appworld://content/59943975"
                    }
                }
		    ]
	   			
		onCreationCompleted: 
		    {
	     		webview.url = "local:///assets/help/index.html";
	     		webviewAnimation.play();
	     	}
	}

}