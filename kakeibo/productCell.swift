//
//  productCell.swift
//  kakeibo
//
//  Created by 手嶋慧太 on 2019/06/28.
//  Copyright © 2019 手嶋慧太. All rights reserved.
//

import UIKit

class productCell: UITableViewCell {
    @IBOutlet weak var productLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var categoryLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
