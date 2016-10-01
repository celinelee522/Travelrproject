//
//  TravelContentTableViewCell.swift
//  TravelrProject
//
//  Created by 이우재 on 2016. 8. 20..
//  Copyright © 2016년 LEE. All rights reserved.
//

import UIKit

class TravelContentTableViewCell: UITableViewCell {

    @IBOutlet weak var travelBackground: UIImageView!
    
    @IBOutlet weak var travelTitle: UILabel!
    
    @IBOutlet weak var travelPeriod: UILabel!
    
    
    @IBOutlet weak var cashBudget: UILabel!
    
    @IBOutlet weak var cardBudget: UILabel!
    override func awakeFromNib() {
        
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
