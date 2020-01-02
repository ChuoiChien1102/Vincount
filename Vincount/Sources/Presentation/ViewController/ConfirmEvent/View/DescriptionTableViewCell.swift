//
//  DescriptionTableViewCell.swift
//  Vincount
//
//  Created by ChuoiChien on 3/16/19.
//  Copyright © 2019 NguyenVanChien. All rights reserved.
//

import UIKit
import Reusable

class DescriptionTableViewCell: UITableViewCell, NibReusable {

    @IBOutlet weak var textField: UITextField!
    var textDes: ((_ des: String?) -> Void)?
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        textField.delegate = self
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}

extension DescriptionTableViewCell: UITextFieldDelegate {
    func textFieldDidEndEditing(_ textField: UITextField) {
        if let block = textDes {
            block(textField.text)
        }
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        var updatedTextString : NSString = textField.text! as NSString
        updatedTextString = updatedTextString.replacingCharacters(in: range, with: string) as NSString
        
        return updatedTextString.length > 30  ? false : true
    }
}
