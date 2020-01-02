//
//  UIViewController+.swift
//  Vincount
//
//  Created by ChuoiChien on 3/14/19.
//  Copyright © 2019 NguyenVanChien. All rights reserved.
//

import Foundation
import UIKit

extension UIViewController {
    
    // dissmiss keyboard when tap outside input (textField, textView...)
    func dissmissKeyboardWhenTapOutside() -> Void {
        let tapRecognizer = UITapGestureRecognizer.init(target: self, action: #selector(handleSingleTap(_:)))
        tapRecognizer.cancelsTouchesInView = false
        self.view.addGestureRecognizer(tapRecognizer)
        self.navigationController?.view.addGestureRecognizer(tapRecognizer)
    }

    @objc func handleSingleTap(_ sender: UITapGestureRecognizer) -> Void {
        self.view.endEditing(true)
    }
}
