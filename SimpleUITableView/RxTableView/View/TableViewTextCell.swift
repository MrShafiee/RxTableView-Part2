//
//  TableViewTextCell.swift
//  SimpleUITableView
//
//  Created by Amin Shafiee on 11/4/1397 AP.
//  Copyright © 1397 amin. All rights reserved.
//

import UIKit

class TableViewTextCell: UITableViewCell {

    @IBOutlet weak var celltextView: UITextView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
