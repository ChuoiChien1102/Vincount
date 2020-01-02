//
//  HistoryMemberTableViewCell.swift
//  Vincount
//
//  Created by ChuoiChien on 3/19/19.
//  Copyright © 2019 NguyenVanChien. All rights reserved.
//

import UIKit
import Reusable

class HistoryMemberTableViewCell: UITableViewCell, NibReusable {

    @IBOutlet weak var lbName: UILabel!
    @IBOutlet weak var lbBalance: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func bindData(people: PeopleEntity) {
        lbName.text = people.name
        lbBalance.text = String(people.balance) + " VND"
    }
}
