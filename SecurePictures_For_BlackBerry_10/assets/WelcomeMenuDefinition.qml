import bb.cascades 1.3

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
            	id: helpSheetDef
            	source: "HelpSheet.qml"
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
            }
        ]
    
}
