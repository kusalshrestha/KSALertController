//
//  KSAlertView.swift
//  ActionSheetTableView
//
//  Created by Kusal Shrestha on 5/2/16.
//  Copyright © 2016 Kusal Shrestha. All rights reserved.
//

import UIKit

typealias PickerCallBack = ((index: Int?) -> Void)
typealias DateCallBack = ((date: NSDate?) -> Void)

class KSAlertView: UIView {
    
  private let animationDuration = 0.2
  
  private var callBack: PickerCallBack!
  private var dateCallBack: DateCallBack!
  
  private var backGroundView: UIView!
  private var ksDialogView: KSDialogView!
  private var dataStrings: [String] = []  //Only for normal picker not for date picker
  
  private var isDatePickerShown = true
  
  init() {
    super.init(frame: UIScreen.mainScreen().bounds)
    initialSetup()
  }
  
  init(dataStrings: [String]) {
    self.dataStrings = dataStrings
    self.isDatePickerShown = false
    super.init(frame: UIScreen.mainScreen().bounds)
    initialSetup()
  }
  
  private func initialSetup() {
    self.backgroundColor = UIColor.clearColor()
    UIApplication.sharedApplication().windows.first!.addSubview(self)
    
    backGroundView = UIView(frame: UIScreen.mainScreen().bounds)
    self.addSubview(backGroundView)
  }
  
  func showDialogForDatePicker(withCompletion completion: DateCallBack) {
    addDialogView()
    self.dateCallBack = completion
  }
  
  func showDialog(withCompletion completion: PickerCallBack) {
    addDialogView()
    ksDialogView.dataStrings = dataStrings
    self.callBack = completion
  }
  
  private func addDialogView() {
    ksDialogView = NSBundle.mainBundle().loadNibNamed(String(KSDialogView), owner: self, options: nil).first as? KSDialogView
    ksDialogView.delegate = self
    hideShowDatePicker(isDatePickerShown)
    self.addSubview(self.ksDialogView)
    animateIn()
  }
  
  private func hideShowDatePicker(isDateShow: Bool) {
    ksDialogView.datePicker.hidden = !isDateShow
    ksDialogView.userPicker.hidden = isDateShow
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
    isDatePickerShown ? self.dateCallBack(date: nil) : self.callBack(index: nil)
    self.animateOut { (completion) in
      if completion {
          self.removeFromSuperview()
      }
    }
  }
  
  func doneButtonAction(selectedIndex: Int) {
    self.callBack(index: selectedIndex)
    self.animateOut { (completion) in
      if completion {
          self.removeFromSuperview()
      }
    }
  }
  
  func doneButtonActionForDatePicker(date: NSDate) {
    self.dateCallBack(date: date)
    self.animateOut { (completion) in
      if completion {
        self.removeFromSuperview()
      }
    }
  }
  
}
