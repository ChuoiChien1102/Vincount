//
//  DeleteViewController.swift
//  Vincount
//
//  Created by ChuoiChien on 3/16/19.
//  Copyright © 2019 NguyenVanChien. All rights reserved.
//

import UIKit

class DeleteViewController: UIViewController {

    @IBOutlet weak var viewContainer: UIView!
    
    @IBOutlet weak var cancleButton: UIButton!
    @IBOutlet weak var okButton: UIButton!
    var okHandler: (() -> Void)?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewContainer.layer.cornerRadius =  10
        cancleButton.layer.cornerRadius = 5
        okButton.layer.cornerRadius = 5
    }

    @IBAction func invokedCancle(_ sender: Any) {
        self.dismiss(animated: false, completion: nil)
    }
    
    @IBAction func invokedOk(_ sender: Any) {
        if let block = okHandler {
            block()
        }
    }
}
