//
//  TableViewCell.swift
//  Resto json crud app
//
//  Created by Nando Septian Husni on 21/08/18.
//  Copyright © 2018 IMASTUDIO. All rights reserved.
//

import UIKit

class TableViewCell: UITableViewCell {
    @IBOutlet weak var cellImg: UIImageView!
    
  
    @IBOutlet weak var cellHarga: UILabel!
    @IBOutlet weak var cellName: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
