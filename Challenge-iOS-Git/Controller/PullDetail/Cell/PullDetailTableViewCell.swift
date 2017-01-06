//
//  PullDetailTableViewCell.swift
//  Challenge-iOS-Git
//
//  Created by Luan Henrique Damasceno Costa on 03/01/17.
//  Copyright © 2017 Luan Henrique Damasceno Costa. All rights reserved.
//

import UIKit

class PullDetailTableViewCell: UITableViewCell {

    // MARK - Attributes
    @IBOutlet weak var bodyLbl: UILabel!
    @IBOutlet weak var authorNameLbl: UILabel!
    @IBOutlet weak var authorUsernameLbl: UILabel!
    @IBOutlet weak var imgView: UIImageView!
    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var dateLbl: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func setup(pullRequest: PullRequest) {
        let title = (pullRequest.title != nil) ? pullRequest.title! : "Pull titulo"
        let body = (pullRequest.body != nil) ? pullRequest.body! : "Body"
        let username = (pullRequest.owner?.login != nil) ? pullRequest.owner?.login: "Darth Vader"
        let image = (pullRequest.owner?.avatar_url != nil) ? pullRequest.owner?.avatar_url: "perfil-icon"
        
        let date = (pullRequest.createdDate != nil) ? pullRequest.createdDate : "XX/XX/XXXX XX:XX"
        
        self.updateUI(title, body: body, username: username!, image: image!, date: date!, owner: pullRequest.owner!)
    }
    
    func updateUI(title: String, body: String, username: String, image: String, date: String, owner: Owner
        ){
        self.bodyLbl.text = body
        self.authorNameLbl.text = username
        self.authorUsernameLbl.text = username
        self.titleLbl.text = title
        self.dateLbl.text  = date
        
        if image == "perfil-icon" {
            self.imgView.image = UIImage(named: image)
        } else {
            self.loadImage(image,imageView: self.imgView, owner: owner)
        }
    }

}
