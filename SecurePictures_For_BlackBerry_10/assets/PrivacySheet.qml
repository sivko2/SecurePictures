import bb.cascades 1.3

Sheet 
{
    id: privacySheet
    
	Page
	{
	    titleBar: 
	        TitleBar
	        {
	            id: titleBar
	        	appearance: TitleBarAppearance.Plain
	        	title: "Privacy Policy"
	        	acceptAction: 
	        	    ActionItem 
	        	    {
	             		title: "Close"
	           			imageSource: "asset:///images/close.png"
	                	onTriggered: 
	                	    {
	                	    	privacySheet.close();
	                	    	privacySheet.destroy();
	                 	    }
	                }
	        }
	    
		Container
		{
			ScrollView 
			{
				preferredWidth: config.screenWidth
				preferredHeight: config.screenHeight
				scrollViewProperties.pinchToZoomEnabled: false
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
		        ActionItem 
		        {
		            id: permAction
		      		title: "Permissions"
		      		ActionBar.placement: ActionBarPlacement.Signature
		      		imageSource: "asset:///images/permissions.png"
		      		onTriggered: 
		      		    {
              				invokator.invokePermissions();
              			}
		      	}
		    ]
		
		onCreationCompleted: 
		    {
	     		webview.url = "local:///assets/help/policy.html";
	     		webviewAnimation.play();
	     	}
	}

}