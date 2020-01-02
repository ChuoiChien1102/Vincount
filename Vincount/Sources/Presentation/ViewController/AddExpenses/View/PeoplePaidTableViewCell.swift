//
//  PeoplePaidTableViewCell.swift
//  Vincount
//
//  Created by ChuoiChien on 3/19/19.
//  Copyright © 2019 NguyenVanChien. All rights reserved.
//

import UIKit
import Reusable
import CoreActionSheetPicker

class PeoplePaidTableViewCell: UITableViewCell, NibReusable {

    @IBOutlet weak var lbPeoplePaid: UILabel!
    
    var listPeople: [People]! = []
    var oldSelected: Int = 0
    var indexSelected: ((_ index: Int?) -> Void)?
    var arrPeople = [String]()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        let tap = UITapGestureRecognizer(target: self, action: #selector(selectPeoplePaid))
        lbPeoplePaid.apply {
            $0.isUserInteractionEnabled = true
            $0.addGestureRecognizer(tap)
        }
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func binData() -> Void {
        arrPeople = listPeople.map({ (people: People) -> String in
            return people.name
        })
        if arrPeople.count > 0 {
            lbPeoplePaid.text = arrPeople[oldSelected]
        }
    }
    
    @objc func selectPeoplePaid(tapGesture: UITapGestureRecognizer) {
        
        ActionSheetStringPicker.show(withTitle: "", rows: arrPeople, initialSelection: oldSelected, doneBlock: { (picker, index, value) in
            self.lbPeoplePaid.text = self.arrPeople[index]
            if let block = self.indexSelected {
                block(index)
            }
        }, cancel: { ActionStringCancelBlock in return }, origin: self.superview!.superview)
    }
}
