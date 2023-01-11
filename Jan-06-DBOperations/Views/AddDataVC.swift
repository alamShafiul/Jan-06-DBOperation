//
//  AddDataVC.swift
//  Jan-06-DBOperations
//
//  Created by Admin on 10/1/23.
//

import UIKit

class AddDataVC: UIViewController {

    var delegate: SaveProtocol?
    
    @IBOutlet weak var inputField: UITextField!
    
    @IBOutlet weak var saveBtnOutlet: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if(delegate?.isAdd == false) {
            inputField.text = delegate?.storeData
            saveBtnOutlet.setTitle("Update", for: .normal)
        }
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        delegate?.isAdd = true
    }
    
    @IBAction func saveBtnClicked(_ sender: Any) {
        if let input = inputField.text {
            if(delegate?.isAdd == true) {
                delegate?.writeToDB(val: input)
            }
            else {
                delegate?.updateInDB(val: input)
            }
        }
        self.dismiss(animated: true)
    }
    
    @IBAction func cancelBtnClicked(_ sender: Any) {
        delegate?.isAdd = true
        self.dismiss(animated: true)
    }
    
}
