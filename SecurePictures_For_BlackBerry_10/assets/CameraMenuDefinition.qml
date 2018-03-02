import bb.cascades 1.3
import bb.core 1.3

MenuDefinition 
{
    attachedObjects: 
        [
            ComponentDefinition 
            {
                id: aboutSheetDef
            	source: "AboutSheet.qml"
            },
            ComponentDefinition 
            {
            	id: privacySheetDef
            	source: "PrivacySheet.qml"
            },
            ComponentDefinition 
            {
            	id: helpSheetDef
            	source: "HelpSheet.qml"
            },
            ComponentDefinition 
            {
            	id: settingsDef
            	source: "Settings.qml"
            }
        ]
    
    actions: 
        [
            ActionItem 
            {
                title: "About"
                imageSource: "asset:///images/about.png"
             	onTriggered: 
             	    {
                 		var aboutSheetObj = aboutSheetDef.createObject();
                  		aboutSheetObj.open();
//                  		aboutSheetObj.rotateLogo.play();
                    }
            },
            ActionItem 
            {
                title: "Settings"
                imageSource: "asset:///images/settings.png"
                onTriggered: 
                    {
                 		var settingsObj = settingsDef.createObject();
                 		settingsObj.open();
//                 		mainPane.naviPane.push(settingsObj);
                    }	
            },
            ActionItem
            {
            	title: "Help"
            	imageSource: "asset:///images/help.png"
            	onTriggered: 
            	    {
                 		var helpSheetObj = helpSheetDef.createObject();
                  		helpSheetObj.open();
            	    }
            },
            ActionItem
            {
            	title: "Privacy Policy"
            	imageSource: "asset:///images/policy.png"
            	onTriggered: 
            	    {
                 		var privacySheetObj = privacySheetDef.createObject();
                  		privacySheetObj.open();
            	    }
            },
	        ActionItem
	        {
	      		title: "More Apps"
	      		imageSource: "asset:///images/moreapps.png"
	      		
	            onTriggered: 
	                {
                 		invokator.invokeMoreApps(); 
                 	}
	        }
        ]
    
}
