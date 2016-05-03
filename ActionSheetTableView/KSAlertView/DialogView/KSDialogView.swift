//
//  KSDialogView.swift
//  ActionSheetTableView
//
//  Created by Kusal Shrestha on 5/2/16.
//  Copyright © 2016 Kusal Shrestha. All rights reserved.
//

import UIKit

protocol KSAlertDelegate: NSObjectProtocol {
    
    func cancelButtonAction()
    func doneButtonAction(date: NSDate)
    
}

class KSDialogView: UIView {
    
    @IBOutlet var datePicker: UIDatePicker!
    weak var delegate: KSAlertDelegate?
    
    override func awakeFromNib() {
        self.layer.cornerRadius = 12
    }
    
    @IBAction func cancelAction(sender: AnyObject) {
        delegate?.cancelButtonAction()
    }
    
    @IBAction func doneAction(sender: AnyObject) {
        delegate?.doneButtonAction(datePicker.date)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        let screen = UIScreen.mainScreen().bounds
        self.center = CGPoint(x: screen.width / 2, y: screen.height / 2)
    }

}
