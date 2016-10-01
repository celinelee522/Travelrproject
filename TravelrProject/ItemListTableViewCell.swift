//
//  ItemListTableViewCell.swift
//  TravelrProject
//
//  Created by Kim Seong Yup on 2016. 8. 23..
//  Copyright © 2016년 LEE. All rights reserved.
//

import UIKit

class ItemListTableViewCell: UITableViewCell {
    @IBOutlet weak var pay: UIImageView!
    @IBOutlet weak var category: UIImageView!
    @IBOutlet weak var price: UILabel!
    @IBOutlet weak var currency: UILabel!
    @IBOutlet weak var detail: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
