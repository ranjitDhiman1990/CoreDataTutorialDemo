//
//  DeviceCell.swift
//  CoreDataTutorialSeries
//
//  Created by Avalgate Team on 13/02/19.
//  Copyright © 2019 iOS Dev. All rights reserved.
//

import UIKit

class DeviceCell: UITableViewCell {

    @IBOutlet var labelDeviceName: UILabel!
    @IBOutlet var labelDeviceCompany: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
