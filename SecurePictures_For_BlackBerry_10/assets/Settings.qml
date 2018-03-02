import bb.cascades 1.3
import bb.system 1.2
import bb.core 1.3

Sheet 
{
    id: settingsSheet
	
	property int pos: 0
    
	Page
	{	        
		id: settingsPage
			
		attachedObjects: 
		    [
	            ComponentDefinition 
	            {
	                id: passwordChangeDef
	            	source: "PasswordChangeSheet.qml"
	            }
		    ]
	
	    titleBar: 
            TitleBar
            {
                appearance: TitleBarAppearance.Plain
                title: "Settings"
                acceptAction: 
                    ActionItem 
                    {
                        title: "Close"
                        imageSource: "asset:///images/close.png"
                        onTriggered: 
                        {
                            settingsSheet.close();
                            settingsSheet.destroy();
                        }
                    }
            }
		        
			Container
			{
	            topPadding: 20.0
	            leftPadding: 20.0
	            rightPadding: 20.0
	            bottomPadding: 20.0
	            
			 	ScrollView 
				{
					Container
					{		
                        Container 
                        {
                            horizontalAlignment: HorizontalAlignment.Fill
                            
                            layout: 
                                StackLayout 
                                {
                                    orientation: LayoutOrientation.RightToLeft
                                }
                                
                            ToggleButton 
                            {
                                id: multiShotsButton
                                checked: config.multiShots
                                leftMargin: 20
                                
                                onCheckedChanged: 
                                    {
                                        config.multiShots = checked;
                                    }
                            }
                            
                            Label 
                            {
                                 text: "Multiple camera shots"
                                 verticalAlignment: VerticalAlignment.Center
                            }
                        }
                        
                        Label 
                        {
                            text: "By enabling multi camera shots option, everytime a picture is taken, the application returns back to camera for new camera shots (NOTE: Only supporting pictures)."
                            textStyle
                            {
                                base: SystemDefaults.TextStyles.SmallText
                                fontWeight: FontWeight.Normal
                                color: Color.create("#a3a3a3")
                            }
                            
                            textFormat: TextFormat.Html
                            horizontalAlignment: HorizontalAlignment.Fill
                            multiline: true
                        }
                        
                        Divider
                        {
                        }
                        
                        Label 
                        {
                            text: "Forget secure password when:"
                        }
                        
                        Container 
                        {
                            horizontalAlignment: HorizontalAlignment.Fill
                            
                            layout: 
                            StackLayout 
                            {
                                orientation: LayoutOrientation.RightToLeft
                            }
                            
                            ToggleButton 
                            {
                                id: forgetWhenMinButton
                                checked: config.forgetWhenMin
                                leftMargin: 20
                                
                                onCheckedChanged: 
                                {
                                    config.forgetWhenMin = checked;
                                }
                            }
                            
                            Label 
                            {
                                text: "Application is minimized"
                                verticalAlignment: VerticalAlignment.Center
                            }
                        }
                        
                        Label 
                        {
                            text: "By enabling this option, the secure password is forgotten everytime the application is minimized."
                            textStyle
                            {
                                base: SystemDefaults.TextStyles.SmallText
                                fontWeight: FontWeight.Normal
                                color: Color.create("#a3a3a3")
                            }
                            
                            textFormat: TextFormat.Html
                            horizontalAlignment: HorizontalAlignment.Fill
                            multiline: true
                        }
                        
                        Container 
                        {
                            horizontalAlignment: HorizontalAlignment.Fill
                            
                            layout: 
                            StackLayout 
                            {
                                orientation: LayoutOrientation.RightToLeft
                            }
                            
                            ToggleButton 
                            {
                                id: forgetWhenExitButton
                                checked: config.forgetWhenExit
                                leftMargin: 20
                                
                                onCheckedChanged: 
                                {
                                    config.forgetWhenExit = checked;
                                    if (checked)
                                    {
                                        console.debug("###### FORGET - PASSWORD UNSET");
                                        navi.password = "";
                                    }
                                    console.debug("###### CHECKED: " + config.forgetWhenExit);
                                }
                            }
                            
                            Label 
                            {
                                text: "Exiting viewer or player"
                                verticalAlignment: VerticalAlignment.Center
                            }
                        }
                        
                        Label 
                        {
                            text: "By enabling this option, the secure password is forgotten everytime the picture viewer or the movie player is left."
                            textStyle
                            {
                                base: SystemDefaults.TextStyles.SmallText
                                fontWeight: FontWeight.Normal
                                color: Color.create("#a3a3a3")
                            }
                            
                            textFormat: TextFormat.Html
                            horizontalAlignment: HorizontalAlignment.Fill
                            multiline: true
                        }
                        
                        Divider 
                        {
                        }
                        
			            Label 
			            {
			        		topMargin: 15
			                multiline: true
			                textFormat: TextFormat.Html
                            text: "Tap on <span style='color: #C32C2B;font-weight: bold;'>Change Password</span> button to change the application secure password."
							textStyle
							{
								color: Color.Black
							}
			            }
			            
			            Button 
			            {
			                id: pwdButton
			        		topMargin: 30
			          		text: "Change Password"
			          		horizontalAlignment: HorizontalAlignment.Center
			          		
			          		onClicked: 
			          		    {
	                                var passwordChangeSheet = passwordChangeDef.createObject();
			                		passwordChangeSheet.open();
			                	}
			            }
			        }            
			    }
			}
	}		
}