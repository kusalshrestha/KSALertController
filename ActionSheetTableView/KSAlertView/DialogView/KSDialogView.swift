//
//  KSDialogView.swift
//  ActionSheetTableView
//
//  Created by Kusal Shrestha on 5/2/16.
//  Copyright © 2016 Kusal Shrestha. All rights reserved.
//

import UIKit

protocol KSAlertDelegate: class {
  
  func cancelButtonAction()
  func doneButtonAction(selectedIndex: Int)
  func doneButtonActionForDatePicker(date: NSDate)
  
}

// Note: There are two picker views in Xib file; one is hidden
class KSDialogView: UIView {
  
  @IBOutlet var datePicker: UIDatePicker!
  @IBOutlet var userPicker: UIPickerView!
  
  let rowHeight: CGFloat = 44
  
  weak var delegate: KSAlertDelegate?
  var dataStrings: [String] = [] {
    didSet {
      userPicker.reloadComponent(0)
    }
  }
  
  override func awakeFromNib() {
    layer.cornerRadius = 12
    userPicker.dataSource = self
    userPicker.delegate = self
  }
  
  @IBAction func cancelAction(sender: AnyObject) {
    delegate?.cancelButtonAction()
  }
  
  @IBAction func doneAction(sender: AnyObject) {
    if datePicker.hidden {
      let selectedRow: Int = userPicker.selectedRowInComponent(0)
      if !dataStrings.isEmpty {
        delegate?.doneButtonAction(selectedRow)
      }
    } else {
      delegate?.doneButtonActionForDatePicker(datePicker.date)
    }
  }
  
  override func layoutSubviews() {
    super.layoutSubviews()
    
    let screen = UIScreen.mainScreen().bounds
    self.center = CGPoint(x: screen.width / 2, y: screen.height / 2)
  }
  
}

extension KSDialogView: UIPickerViewDelegate {
  
  func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
    let name = dataStrings[row]
    return name
  }
  
  func pickerView(pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
    return rowHeight
  }
  
}

extension KSDialogView: UIPickerViewDataSource {
  
  func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
    return 1
  }
  
  func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
    return dataStrings.count
  }
  
}
