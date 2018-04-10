//
//  loadingView.swift
//  LoadingView
//
//  Created by kidnapper on 26/02/2018.
//  Copyright © 2018 25sprout.com. All rights reserved.
//

import UIKit

enum LoadingType {
    case caution
    case success
    case like
    case unlike
    case send
}

class KGAlertView: UIView {
    
    @IBOutlet var contentView: UIView!
    @IBOutlet var imageView: UIImageView!
    @IBOutlet var label: UILabel!
    
    static var alertView = KGAlertView()
    private var seconds: TimeInterval = 2
    private var timer = Timer()
    private var type: LoadingType = .send {
        didSet {
            switch type {
            case .caution:
                imageView.image = #imageLiteral(resourceName: "img_indicate_alert_caution")
            case .success:
                imageView.image = #imageLiteral(resourceName: "img_indicate_toast_success")
            case .like:
                imageView.image = #imageLiteral(resourceName: "img_indicate_alert_like")
            case .unlike:
                imageView.image = #imageLiteral(resourceName: "img_indicate_alert_unlike")
            default:
                imageView.image = #imageLiteral(resourceName: "img_indicate_toast_send")
            }
        }
    }
    
    init() {
        super.init(frame: CGRect.zero)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    func setup() {
        Bundle.main.loadNibNamed("KGAlertView", owner: self, options: nil)
        addSubview(contentView)
        contentView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
    }
    
    static func show(toView: UIView, category: LoadingType, title: String? = nil, displayTimeInterval: TimeInterval = 2) {
        var displayTitle: String
        if title == nil {
            switch category {
            case .like:
                displayTitle = "已收藏"
            case .unlike:
                displayTitle = "已取消收藏"
            case .caution:
                displayTitle = "請在30秒後重試"
            case .success:
                displayTitle = "更新成功"
            case .send:
                displayTitle = "註冊成功"
            }
        }
        else {
            displayTitle = title!
        }
        let attributes = [NSAttributedStringKey.font: UIFont(name: "PingFangTC-Light", size: 16)! ]
        let attributedString = NSMutableAttributedString(string: displayTitle, attributes: attributes)
        alertView.label.attributedText = attributedString
        alertView.contentView.frame = toView.frame
        alertView.alpha = 0
        alertView.type = category
        alertView.seconds = displayTimeInterval
        alertView.timer.invalidate()
        alertView.timer = Timer.scheduledTimer(timeInterval: 0.5, target: self, selector: #selector(updateTimer), userInfo: nil, repeats: true)
        toView.addSubview(alertView)
        alertView.fadeIn()
    }
    
    static func customShow(toView: UIView, imageName: String, title: String, displayTimeInterval: TimeInterval = 2) {
        alertView.imageView.image = UIImage(named: imageName)
        let attributes = [NSAttributedStringKey.font: UIFont(name: "PingFangTC-Light", size: 16)! ]
        let attributedString = NSMutableAttributedString(string: title, attributes: attributes)
        alertView.label.attributedText = attributedString
        alertView.contentView.frame = toView.frame
        alertView.alpha = 0
        alertView.seconds = displayTimeInterval
        alertView.timer.invalidate()
        alertView.timer = Timer.scheduledTimer(timeInterval: 0.5, target: self, selector: #selector(updateTimer), userInfo: nil, repeats: true)
        toView.addSubview(alertView)
        alertView.fadeIn()
    }
    
    static func hide(toView: UIView) {
        alertView.fadeOut()
    }
    
    @objc static func updateTimer() {
        if alertView.seconds < 1 {
            alertView.fadeOut()
            alertView.timer.invalidate()
        }
        else {
            alertView.seconds -= 0.5
        }
    }
    
    func fadeIn(duration: TimeInterval = 0.1,
                delay: TimeInterval = 0.0,
                completion: @escaping ((Bool) -> Void) = {(finished: Bool) -> Void in }) {
        UIView.animate(withDuration: duration,
                       delay: delay,
                       options: UIViewAnimationOptions.curveEaseIn,
                       animations: {
                        KGAlertView.alertView.alpha = 1.0
        }, completion: completion)
    }
    
    func fadeOut(duration: TimeInterval = 0.3,
                 delay: TimeInterval = 0.0,
                 completion: @escaping (Bool) -> Void = {(finished: Bool) -> Void in }) {
        UIView.animate(withDuration: duration,
                       delay: delay,
                       options: UIViewAnimationOptions.curveEaseIn,
                       animations: {
                        KGAlertView.alertView.alpha = 0.0
        }, completion: { _ in KGAlertView.alertView.removeFromSuperview()
        })
    }
}

