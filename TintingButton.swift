//
//  TintingButton.swift
//
//  Created by Dominik Vesely on 11/04/15.
//  Copyright (c) 2015 Ackee s.r.o. All rights reserved.
//

import Foundation

class TintingButton : UIButton {
    
    typealias TintingButtonAction  = (control: Element) -> Bool
    var activeTintColor : UIColor?
    var normalTintColor : UIColor?
    
    private var action : TintingButtonAction?
    
    enum Element: Int {
        case Title,Image,Border
    }
    
    
    convenience init (completelyTintedWith tintColor : UIColor?, activeTintColor: UIColor?) {
        self.init(tintColor: tintColor, activeTintColor: activeTintColor, tintAction: {(control: Element) -> Bool in return true})
    }

    
    convenience init (titleAndImageTintedWith tintColor : UIColor?, activeTintColor: UIColor?) {
        
        let defaultAction =  { (control: Element) -> Bool in
            
            switch control {
                case .Title,.Image : return true
                case .Border: return false
            }
        }
        
        self.init(tintColor: tintColor, activeTintColor: activeTintColor, tintAction: defaultAction)
        
        
    }
    
    required init (tintColor : UIColor?, activeTintColor: UIColor?, tintAction: TintingButtonAction  ) {
        super.init(frame: CGRect.zeroRect)
        
        self.normalTintColor = tintColor
        self.activeTintColor = activeTintColor
        self.tintColor = normalTintColor
        self.adjustsImageWhenHighlighted = false
        self.action = tintAction
        
        
        styleTitle()
        styleBorder()
        
    }


    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    
    func styleTitle() {
        
        if action!(control: .Title) {
            setTitleColor(tintColor, forState: UIControlState.Normal)
            setTitleColor(activeTintColor, forState: UIControlState.Selected)
            setTitleColor(activeTintColor, forState: UIControlState.Highlighted)
        }
        
    }
    
    func styleBorder() {
        if action!(control: .Border) {
            layer.borderColor = tintColor?.CGColor
            layer.borderWidth = layer.borderWidth == 0 ? 1.0 : layer.borderWidth
        }
    }
    
    override func setImage(image: UIImage?, forState state: UIControlState) {
        
        var img = image
        if action!(control: .Image) {
            img = image?.imageWithRenderingMode(UIImageRenderingMode.AlwaysTemplate)
        }
        
        super.setImage(img, forState: state)
    }
    

    
    override var selected : Bool {
        didSet {
            if selected {
               tintColor = activeTintColor
            } else {
                tintColor = normalTintColor
            }
            styleBorder()
        }
    }
    
    override var highlighted : Bool {
        didSet {
            if highlighted {
                tintColor = activeTintColor
            } else {
                tintColor = normalTintColor
            }
            styleBorder()

        }
    }
    
    
}
