//
//  customTVC.swift
//  Jan-06-DBOperations
//
//  Created by Admin on 10/1/23.
//

import UIKit

class customTVC: UITableViewCell {
    @IBOutlet weak var dateField: UILabel!
    @IBOutlet weak var contentField: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

}
