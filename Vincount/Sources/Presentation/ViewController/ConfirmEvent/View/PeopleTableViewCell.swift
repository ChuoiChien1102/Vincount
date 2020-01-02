//
//  PeopleTableViewCell.swift
//  Vincount
//
//  Created by ChuoiChien on 3/16/19.
//  Copyright © 2019 NguyenVanChien. All rights reserved.
//

import UIKit
import Reusable

class PeopleTableViewCell: UITableViewCell, NibReusable {

    @IBOutlet weak var lbName: UILabel!
    var deletePeople: (() -> Void)?
    
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
    }
    
    @IBAction func invokedDelete(_ sender: Any) {
        if let block = deletePeople {
            block()
        }
    }
}
