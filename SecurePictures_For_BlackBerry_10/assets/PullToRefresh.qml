import bb.cascades 1.3

Container 
{
    signal refreshTriggered
    
    property bool touchActive: false

    ImageView 
    {
        id: imgRefreshIcon

        imageSource: "asset:///images/refresh.png"
        horizontalAlignment: HorizontalAlignment.Center
        scalingMethod: ScalingMethod.AspectFit
        verticalAlignment: VerticalAlignment.Center
    }
    
    Label 
    {
        id: lblRefresh
        text: "Pull down to refresh"
        horizontalAlignment: HorizontalAlignment.Center
        verticalAlignment: VerticalAlignment.Center
        textStyle.textAlign: TextAlign.Center
        textStyle.color: Color.create("#c32c2b")
    }

    attachedObjects: 
        [
            LayoutUpdateHandler 
            {
                id: refreshHandler
                
                onLayoutFrameChanged: 
                    {
                        imgRefreshIcon.rotationZ = layoutFrame.y;
                        if (layoutFrame.y >= 0.0) 
                        {
                            lblRefresh.text = "Release to refresh";
        
                            if (layoutFrame.y == 0 && touchActive != true) 
                            {
                                refreshTriggered();
                                lblRefresh.text = "Refreshing...";
                            }
                        } 
                        else 
                        {
                            lblRefresh.text = "Pull down to refresh";
                        }
                    }
            }
        ]

}