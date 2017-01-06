//
//  UITableViewCellExtension.swift
//  Challenge-iOS-Git
//
//  Created by Luan Henrique Damasceno Costa on 04/01/17.
//  Copyright © 2017 Luan Henrique Damasceno Costa. All rights reserved.
//

import UIKit
import AlamofireImage

let imageCache = AutoPurgingImageCache()

extension UITableViewCell {
    func loadImage(image: String, imageView: UIImageView, owner: Owner) {
        if let cachedAvatar = imageCache.imageWithIdentifier(owner.login!) {
            imageView.image = cachedAvatar
            return
        } else {
            PhotoService.getPhotoFromString(image, onSuccess: { (image, response) in
                if image != nil {
                    imageView.image = image
                    imageCache.addImage(imageView.image!, withIdentifier: owner.login!)
                } else {
                    print(response)
                }
                }, onFailure: { (err) in
                    print(err)
            }) {
            }
        }
    }
}
