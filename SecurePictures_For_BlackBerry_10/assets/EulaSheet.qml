import bb.cascades 1.3

Sheet 
{
    id: eulaSheet
    
	Page
	{
	    
	    titleBar: 
	        TitleBar
	        {
	        	appearance: TitleBarAppearance.Branded
	        	title: "EULA"
	        	acceptAction: 
	        	    ActionItem 
	        	    {
	             		title: "Close"
	           			imageSource: "asset:///images/close.png"
	                	onTriggered: 
	                	    {
	                	    	eulaSheet.close();
	                	    	eulaSheet.destroy();
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
		
		onCreationCompleted: 
		    {
	     		webview.url = "local:///assets/help/eula.html";
	     		webviewAnimation.play();
	     	}
	}

}