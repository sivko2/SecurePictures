import bb.cascades 1.3

Container 
{
	Label
	{
	    text: "Pictures Protected By"
	    horizontalAlignment: HorizontalAlignment.Center
	    verticalAlignment: VerticalAlignment.Center
	    textStyle.color: Color.Black
	    textStyle.fontSize: FontSize.XXSmall
	    textStyle.fontWeight: FontWeight.Bold
	}
	
	ImageView 
	{
        imageSource: "asset:///images/cover.png"
    }

}
