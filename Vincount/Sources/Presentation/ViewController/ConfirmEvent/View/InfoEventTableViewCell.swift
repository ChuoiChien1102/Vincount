//
//  InfoEventTableViewCell.swift
//  Vincount
//
//  Created by NguyenVanChien on 3/15/19.
//  Copyright © 2019 NguyenVanChien. All rights reserved.
//

import UIKit
import Reusable

class InfoEventTableViewCell: UITableViewCell, NibReusable {

    @IBOutlet weak var textField: UITextField!
    var textTitle: ((_ title: String?) -> Void)?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        textField.delegate = self
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
}

extension InfoEventTableViewCell: UITextFieldDelegate {
    func textFieldDidEndEditing(_ textField: UITextField) {
        if let block = textTitle {
            block(textField.text)
        }
    }

    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        var updatedTextString : NSString = textField.text! as NSString
        updatedTextString = updatedTextString.replacingCharacters(in: range, with: string) as NSString
        
        return updatedTextString.length > 30  ? false : true
    }
}
