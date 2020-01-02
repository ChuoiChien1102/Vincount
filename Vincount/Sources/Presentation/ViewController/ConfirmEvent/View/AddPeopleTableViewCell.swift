//
//  AddPeopleTableViewCell.swift
//  Vincount
//
//  Created by NguyenVanChien on 3/15/19.
//  Copyright © 2019 NguyenVanChien. All rights reserved.
//

import UIKit
import Reusable

class AddPeopleTableViewCell: UITableViewCell, NibReusable {

    @IBOutlet weak var textFieldAdd: UITextField!
    var namePeople: ((_ name: String?) -> Void)?
    var addPeople: ((_ name: String?) -> Void)?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        textFieldAdd.delegate = self
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBAction func invokedAdd(_ sender: Any) {
        if let block = addPeople {
            block(textFieldAdd.text)
        }
    }
}

extension AddPeopleTableViewCell: UITextFieldDelegate {
    func textFieldDidEndEditing(_ textField: UITextField) {
        if let block = namePeople {
            block(textFieldAdd.text)
        }
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        var updatedTextString : NSString = textField.text! as NSString
        updatedTextString = updatedTextString.replacingCharacters(in: range, with: string) as NSString
        
        return updatedTextString.length > 30  ? false : true
    }
}
