//
//  KSAlertView.swift
//  ActionSheetTableView
//
//  Created by Kusal Shrestha on 5/2/16.
//  Copyright © 2016 Kusal Shrestha. All rights reserved.
//

import UIKit

typealias DateCallBack = ((date: NSDate?) -> Void)

class KSAlertView: UIView {
    
    private let animationDuration = 0.2
    private var callBack: DateCallBack!
    private var backGroundView: UIView!
    private var ksDialogView: KSDialogView!
    
    init() {
        super.init(frame: UIScreen.mainScreen().bounds)
        self.backgroundColor = UIColor.clearColor()
        UIApplication.sharedApplication().windows.first!.addSubview(self)
        
        backGroundView = UIView(frame: UIScreen.mainScreen().bounds)
        self.addSubview(backGroundView)
    }
    
    func showDialog(withCompletion completion: DateCallBack) {
        ksDialogView = NSBundle.mainBundle().loadNibNamed("KSAlertView", owner: self, options: nil).first as? KSDialogView
        self.callBack = completion
        ksDialogView.delegate = self
        self.addSubview(self.ksDialogView)
        
        animateIn()
    }
    
    private func animateIn() {
        self.transform = CGAffineTransformMakeScale(1.15, 1.15)
        self.backGroundView.alpha = 0
        self.alpha = 0

        UIView.animateWithDuration(animationDuration, delay: 0, options: .TransitionNone, animations: {
            self.transform = CGAffineTransformMakeScale(1, 1)
            self.backGroundView.backgroundColor = UIColor.grayColor()
            self.alpha = 1
            self.backGroundView.alpha = 0.6
            }, completion: nil)
    }
    
    private func animateOut(animCompletion: (Bool -> Void)?) {
        UIView.animateWithDuration(animationDuration, delay: 0, options: .TransitionNone, animations: {
            self.ksDialogView.transform = CGAffineTransformMakeScale(0.6, 0.6)
            self.backgroundColor = UIColor.whiteColor()
            self.alpha = 0
            }, completion: animCompletion)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        self.frame = UIScreen.mainScreen().bounds
        backGroundView.frame = UIScreen.mainScreen().bounds
    }
    
}

extension KSAlertView: KSAlertDelegate {
    
    func cancelButtonAction() {
        self.callBack(date: nil)
        self.animateOut { (completion) in
            if completion {
                self.removeFromSuperview()
            }
        }
    }
    
    func doneButtonAction(date: NSDate) {
        self.callBack(date: date)
        self.animateOut { (completion) in
            if completion {
                self.removeFromSuperview()
            }
        }
    }
    
}
