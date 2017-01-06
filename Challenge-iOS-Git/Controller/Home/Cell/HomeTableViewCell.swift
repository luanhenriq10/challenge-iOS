//
//  HomeTableViewCell.swift
//  Challenge-iOS-Git
//
//  Created by Luan Henrique Damasceno Costa on 02/01/17.
//  Copyright © 2017 Luan Henrique Damasceno Costa. All rights reserved.
//

import UIKit

class HomeTableViewCell: UITableViewCell {

    // MARK - Attributes
    @IBOutlet weak var nameLbl: UILabel!
    @IBOutlet weak var descriptionLbl: UILabel!
    @IBOutlet weak var authorNameLbl: UILabel!
    @IBOutlet weak var authorImgView: UIImageView!
    @IBOutlet weak var authorUsernameLbl: UILabel!
    @IBOutlet weak var forksQtdLbl: UILabel!
    @IBOutlet weak var starsQtdLbl: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    // MARK - Function to setup cell
    func setup(repository: Repository) {
        self.setupImageView()
        
        let repoName = (repository.name != nil) ? repository.name : "Nome do repositório"
        let description = (repository.description != nil) ? repository.description : "Lorem ipslum dolor"
        let starsQtd = (repository.starsQtd != nil) ? repository.starsQtd: 0
        let forksQtd  = (repository.forksQtd != nil) ? repository.forksQtd: 0
        let nickname = (repository.owner?.login != nil) ? repository.owner?.login: "Darth Vader"
        
        let  image = (repository.owner?.avatar_url != nil) ? (repository.owner?.avatar_url)! + ".png": "perfil-icon"
        
        self.updateUI(repoName!, description: description!, nickname: nickname!, image: image, forksQtd: forksQtd!, starsQtd: starsQtd!, owner: repository.owner!)
    }
    
    func updateUI(repoName: String, description: String, nickname: String, image: String, forksQtd: Int, starsQtd: Int, owner: Owner) {
        self.nameLbl.text = repoName
        self.descriptionLbl.text = description
        self.authorNameLbl.text  = nickname
        self.authorUsernameLbl.text = nickname
        self.forksQtdLbl.text    = String(forksQtd)
        self.starsQtdLbl.text   = String(starsQtd)
        
        if image == "perfil-icon" {
            self.authorImgView.image = UIImage(named: image)
        } else {
            self.loadImage(image, imageView: self.authorImgView, owner: owner)
        }
    }

    func setupImageView() {
        self.authorImgView.layer.cornerRadius = self.authorImgView.frame.size.height / 2
    }

}
