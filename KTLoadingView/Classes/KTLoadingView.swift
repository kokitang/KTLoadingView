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

public class KTLoadingView: UIView {
    
    /*
     Defines the style of LoadingView.
     Default: .fullScreen
     - fullScreen: Cover whole screen.
     - center: Cover by given CGSize in center of current screen.
     - custom: Cover by given frame rect.
     
     !!If containerView != nil, screen means containerView.!!
     */
    public enum SizeStyle {
        case fullScreen
        case center(CGSize)
        case custom(CGRect)
        
        init() {
            self = .fullScreen
        }
    }
    public static let shared = KTLoadingView.init()
    public private(set) var containerView: UIView? = nil
    public let label = KTLoadingLabel.init()
    public private(set) var type: NVActivityIndicatorType = .lineScalePulseOut {
        didSet {
            activityIndicator.type = type
        }
    }
    public var textSize: CGFloat = 16 {
        didSet {
            label.font = label.font.withSize(textSize)
        }
    }
    public var textFont: UIFont! = UIFont.init(name: "SetoFont", size: 16) ?? UIFont.systemFont(ofSize: UIFont.labelFontSize) {
        didSet {
            label.font = textFont
        }
    }
    public var text: String = "" {
        didSet {
            label.staticText = text
        }
    }
    public var animateText: String = "" {
        didSet {
            label.animateText = animateText
        }
    }
    public var sizeStyle: SizeStyle = .fullScreen {
        didSet {
            updateSizeStyle()
        }
    }
    public var textColor: UIColor = .white {
        didSet {
            label.textColor = textColor
        }
    }
    public var indicatorColor: UIColor = .white {
        didSet {
            activityIndicator.color = indicatorColor
        }
    }
    
    init(type: NVActivityIndicatorType = .lineScalePulseOut) {
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
    
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        initSetup()
    }
    
    /*
     Function: Show LoadingView in the top of screen
     Parameters:
     - container: If container is not nil, LoadingView will show inside container.
     - text: The text shown in label.
     - type: Type of NVActivityIndicator.
     */
    public class func show(in container: UIView? = nil, text: String = "", animateText: String = "", type: NVActivityIndicatorType = .lineScalePulseOut, sizeStyle: SizeStyle = .fullScreen) {
        if container != nil {
            shared.containerView = container
        }
        shared.text = text
        shared.animateText = animateText
        shared.sizeStyle = sizeStyle
        shared.show()
    }
    
    public class func show(text: String, animateText: String = "") {
        KTLoadingView.show(in: nil, text: text, animateText: animateText)
    }
    
    public class func show(type: NVActivityIndicatorType) {
        KTLoadingView.show(in: nil, text: "", type: type)
    }
    
    public func show() {
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
    
    public final class func hide(after timeInterval: TimeInterval = 0) {
        shared.hide(after: timeInterval)
    }
    
    public func hide(after timeInterval: TimeInterval = 0) {
        if timeInterval > 0 {
            if #available(iOS 10.0, *) {
                let _ = Timer.init(timeInterval: timeInterval, repeats: false) { (timer) in
                    self.removeFromSuperview()
                }
            } else {
                // Fallback on earlier versions
                DispatchQueue.main.asyncAfter(deadline: .now() + timeInterval, execute: {
                    self.removeFromSuperview()
                })
            }
        } else {
            removeFromSuperview()
        }
    }
    
    // MARK: Internal
    private let background = UIVisualEffectView.init(effect: UIBlurEffect.init(style: UIBlurEffectStyle.dark))
    private let centerView = UIView.init()
    private let activityIndicator: NVActivityIndicatorView = NVActivityIndicatorView.init(frame: .zero)
    
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
    
}

extension NVActivityIndicatorType {
   static let allTypes = (NVActivityIndicatorType.blank.rawValue ... NVActivityIndicatorType.circleStrokeSpin.rawValue).map { NVActivityIndicatorType(rawValue: $0)! }
}
