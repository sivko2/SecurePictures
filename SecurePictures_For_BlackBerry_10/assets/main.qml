import bb.cascades 1.3

NavigationPane 
{
    id: navi
    
    backButtonsVisible: true
    
    property string password: ""
    
    onCreationCompleted: 
        {
            Application.thumbnail.connect(onThumbnail);
        }
        
    function onThumbnail() 
    {
        console.debug("Minimized");
        if (config.forgetWhenMin)
        {
            console.debug("And forgotten");
            password = "";
        }
    }
    
    onPopTransitionEnded: 
        { 
            page.destroy(); 
        }
    
    Menu.definition: 
        CameraMenuDefinition
        {
        }
        
    attachedObjects: 
        [
            ComponentDefinition 
            {
                id: folderViewerDef
                source: "FolderViewer.qml"
            },
            Invocation 
            {
                id: inviteToDownload
                query
                {
                    mimeType: "text/plain"
                    data: "Protect your pictures, sounds and videos with Secure Pictures! You can find it at " +
                        "http://appworld.blackberry.com/webstore/content/59943975 and purchase it."               
                }
            }
        ]
    
    Page 
    {

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
        
        Container 
        {
            layout: 
                DockLayout 
                {
                }
            
            ListView
            {
                onCreationCompleted: 
                    {
                        listModel.insert({"id" : "SD", "name" : "External Storage", 
                                "description" : "Smartphone's removable external storage", 
                                "image" : "asset:///images/memory_card.png", "group" : "Memory Card", 
                            "path" : "../../removable/sdcard", 
                            "status" : util.checkFolder("../../removable/sdcard") ? "true" : "false"});
                        listModel.insert({"id" : "VIDEOSD", "name" : "Videos", 
                                "description" : "Videos, movies and tapes on memory card", 
                                "image" : "asset:///images/videos_folder.png", "group" : "Memory Card", 
                            "path" : "../../removable/sdcard/videos", 
                            "status" : util.checkFolder("../../removable/sdcard/videos") ? "true" : "false"});
                        listModel.insert({"id" : "PICSSD", "name" : "Photos", 
                                "description" : "Photos, images and drawings on memory card", 
                                "image" : "asset:///images/photos_folder.png", "group" : "Memory Card", 
                            "path" : "../../removable/sdcard/photos", 
                            "status" : util.checkFolder("../../removable/sdcard/photos") ? "true" : "false"});
                        listModel.insert({"id" : "VOICESD", "name" : "Voices", 
                                "description" : "Voices and music on memory card", 
                                "image" : "asset:///images/voices_folder.png", "group" : "Memory Card", 
                                "path" : "../../removable/sdcard/voice", 
                                "status" : util.checkFolder("../../removable/sdcard/voice") ? "true" : "false"});
                        listModel.insert({"id" : "CAMSD", "name" : "Camera", 
                            "description" : "Pictures, selfies and fun stuff on memory card", 
                            "image" : "asset:///images/camera_shot.png", "group" : "Memory Card", 
                            "path" : "../../removable/sdcard/camera", 
                            "status" : util.checkFolder("../../removable/sdcard/camera") ? "true" : "false"});
                        listModel.insert({"id" : "INT", "name" : "Internal Storage", 
                            "description" : "Smartphone's integrated internal storage", 
                            "image" : "asset:///images/drive.png", "group" : "Device", 
                            "path" : "./shared", 
                            "status" : util.checkFolder("./shared") ? "true" : "false"});
                        listModel.insert({"id" : "DL", "name" : "Downloads", 
                            "description" : "Downloads, files and Internet stuff", 
                            "image" : "asset:///images/downloads.png", "group" : "Device", 
                            "path" : "./shared/downloads", 
                            "status" : util.checkFolder("./shared/downloads") ? "true" : "false"});
                        listModel.insert({"id" : "VIDEO", "name" : "Videos", 
                            "description" : "Videos, movies and tapes", 
                            "image" : "asset:///images/videos_folder.png", "group" : "Device", 
                            "path" : "./shared/videos", 
                            "status" : util.checkFolder("./shared/videos") ? "true" : "false"});
                        listModel.insert({"id" : "PICS", "name" : "Photos", 
                            "description" : "Photos, images and drawings", 
                            "image" : "asset:///images/photos_folder.png", "group" : "Device", 
                            "path" : "./shared/photos", 
                            "status" : util.checkFolder("./shared/photos") ? "true" : "false"});
                        listModel.insert({"id" : "VOICE", "name" : "Voices", 
                                "description" : "Voices and music", 
                                "image" : "asset:///images/voices_folder.png", "group" : "Device", 
                                "path" : "./shared/voice", 
                                "status" : util.checkFolder("./shared/voice") ? "true" : "false"});
                        listModel.insert({"id" : "CAM", "name" : "Camera", 
                            "description" : "Pictures, selfies and fun stuff", 
                            "image" : "asset:///images/camera_shot.png", "group" : "Device", 
                            "path" : "./shared/camera", 
                            "status" : util.checkFolder("./shared/camera") ? "true" : "false"});
                    }
                    
                dataModel: 
                    GroupDataModel 
                    {
                        id: listModel
                        grouping: ItemGrouping.ByFullValue
                        sortingKeys: ["group"]
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
                                imageSource: ListItemData.image
                                title: ListItemData.name
                                description: ListItemData.description
                                status: ListItemData.status == "true" ? "" : "Not detected"
                                enabled: ListItemData.status == "true"
                            }
                            
                            
                        }
                    ]
            
                onTriggered: 
                    {
                        var selectedItem = dataModel.data(indexPath);
                        if (selectedItem.status == "true")
                        {
                            var folderViewer = folderViewerDef.createObject();
                            console.debug(">>>> PATH: " + selectedItem.path);
                            navi.push(folderViewer);
                            folderViewer.path = selectedItem.path;
                        }
                    }
            }
        }
        
        ActionBar.placement: ActionBarPlacement.OnBar
        
    }

}

