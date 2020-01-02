//
//  HistoryDetailTableViewCell.swift
//  Vincount
//
//  Created by ChuoiChien on 3/19/19.
//  Copyright © 2019 NguyenVanChien. All rights reserved.
//

import UIKit
import Reusable

class HistoryDetailTableViewCell: UITableViewCell, NibReusable {

    @IBOutlet weak var lbName: UILabel!
    @IBOutlet weak var lbExpenseName: UILabel!
    @IBOutlet weak var lbDate: UILabel!
    @IBOutlet weak var lbPaid: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func bindData(expenseOfPeople: ExpenseOfPeopleEntity) {
        lbName.text = expenseOfPeople.namePeople
        lbDate.text = expenseOfPeople.date.convertDateToString(date: expenseOfPeople.date, "dd/MM/yyyy")
        lbExpenseName.text = expenseOfPeople.nameExpenses
        lbPaid.text = String(expenseOfPeople.total) + " VND"
    }
}
