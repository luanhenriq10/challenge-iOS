//
//  PhotoService.swift
//  Challenge-iOS-Git
//
//  Created by Luan Henrique Damasceno Costa on 03/01/17.
//  Copyright © 2017 Luan Henrique Damasceno Costa. All rights reserved.
//

import UIKit
import AlamofireImage

class PhotoService: NSObject {

    class func getPhotoFromString(image: String,
                            onSuccess: (image: Image?, response: ServiceResponse) -> Void,
                            onFailure: (ServiceResponse) -> Void,
                            onCompletion: () -> Void) {
        
        Service.request(.GET, image).serializedPhoto(onSuccess: { (image: Image?, res) in
            onSuccess(image: image, response: res)
            }, onFailure: { (err) in
                onFailure(err)
            }) { 
                onCompletion()
        }
    }
}
