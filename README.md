# TintingButton

Simple UIButton subclass which uses tintColor to color button elements (Title,Image,Border) based on current state. 

Why?
---

UIButton provides functionality to change Title color per UIButton state. You can also change image per state. But since iOS7 introduced renderingmode option to UIImage and face it ... you most likely want just a different color of image than different image per state. 

TintColor property can color buttons image (when used as render template) but unfortunately tintColor does not change with UIButton's state. Thats why I decided to create TintingButton

CocoaPods
---
Currently not supported (or needed more likely)


Usage
---

TintingButton could be instantiated with "Title-Image-Border", "Title-Image" or Custom colored mode 



###All Colored mode

[<img width="320 px" src="previews/screenshot1.jpg"/>]
~~~swift
let btnShare = TintingButton(completelyTintedWith: .whiteColor(), activeTintColor: .greenColor())
btnShare.setImage(imageShare, forState: UIControlState.Normal)
btnShare.setTitle(title, forState: UIControlState.Normal)

~~~
###Title Image Colored mode 

[<img width="320 px" src="previews/screenshot2.jpg"/>]


~~~swift
let btnShare = TintingButton(titleAndImageTintedWith: whiteColor(), activeTintColor: .greenColor())
btnShare.setImage(imageShare, forState: UIControlState.Normal)
btnShare.layer.borderColor = .grayColor().CGColor
btnShare.layer.borderWidth = 1
btnShare.setTitle(title, forState: UIControlState.Normal)

~~~
###Custom colored mode

TintingButton has closure syntax api to define which element should be tinted and which not. Thats in case you want to include some complex login.

~~~swift
//Same as AllColored mode
let btnShare = TintingButton(tintColor: .whiteColor(), activeTintColor: .greenColor()) { (control) -> Bool in return true}

//Custom mode with your specific logic
let btnShare = TintingButton(tintColor: .whiteColor(), activeTintColor: .greenColor()) { (control) -> Bool in
    
	switch control {
        case .Title,.Image : return yourComputedValue
        case .Border: return anotherComputedValue
    }
}
~~~
