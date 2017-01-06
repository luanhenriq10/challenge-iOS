//
//  LoadingTableViewCell.swift
//  Challenge-iOS-Git
//
//  Created by Luan Henrique Damasceno Costa on 03/01/17.
//  Copyright © 2017 Luan Henrique Damasceno Costa. All rights reserved.
//

import UIKit

class LoadingTableViewCell: UITableViewCell {

    @IBOutlet weak var loadingIndicator: UIActivityIndicatorView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func setup() {
        self.loadingIndicator.startAnimating()
    }

}
