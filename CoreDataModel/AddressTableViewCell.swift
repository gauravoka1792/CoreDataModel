//
//  AddressTableViewCell.swift
//  CoreDataModel
//
//  Created by include tech. on 7/12/18.
//  Copyright © 2018 include tech. All rights reserved.
//

import UIKit

class AddressTableViewCell: UITableViewCell {
    @IBOutlet weak var lblstate: UILabel!
    @IBOutlet weak var lblstreet: UILabel!
    @IBOutlet weak var lblcity: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
