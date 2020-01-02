//
//  DateTableViewCell.swift
//  Vincount
//
//  Created by ChuoiChien on 3/17/19.
//  Copyright © 2019 NguyenVanChien. All rights reserved.
//

import UIKit
import Reusable
import CoreActionSheetPicker

class DateTableViewCell: UITableViewCell, NibReusable {

    @IBOutlet weak var lbDate: UILabel!
    var textDate: ((_ date: String?) -> Void)?
    var oldDate: Date?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        let tap = UITapGestureRecognizer(target: self, action: #selector(selectDate))
        lbDate.apply {
            $0.isUserInteractionEnabled = true
            $0.addGestureRecognizer(tap)
        }
    }
    
    @objc func selectDate(tapGesture: UITapGestureRecognizer) {
        ActionSheetDatePicker.show(withTitle: "", datePickerMode: .date, selectedDate: oldDate ?? Date(), minimumDate: nil, maximumDate: Date(), doneBlock: { (picker, value, index) in
            let date = value as? Date
            let dateString = date?.convertDateToString(date: date!, "dd/MM/yyy")
            self.lbDate.text = dateString
            if let block = self.textDate {
                block(dateString)
            }
        }, cancel: { ActionStringCancelBlock in return }, origin: self.superview!.superview)
    }
}
