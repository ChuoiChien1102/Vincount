//
//  MemberPaidTableViewCell.swift
//  Vincount
//
//  Created by ChuoiChien on 3/17/19.
//  Copyright © 2019 NguyenVanChien. All rights reserved.
//

import UIKit
import Reusable

class MemberPaidTableViewCell: UITableViewCell, NibReusable {

    @IBOutlet weak var btnCheck: UIButton!
    @IBOutlet weak var lbName: UILabel!
    @IBOutlet weak var lbPaid: UILabel!
    
    var check: ((_ isCheck: Bool) -> Void)?
    var isSelect = true
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func bindData(people: People) {
        isSelect = people.isSelected
        if people.isSelected {
            btnCheck.setImage(UIImage(named: "icon_check"), for: .normal)
        } else {
            btnCheck.setImage(UIImage(named: "icon_uncheck"), for: .normal)
        }
        lbName.text = people.name
        lbPaid.text = String(people.paid) + " VND"
    }
    
    @IBAction func invokedCheck(_ sender: Any) {
        if let block = check {
            block(!isSelect)
        }
    }
}
