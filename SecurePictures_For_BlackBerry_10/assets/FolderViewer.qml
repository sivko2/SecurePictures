import bb.cascades 1.3
import bb.system 1.2

Page 
{
    id: folderViewerPage
    
    property string path: ""
    property string fileName: ""
    property string filePath: ""
    property string fileType: ""
    property variant filesList: undefined
    property bool notEmpty: false
    
    property string selectedFullFile: ""
    property string selectedFile: ""
    property string suffix: ""
    
    onCreationCompleted: 
        {
            invokator.newMediaFileAdded.connect(refreshList);
            Qt.selectedFile = selectedFile;
            Qt.selectedFullFile = selectedFullFile;
            Qt.suffix = suffix;
            Qt.renameDlg = renameDlg;
            Qt.delDialog = delDialog;
        }
        
    onPathChanged: 
        {
            refreshList();
        }
    
    function refreshList()
    {
        listModel.clear();
        filesList = util.listFiles(path);
        console.debug("List of files: " + filesList.length + " for path " + path);
        if (filesList.length > 0)
        {
            notEmpty = true;
        }
        else
        {
            notEmpty = false;
        }
        
        if (notEmpty)
        {
            for (var i = 0; i < filesList.length; i++)
            {
                listModel.insert({"filename" : filesList[i].filename, 
                    "type" : filesList[i].type,
                    "image" : filesList[i].type == "Folders" ? "asset:///images/folder.png" : 
                        (filesList[i].type == "Videos" || filesList[i].type == "Unsecured videos"  ? 
                        "asset:///images/video.png" : (filesList[i].type == "Photos" || 
                        filesList[i].type == "Unsecured photos" ? "asset:///images/photo.png" : "asset:///images/voice.png")),
                        "description" : filesList[i].description, "status" : filesList[i].status, 
                        "fullname" : path + "/" + filesList[i].filename,
                        "suffix" : filesList[i].type == "Photos" ? ".sjpg" : (filesList[i].type == "Videos" ? ".smp4" : 
                        (filesList[i].type == "Voices" ? ".sm4a" : ""))});
                console.debug(path + "/" + filesList[i].filename);
            }
        }
        else 
        {
            listModel.insert({"filename" : "No files found", "type" : "Empty",
                    "image" : "asset:///images/empty_folder.png"});
        }
    }
    
    actions: 
    [
        ActionItem 
        {
            title: "Video Camera"
            imageSource: "asset:///images/videorec.png"
            ActionBar.placement: ActionBarPlacement.OnBar
            onTriggered: 
            {
                invokator.invokeVideo();
            }
        },
        ActionItem 
        {
            title: "Camera"
            imageSource: "asset:///images/camera.png"
            ActionBar.placement: ActionBarPlacement.Signature
            onTriggered: 
            {
                invokator.invokeCamera();
            }
        },
        ActionItem 
        {
            title: "Dictaphone"
            imageSource: "asset:///images/recvoice.png"
            ActionBar.placement: ActionBarPlacement.OnBar
            onTriggered: 
            {
                invokator.invokeVoice();
            }
        },
        ActionItem 
        {
            title: "Invite to Download"
            imageSource: "asset:///images/download.png"
            ActionBar.placement: ActionBarPlacement.InOverflow
            
            onTriggered: 
            {
                inviteToDownload.trigger("bb.action.SHARE");
            }
        },
        InvokeActionItem 
        {
            id: reviewAction
            title: "Review App"
            ActionBar.placement: ActionBarPlacement.InOverflow
            imageSource: "asset:///images/review.png"
            
            query
            {
                invokeTargetId: "sys.appworld"
                invokeActionId: "bb.action.OPEN"
                uri: "appworld://content/59943975"
            }
        }
    ]
    
    titleBar: 
        PronicTitleBar 
        {
            id: titleBar
            titleText: "Secure Pictures"
        }
    
    attachedObjects: 
        [
            ComponentDefinition 
            {
                id: folderViewerDef
                source: "FolderViewer.qml"
            },
            SystemDialog 
            {
                id: delDialog
                body: "Deleting file..."
                cancelButton.enabled: true
                cancelButton.label: "No"
                confirmButton.enabled: true
                confirmButton.label: "Yes"
                title: "Warning" 
                
                onFinished: 
                    {
                        console.debug("DLG RESULT: " + result);
                        if (result == SystemUiResult.ConfirmButtonSelection)
                        {
                            util.deleteFile(Qt.selectedFullFile);
                            refreshList();
                        }
                    }
            },
            SystemToast 
            {
                id: pwdToast
                body: "Password is incorrect!\n\n"
                onFinished: 
                {
                }
            },
            SystemPrompt 
            {    
                id: pwdDlg
                title: "Authentication"
                modality: SystemUiModality.Application
                inputField.inputMode: SystemUiInputMode.Password
                body: "Enter your password to view your file:"			    
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
                            console.debug("LOGIN OK " + config.forgetWhenExit);
                            if (!config.forgetWhenExit)
                            {
                                console.debug("###### NOT FORGET - PASSWORD SET");
                                navi.password = pwdDlg.inputFieldTextEntry();
                            }
                            else
                            {
                                console.debug("###### FORGET - PASSWORD UNSET");
                                navi.password = "";
                            }
                            showFile();
                        }
                        else 
                        {
                            pwdToast.show();
                        }
                    }
                    else
                    {
                    }
                }
            },
            SystemPrompt 
            {    
                 id: renameDlg
                 title: "Rename file"
                 modality: SystemUiModality.Application
                 inputField.inputMode: SystemUiInputMode.Default
                 body: "Enter a new name for the file called " + selectedFile + ":"
                 inputField.defaultText: selectedFile                 		    
                 confirmButton.label: "Change"
                 confirmButton.enabled: true
                 cancelButton.label: "Cancel"
                 cancelButton.enabled: true
                 onFinished: 
                 {
                     if (result == SystemUiResult.ConfirmButtonSelection) 
                     {
                         console.debug("RENAME: " + Qt.selectedFile);
                         var destName = renameDlg.inputFieldTextEntry();
                         
                         if (destName.toUpperCase().lastIndexOf(Qt.suffix.toUpperCase()) <= 0)
                         {
                             destName = destName + Qt.suffix;
                         }
                         util.renameFile(Qt.selectedFullFile, path + "/" + destName);
                         refreshList();
                     }
                     else
                     {
                         // DO NOTHING
                     }
                 }
            }
        ]
        
    Container 
    {
        horizontalAlignment: HorizontalAlignment.Fill
        
        Container
        {
            horizontalAlignment: HorizontalAlignment.Fill
            leftPadding: 20
            rightPadding: 20
            bottomPadding: 10
            background: Color.create("#C32C2B")
            
            Label 
            {
                id: pathLabel
                text: path
                textStyle
                {
                    color: Color.create("#FFFFFF")
                }
            }
        }

        ListView
        {
            id: folderList
            
            property bool isTouched: false
            
            onTouch: 
                {
                    if (event.isDown() | event.isMove()) 
                    {
                        isTouched = true
                    } 
                    else 
                    {
                        isTouched = false
                    }
                }
            
            leadingVisual: 
                 PullToRefresh 
                 {
                     id: pullRefresh
                     touchActive: folderList.isTouched
                     preferredWidth: listHandler.layoutFrame.width
                     
                     onRefreshTriggered: 
                         {
                             refreshList();
                             pullRefresh.touchActive = false;
                         }
                 }
                
            dataModel: 
                GroupDataModel 
                {
                    id: listModel
                    grouping: ItemGrouping.ByFullValue
                    sortingKeys: ["type", "filename"]
                }
            
            layout:
                StackListLayout 
                {
                }
            
            listItemComponents: 
            [
                ListItemComponent
                {
                    type: "item"
                    
                    StandardListItem 
                    {
                        id: stdItem
                        imageSource: ListItemData.image
                        title: ListItemData.filename
                        description: ListItemData.description
                        status: ListItemData.status
                        
                        contextActions: 
                            [
                                ActionSet 
                                {
                                    title: "Content"
                                    
                                    ActionItem 
                                    {
                                        title: "Rename"
                                        imageSource: "asset:///images/rename.png"
                                        
                                        onTriggered: 
                                            {
                                                Qt.selectedFullFile = ListItemData.fullname;
                                                Qt.selectedFile = ListItemData.filename;
                                                Qt.suffix = ListItemData.suffix;
                                                Qt.renameDlg.body = "Enter new name for file " + Qt.selectedFile + ":";
                                                Qt.renameDlg.inputField.defaultText = Qt.selectedFile;             		    
                                                Qt.renameDlg.show();
                                            }
                                    }
                                    
                                    DeleteActionItem 
                                    {
                                        title: "Delete"
                                        
                                        onTriggered: 
                                        {
                                            Qt.selectedFullFile = ListItemData.fullname;
                                            Qt.selectedFile = ListItemData.filename;
                                            Qt.delDialog.body = "Do you want to delete " + Qt.selectedFile + "?";            		    
                                            Qt.delDialog.show();
                                        }
                                   }
                                }
                            ]
                    }              
                }
            ]
            
            onTriggered: 
            {
                if (notEmpty)
                {
                    var selectedItem = dataModel.data(indexPath);
                    if (selectedItem.type == "Folders")
                    {
                        var folderViewer = folderViewerDef.createObject();
                        console.debug(">>>> PATH: " + selectedItem.path);
                        navi.push(folderViewer);
                        folderViewer.path = path + "/" + selectedItem.filename;
                    }
                    else 
                    {
                        filePath = path;
                        fileType = selectedItem.type;
                        fileName = selectedItem.filename;
                        if (password == "")
                        {
                            pwdDlg.show();
                        }
                        else
                        {
                            showFile();
                        }
                    }
                }
            }
            
            attachedObjects:
                [
                    LayoutUpdateHandler 
                    {
                        id: listHandler
                        
                        onLayoutFrameChanged: 
                        {
                            console.debug("New width: " + layoutFrame.width);
                        }
                    }                    
                ]
        }
        
    }
    
    function showFile()
    {
        if (fileType === "Photos")
        {
            invokator.invokePicViewer(filePath, fileName);
        }
        else 
        {
            invokator.invokeMoviePlayer(filePath, fileName);
        }
    }
    
}
