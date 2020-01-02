//
//  EventTableViewCell.swift
//  Vincount
//
//  Created by NguyenVanChien on 3/14/19.
//  Copyright © 2019 NguyenVanChien. All rights reserved.
//

import UIKit
import Reusable

class EventTableViewCell: UITableViewCell, NibReusable {

    @IBOutlet weak var eventName: UILabel!
    @IBOutlet weak var eventDetail: UILabel!
    

    var editEvent: (() -> Void)?
    var deleteEvent: (() -> Void)?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func bindData(event: EventEntity) {
        eventName.text = event.title
        eventDetail.text = event.descript
    }
    
    @IBAction func invokedEdit(_ sender: Any) {
        if let block = editEvent {
            block()
        }
    }
    @IBAction func invokedDelete(_ sender: Any) {
        if let block = deleteEvent {
            block()
        }
    }
}
