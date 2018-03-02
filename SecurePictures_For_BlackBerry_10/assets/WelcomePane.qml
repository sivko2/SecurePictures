import bb.cascades 1.3
import bb.system 1.2
import bb.core 1.3

NavigationPane 
{
    id: welcomePane
 
    peekEnabled: false
   
    Menu.definition: 
    	WelcomeMenuDefinition
    	{
    	}
   
    Page 
    {
        id: welcomePage
        objectName: "welcomePage"
        
        attachedObjects: 
        [
            OrientationHandler 
            {
                onOrientationAboutToChange: 
                {
                    if (orientation == UIOrientation.Landscape) 
                    {
                        titleBar.titlePaint = "asset:///images/titlebar_land.png";
                    } 
                    else 
                    {
                        titleBar.titlePaint = "asset:///images/titlebar.png";
                    }
                }
            }
        ]
        
        titleBar: 
            PronicTitleBar 
            {
                id: titleBar
                titleText: "Setup Wizard 1/3"
            }
        
        ScrollView 
        {
            Container 
            {
                topPadding: 20.0
                leftPadding: 20.0
                rightPadding: 20.0
                bottomPadding: 20.0
                
                Label 
                {
                    topMargin: 15
                    multiline: true
                    textFormat: TextFormat.Html
                    text: "Welcome to <span style='color: #C32C2B;font-weight: bold;'>Secure Pictures</span>, an ultimate picture and video protection tool for <span style='color: #C32C2B;font-weight: bold;'>BlackBerry® 10</span> smartphones."
                    textStyle
                    {
                        color: Color.Black
                    }
                }
                
                Label 
                {
                    topMargin: 15
                    multiline: true
                    textFormat: TextFormat.Html
                    text: "In the next steps, this application will provide you a complete setup to start using it."
                    textStyle
                    {
                        color: Color.Black
                    }
                }
                
                Label 
                {
                    topMargin: 15
                    multiline: true
                    textFormat: TextFormat.Html
                    text: "A wizard will guide you through the setup to set a <span style='color: #C32C2B;font-weight: bold;'>password</span> used as a security key for picture and video encryption."
                    textStyle
                    {
                        color: Color.Black
                    }
                }
                
                Label 
                {
                    topMargin: 15
                    multiline: true
                    textFormat: TextFormat.Html
                    text: "Don't forget to <span style='color: #C32C2B;font-weight: bold;'>memorize</span> the password otherwise your camera shots will be lost!"
                    textStyle
                    {
                        color: Color.Black
                    }
                }
                
                Divider 
                {
                }
                
                Label 
                {
                    id: next1Label
                    topMargin: 15
                    multiline: true
                    textFormat: TextFormat.Html
                    visible: false
                    text: "Tap on the <span style='color: #C32C2B;font-weight: bold;'>Next</span> action to accept end-user's license agreement and move to the next step."
                    textStyle
                    {
                        color: Color.Black
                    }
                }
                
                Button 
                {
                    id: eulaButton
                    horizontalAlignment: HorizontalAlignment.Center
                    topMargin: 15
                    visible: false
                    text: "Read License Agreement"
                    onClicked: 
                    {
                        var eulaSheetObj = eulaSheetDef.createObject();
                        eulaSheetObj.open();
                    }
                }
            }
        }
        
        actions: 
            [
                ActionItem 
                {
                	title: "Privacy"
                	imageSource: "asset:///images/policy.png"
                	ActionBar.placement: ActionBarPlacement.OnBar
                    onTriggered: 
                        {
	                 		var privacySheetObj = privacySheetDef.createObject();
	                  		privacySheetObj.open();
                        }
                },
                ActionItem 
                {
                    title: "Next"
                    imageSource: "asset:///images/next.png"
                    ActionBar.placement: ActionBarPlacement.Signature
                    onTriggered: 
                    {
                        welcomePane.push(passwordPage);
                    }
                },
                ActionItem 
                {
                	title: "EULA"
                	imageSource: "asset:///images/licence.png"
                	ActionBar.placement: ActionBarPlacement.OnBar
                    onTriggered: 
                        {
	                 		var eulaSheetObj = eulaSheetDef.createObject();
	                  		eulaSheetObj.open();
                        }
                }
            ]
 
    }
    
    attachedObjects: 
        [
           QTimer
            {
                id: completeTimer
                interval: 50
                singleShot: true
                onTimeout:
                    {
						console.debug("JUST CHECKING 3... E: " + config.e);
                        config.password = pwdField1.text;
                        console.debug("Password stored in settings");
                        app.showMain();
                        console.debug("QML switching");
		                indicator.stop();
		                indicatorContainer.visible = false;
                    }
            },
            QTimer
            {
                id: welcomeTimer
                interval: 400
                singleShot: true;
                onTimeout:
                    {
                        if (welcomePane.top.objectName == "welcomePage")
                        {
                            next1Label.visible = true;
                        }
                        else if (welcomePane.top.objectName == "passwordPage")
                        {
                            next2Label.visible = true;
                        }
                        else if (welcomePane.top.objectName == "endPage")
                        {
                            next4Label.visible = true;
                        }
                    }

            },
            ComponentDefinition 
            {
                id: eulaSheetDef
            	source: "EulaSheet.qml"
            },
            ComponentDefinition 
            {
                id: privacySheetDef
            	source: "PrivacySheet.qml"
            },
            SystemToast 
            {
                id: warningToast
                onFinished: 
                    {
                	}
            },
    	    Page 
        	{
        	    id: passwordPage
        	    objectName: "passwordPage"
        	    
                titleBar: 
                PronicTitleBar 
                {
                    titleText: "Setup Wizard 2/3"
                }
                
                ScrollView 
                {
                	Container 
                	{
    		            topPadding: 20.0
    		            leftPadding: 20.0
    		            rightPadding: 20.0
    		            bottomPadding: 20.0
    		            
    		            Label 
    		            {
                    		topMargin: 15
    		                multiline: true
    		                textFormat: TextFormat.Html
                            text: "Set your application <span style='color: #C32C2B;font-weight: bold;'>password</span> (min. 6 characters) to protect the pictures and videos captured by <span style='color: #C32C2B;font-weight: bold;'>BlackBerry® 10</span> smartphone."
    						textStyle
    						{
    							color: Color.Black
    						}
    		            }
    		            	            
                        Label 
                        {
                            topMargin: 15
                            multiline: true
                            textFormat: TextFormat.Html
                            text: "Your password will be used as an encryption key therefore we advice you to use the password that contains at least 32 characters (256 bits), in combination with upper case letters, lower case letters, numbers and special characters."
                            textStyle
                            {
                                color: Color.Black
                            }
                        }
                        
    		            Label 
    		            {
                    		topMargin: 15
    		                multiline: true
    		                textFormat: TextFormat.Html
    		                text: "Enter new password:"
    						textStyle
    						{
    							color: Color.Black
    						}
    		            }
    		            
    		            TextField 
    		            {
                      		id: pwdField1
                      		inputMode: TextFieldInputMode.Password
                      		input
                      		{
                      		    submitKey: SubmitKey.Next
                     		}
                      		hintText: "Password"
                      	}
    		            
    		            Label 
    		            {
                    		topMargin: 15
    		                multiline: true
    		                textFormat: TextFormat.Html
    		                text: "Re-enter new password:"
    						textStyle
    						{
    							color: Color.Black
    						}
    		            }
    		            
    		            TextField 
    		            {
                      		id: pwdField2
                      		inputMode: TextFieldInputMode.Password
                      		hintText: "Password"
                      		input
                      		{
                      		    submitKey: SubmitKey.Done
                      		    onSubmitted: 
                      		        {
    		                            pwdFunction();
                                	}              		  
                      	    }
                       	}
    		            
    		            Divider 
    		            {
    		            }
                
    		            Label 
    		            {
    		                id: next2Label
                    		topMargin: 15
    		                multiline: true
    		                textFormat: TextFormat.Html
    		                visible: false
                            text: "Tap on the <span style='color: #C32C2B;font-weight: bold;'>Next</span> action to move to the next step."
    						textStyle
    						{
    							color: Color.Black
    						}
    		            }
                    }
                }
            	
		        actions: 
		            [
		                ActionItem 
		                {
		                	title: "Next"
		                	imageSource: "asset:///images/next.png"
		                	ActionBar.placement: ActionBarPlacement.Signature
		                    onTriggered: 
		                        {
		                            pwdFunction();
		                        }
		                    }
		            ]
            },
        	Page 
        	{
        	    id: endPage   
        	    objectName: "endPage"  
        	    
                titleBar: 
                PronicTitleBar 
                {
                    titleText: "Setup Wizard 3/3"
                }
                
        	    onCreationCompleted: 
        	        {
		                console.debug("JUST CHECKING 2... E: " + config.e);
                 	}   	    
        	    
        	    ScrollView 
        	    {
                	Container 
                	{
    		            topPadding: 20.0
    		            leftPadding: 20.0
    		            rightPadding: 20.0
    		            bottomPadding: 20.0
    
    		            property int counter: 0
    		                
    		            ScrollView 
    		            {
    		                Container
                      		{
    				            Container 
    				            {
    				                id: indicatorContainer
    				                topPadding: 40
    				                visible: false
    					            horizontalAlignment: HorizontalAlignment.Fill
    					            ActivityIndicator 
    					            {
    					                id: indicator
    					                preferredWidth: 96
    					                horizontalAlignment: HorizontalAlignment.Center
    					            }
    				            }
    				            
    				            Label 
    				            {
    		                		topMargin: 15
    				                multiline: true
    				                textFormat: TextFormat.Html
    				                text: "Congratulations!"
    								textStyle
    								{
    									color: Color.Black
    								}
    				            }
    				            
                                Label 
                                {
                                    topMargin: 15
                                    multiline: true
                                    textFormat: TextFormat.Html
                                    text: "Your have completed the setup wizard."
                                    textStyle
                                    {
                                        color: Color.Black
                                    }
                                }
                                
                                Label 
                                {
                                    topMargin: 15
                                    multiline: true
                                    textFormat: TextFormat.Html
                                    text: "Don't forget your <span style='color: #C32C2B;font-weight: bold;'>application password</span> used for camera shots protection. Without this password your pictures and videos will be lost."
                                    textStyle
                                    {
                                        color: Color.Black
                                    }
                                }
                                
                                Label 
                                {
                                    topMargin: 15
                                    multiline: true
                                    textFormat: TextFormat.Html
                                    text: "Also don't forget to check the application's <span style='color: #C32C2B;font-weight: bold;'>help</span> for instructions on how to use the <span style='color: #C32C2B;font-weight: bold;'>Secure Pictures</span>."
                                    textStyle
                                    {
                                        color: Color.Black
                                    }
                                }
                                
    				            Divider 
    				            {
    		                	}
    				            
    				            Label 
    				            {
    				                id: next4Label
    		                		topMargin: 15
    				                multiline: true
    				                textFormat: TextFormat.Html
    				                visible: false
                                    text: "Tap on the <span style='color: #C32C2B;font-weight: bold;'>Complete</span> action to start using the application."
    								textStyle
    								{
    									color: Color.Black
    								}
    				            }
    				        }
    		          	}
    		            
                    }
                }
            	
		        actions: 
		            [
		                ActionItem 
		                {
		                	title: "Complete"
		                	imageSource: "asset:///images/next.png"
		                	ActionBar.placement: ActionBarPlacement.Signature
		                    onTriggered: 
		                        {
		                            indicatorContainer.visible = true;
		                            indicator.start();
		                            completeTimer.start();
		                        }
		                    }
		            ]
            }       
        ]
    
    function pwdFunction()
    {
        if (pwdField1.text == "")
        {
            warningToast.body = "Password must not be empty!";
	        warningToast.show();
        }
        if (pwdField1.text.length < 6)
        {
            warningToast.body = "Password must be at least 6 characters long!";
	        warningToast.show();
        }
        else if (pwdField1.text != pwdField2.text)
        {
            warningToast.body = "Both password values must be equal!";
	        warningToast.show();
        }
        else 
        {
    	    welcomePane.push(endPage);
		}
    }
    
    onTopChanged: 
        {
        	console.debug("SWITCH TO PAGE: " + welcomePane.top.objectName);
            if (welcomePane.top.objectName == "welcomePage")
            {
                if (next1Label.visible == false)
                {
                	welcomeTimer.start();
                }
            }
            else if (welcomePane.top.objectName == "passwordPage")
            {
                if (next2Label.visible == false)
                {
                	welcomeTimer.start();
                }
            }
            else if (welcomePane.top.objectName == "endPage")
            {
                if (next4Label.visible == false)
                {
                	welcomeTimer.start();
                }
            }
        }
    
    onCreationCompleted: 
        {
            console.debug("TA TA!!!");
        	welcomeTimer.start();
        }
}
