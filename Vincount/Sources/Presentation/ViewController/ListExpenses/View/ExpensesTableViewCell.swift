//
//  ExpensesTableViewCell.swift
//  Vincount
//
//  Created by ChuoiChien on 3/18/19.
//  Copyright © 2019 NguyenVanChien. All rights reserved.
//

import UIKit
import Reusable

class ExpensesTableViewCell: UITableViewCell, NibReusable {

    @IBOutlet weak var lbTotal: UILabel!
    @IBOutlet weak var lbTitle: UILabel!
    @IBOutlet weak var lbDate: UILabel!
    
    var editExpenses: (() -> Void)?
    var deleteExpenses: (() -> Void)?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func bindData(expenses: ExpensesEntity) {
        lbTitle.text = expenses.title
        lbTotal.text = String(expenses.total) + " VND"
        lbDate.text = expenses.date.convertDateToString(date: expenses.date, "dd/MM/yyyy")
    }
    
    @IBAction func invokedDelete(_ sender: Any) {
        if let block = deleteExpenses {
            block()
        }
    }
    
    @IBAction func invokedEdit(_ sender: Any) {
        if let block = editExpenses {
            block()
        }
    }
}
