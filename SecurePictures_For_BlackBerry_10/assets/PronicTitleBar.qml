import bb.cascades 1.3

TitleBar 
{
    id: pronicTitleBar
    property alias titleText: titleLabel.text
    property int layoutHeight: 0
    property int layoutWidth: 0
    
    kind: TitleBarKind.FreeForm
    
    scrollBehavior: TitleBarScrollBehavior.Sticky

    kindProperties: 
        FreeFormTitleBarKindProperties 
        {
            
            Container 
            {
/*                attachedObjects: 
                [
                    ImagePaintDefinition 
                    {
                        id: titlePaint
                        imageSource: "asset:///images/titlebar_bgd.png"                     
                    }
                ]*/
                
                background: Color.create("#FFFFFF")
                
                verticalAlignment: VerticalAlignment.Fill
                
                layout: 
                    DockLayout 
                    {
                    }
               
                Container 
                {
                    leftPadding: 25
                    rightPadding: 25
                    horizontalAlignment: HorizontalAlignment.Fill
                    verticalAlignment: VerticalAlignment.Fill
                    
                    layout:
                        DockLayout 
                        {
                        }
                    
                    Label 
                    {
                        id: titleLabel
                        verticalAlignment: VerticalAlignment.Center
                        horizontalAlignment: HorizontalAlignment.Left
                        
                        textStyle
                        {
                            color: Color.create("#C32C2B")
                            base: SystemDefaults.TextStyles.TitleText
                            fontWeight: FontWeight.W900
                        }
                        
                     }
                    
                    ImageView 
                    {
                        imageSource: "asset:///images/titlebar.png"
                        horizontalAlignment: HorizontalAlignment.Right
                        verticalAlignment: VerticalAlignment.Center
                    }
                }
                
                Container 
                {
                    horizontalAlignment: HorizontalAlignment.Fill
                    verticalAlignment: VerticalAlignment.Bottom
                    
                    layout:
                        DockLayout 
                        {
                        }
                
                        ImageView 
                        {
                            imageSource: "asset:///images/titlebar_line.png"
                            horizontalAlignment: HorizontalAlignment.Fill
                            verticalAlignment: VerticalAlignment.Bottom
                        }
                }
                
            }
        }
}
