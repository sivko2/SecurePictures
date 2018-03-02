import bb.cascades 1.3
import bb.system 1.2

NavigationPane 
{
    id: navigationPane
    backButtonsVisible: true
    peekEnabled: true
    
    property string file: ""
    property string fileType: ""
    property string fileName: ""
    property string filePath: ""
    
    Page 
    {
        titleBar: 
            PronicTitleBar 
            {
                id: titleBar
                titleText: "Secure Pictures"
            }
            
        onCreationCompleted: 
            {
                pwdDlg.show();
            }
            
        attachedObjects: 
            [
                SystemToast 
                {
                    id: pwdToast
                    body: "Password is incorrect!\n\n"
                    onFinished: 
                    {
                        invokator.closeCard();
                    }
                },
                SystemPrompt 
                {    
                    id: pwdDlg
                    title: "Authentication"
                    modality: SystemUiModality.Application
                    inputField.inputMode: SystemUiInputMode.Password
                    body: "Enter your password to view your picture or video:"			    
                    confirmButton.label: "View"
                    confirmButton.enabled: true
                    cancelButton.label: "Close"
                    cancelButton.enabled: true
                    
                    onFinished: 
                    {
                        if (result == SystemUiResult.ConfirmButtonSelection) 
                        {
                            if (config.password === pwdDlg.inputFieldTextEntry())
                            {
                                console.debug("LOGIN OK ");
                                showFile();
                            }
                            else 
                            {
                                pwdToast.show();
                            }
                        }
                        else
                        {
                            invokator.closeCard();
                        }
                    }
                }
            ]
        
        Container 
        {
            horizontalAlignment: HorizontalAlignment.Fill
            verticalAlignment: VerticalAlignment.Fill
            
            layout: 
                DockLayout 
                {
                }
                
            ImageView 
            {
                horizontalAlignment: HorizontalAlignment.Center
                verticalAlignment: VerticalAlignment.Center
                imageSource: "asset:///images/cover.png"
            }
        }
    }
    
    function showFile()
    {
        console.debug("##### File: " + file);
        file = file.substring(7);
        var ext = file.substring(file.lastIndexOf(".") + 1);
        if (ext == "sjpg")
        {
            fileType = "Photos";
        }
        else if (ext == "smp4")
        {
            fileType = "Videos";
        }
        fileName = file.substring(file.lastIndexOf("/") + 1);
        filePath = file.substring(0, file.lastIndexOf("/"));
        console.debug("##### " + fileType + " " + fileName + " " + filePath);

        if (fileType === "Photos")
        {
            invokator.invokePicViewer(filePath, fileName);
        }
        else if (fileType === "Videos")
        {
            invokator.invokeMoviePlayer(filePath, fileName);
        }
    }

}
