//
//  KTLoadingView.swift
//  KTLoadingView
//
//  Created by Koki Tang on 1/3/2018.
//  Copyright © 2018年 Koki Tang. All rights reserved.
//

import UIKit
import KTLoadingLabel
import NVActivityIndicatorView

// Constants
let kScreenWidth = UIScreen.main.bounds.width
let kScreenHeight = UIScreen.main.bounds.height
let kScreenRect = UIScreen.main.bounds
let kWindowRect = UIApplication.shared.keyWindow?.bounds

class KTLoadingView: UIView {
    
    /*
     Defines the style of LoadingView.
     Default: .fullScreen
     - fullScreen: Cover whole screen.
     - center: Cover by given CGSize in center of current screen.
     - custom: Cover by given frame rect.
     
     !!If containerView != nil, screen means containerView.!!
     */
    enum SizeStyle {
        case fullScreen
        case center(CGSize)
        case custom(CGRect)
        
        init() {
            self = .fullScreen
        }
    }
    static let shared = KTLoadingView.init()
    public private(set) var containerView: UIView? = nil
    let background = UIVisualEffectView.init(effect: UIBlurEffect.init(style: UIBlurEffectStyle.dark))
    let label = KTLoadingLabel.init()
    private let centerView = UIView.init()
    private let activityIndicator: NVActivityIndicatorView = NVActivityIndicatorView.init(frame: .zero)
    public private(set) var type: NVActivityIndicatorType = .lineScalePulseOut {
        didSet {
            activityIndicator.type = type
        }
    }
    var textSize: CGFloat = 16 {
        didSet {
            label.font = label.font.withSize(textSize)
        }
    }
    var textFont: UIFont! = UIFont.init(name: "SetoFont", size: 16) ?? UIFont.systemFont(ofSize: UIFont.labelFontSize) {
        didSet {
            label.font = textFont
        }
    }
    var text: String = "" {
        didSet {
            label.staticText = text
        }
    }
    var animateText: String = "" {
        didSet {
            label.animateText = animateText
        }
    }
    
    var sizeStyle: SizeStyle = .fullScreen {
        didSet {
            updateSizeStyle()
        }
    }
    
    var textColor: UIColor = .white {
        didSet {
            label.textColor = textColor
        }
    }
    
    var indicatorColor: UIColor = .white {
        didSet {
            activityIndicator.color = indicatorColor
        }
    }
    
    private init(type: NVActivityIndicatorType = .lineScalePulseOut) {
        super.init(frame: kScreenRect)
        self.type = type
        initSetup()
    }
    
    @IBInspectable var typeName: String {
        get {
            return getTypeName()
        }
        set {
            _setTypeName(newValue)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        initSetup()
    }
    
    private func initSetup() {
        layer.masksToBounds = true
        frame = kScreenRect
        backgroundColor = .clear
        background.frame = bounds
        addSubview(background)
        
        // Center container
        centerView.translatesAutoresizingMaskIntoConstraints = false
        centerView.backgroundColor = .clear
        centerView.layer.masksToBounds = true
        addSubview(centerView)
        centerView.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        centerView.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        centerView.leadingAnchor.constraint(greaterThanOrEqualTo: self.leadingAnchor, constant: 16).isActive = true
        centerView.topAnchor.constraint(greaterThanOrEqualTo: self.topAnchor, constant: 8).isActive = true
        
        // Activity Indicator
        activityIndicator.type = type
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        activityIndicator.startAnimating()
        activityIndicator.color = indicatorColor
        centerView.addSubview(activityIndicator)
        activityIndicator.heightAnchor.constraint(equalToConstant: 35).isActive = true
        activityIndicator.widthAnchor.constraint(equalToConstant: 35).isActive = true
        activityIndicator.leadingAnchor.constraint(greaterThanOrEqualTo: centerView.leadingAnchor).isActive = true
        activityIndicator.centerXAnchor.constraint(equalTo: centerView.centerXAnchor).isActive = true
        activityIndicator.topAnchor.constraint(equalTo: centerView.topAnchor).isActive = true
        
        // Label
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = textColor
        centerView.addSubview(label)
        label.centerXAnchor.constraint(equalTo: centerView.centerXAnchor).isActive = true
        label.topAnchor.constraint(equalTo: activityIndicator.bottomAnchor, constant: 16).isActive = true
        label.leadingAnchor.constraint(equalTo: centerView.leadingAnchor).isActive = true
        label.bottomAnchor.constraint(equalTo: centerView.bottomAnchor).isActive = true
        
        for subview in subviews {
            if subview != background {
                bringSubview(toFront: subview)
            }
        }
    }
    
    /*
     Function: Show LoadingView in the top of screen
     Parameters:
     - container: If container is not nil, LoadingView will show inside container.
     - text: The text shown in label.
     - type: Type of NVActivityIndicator.
     */
    class func show(in container: UIView? = nil, text: String = "", animateText: String = "", type: NVActivityIndicatorType = .lineScalePulseOut, sizeStyle: SizeStyle = .init()) {
        if container != nil {
            shared.containerView = container
        }
        shared.text = text
        shared.animateText = animateText
        shared.sizeStyle = sizeStyle
        shared.show()
    }
    
    class func show(text: String, animateText: String = "") {
        KTLoadingView.show(in: nil, text: text, animateText: animateText)
    }
    
    class func show(type: NVActivityIndicatorType) {
        KTLoadingView.show(in: nil, text: "", type: type)
    }
    
    func show() {
        removeFromSuperview()
        
        if let containerView = containerView {
            frame = containerView.bounds
            background.frame = bounds
            containerView.addSubview(self)
        } else {
            guard let window = UIApplication.shared.keyWindow else {
                if let window = UIApplication.shared.windows.first {
                    print("Show from first window")
                    window.addSubview(self)
                } else {
                    fatalError("No window found")
                }
                return
            }
            print("Show from keyWindow")
            window.addSubview(self)
        }
        updateSizeStyle()
        label.animate()
    }
    
    // MARK: Internal
    private func _setTypeName(_ typeName: String) {
        for item in NVActivityIndicatorType.allTypes {
            if String(describing: item).caseInsensitiveCompare(typeName) == ComparisonResult.orderedSame {
                type = item
                break
            }
        }
    }
    
    private func getTypeName() -> String {
        return String(describing: type)
    }
    
    private func updateSizeStyle() {
        switch sizeStyle {
        case .center(let size):
            if let superview = superview {
                frame = CGRect(x: 0, y: 0, width: size.width, height: size.height)
                center = superview.center
            }
            
        case .custom(let rect):
            frame = rect
            
        default:
            break
        }
    }
    
}

extension NVActivityIndicatorType {
   static let allTypes = (NVActivityIndicatorType.blank.rawValue ... NVActivityIndicatorType.circleStrokeSpin.rawValue).map { NVActivityIndicatorType(rawValue: $0)! }
}
