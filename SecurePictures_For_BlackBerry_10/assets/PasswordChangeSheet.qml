import bb.cascades 1.3
import bb.system 1.2

Sheet 
{
    id: passwordChangeSheet
    
    attachedObjects: 
        [
            SystemToast 
            {
                id: warningToast
                onFinished: 
                    {
                	}
            }
        ]
    
	Page
	{	        
	
	    titleBar: 
            TitleBar 
            {
                title: "Change Password"
                
                dismissAction: 
                ActionItem 
                {
                    title: "Cancel"
                    imageSource: "asset:///images/close.png"
                    onTriggered: 
                    {
                        passwordChangeSheet.close();
                    }
                }
                
                acceptAction: 
                ActionItem 
                {
                    title: "Save"
                    imageSource: "asset:///images/save.png"
                    onTriggered: 
                    {
                        changePassword();
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
	            					
				Label
				{
                	topMargin: 15
	                multiline: true
	                textFormat: TextFormat.Html
					text: "Enter your old password:"
					textStyle
					{
						color: Color.Black
					}
				}
				
				TextField 
				{
				    id: passwordField
        			horizontalAlignment: HorizontalAlignment.Fill
        			inputMode: TextFieldInputMode.Password
        			hintText: "Password"
        			input
                  		{
                  		    submitKey: SubmitKey.Next
                  		    onSubmitted: 
                  		        {
                            	}              		  
                  	    }

        		}
													
				Label
				{
                	topMargin: 15
	                multiline: true
	                textFormat: TextFormat.Html
					text: "Enter your new password (min. 6 characters):"
					textStyle
					{
						color: Color.Black
					}
				}
				
				TextField 
				{
				    id: newPasswordField1
        			horizontalAlignment: HorizontalAlignment.Fill
        			inputMode: TextFieldInputMode.Password
        			hintText: "Password"
        			input
                  		{
                  		    submitKey: SubmitKey.Next
                  		    onSubmitted: 
                  		        {
                            	}              		  
                  	    }

        		}
													
				Label
				{
                	topMargin: 15
	                multiline: true
	                textFormat: TextFormat.Html
					text: "Re-enter your new password (min. 6 characters):"
					textStyle
					{
						color: Color.Black
					}
				}
				
				TextField 
				{
				    id: newPasswordField2
        			horizontalAlignment: HorizontalAlignment.Fill
        			inputMode: TextFieldInputMode.Password
        			hintText: "Password"
        			input
                  		{
                  		    submitKey: SubmitKey.Done
                  		    onSubmitted: 
                  		        {
                  		            changePassword();
                            	}              		  
                  	    }

        		}
																	
			}
		}
		
	}
	
	function changePassword()
	{
	    if (passwordField.text != config.password)
	    {
            warningToast.body = "Wrong old password!";
	        warningToast.show();
	    }
        if (newPasswordField1.text == "")
        {
            warningToast.body = "New password must not be empty!";
	        warningToast.show();
        }
        if (newPasswordField1.text.length < 6)
        {
            warningToast.body = "New password must be at least 6 characters long!";
	        warningToast.show();
        }
        else if (newPasswordField1.text != newPasswordField2.text)
        {
            warningToast.body = "Both new password values must be equal!";
	        warningToast.show();
        }
        else 
        {
	        config.password = newPasswordField1.text;
			passwordChangeSheet.close();
	    }
	}
	
}