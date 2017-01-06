//
//  AlamofireExtension.swift
//  Challenge-iOS-Git
//
//  Created by Luan Henrique Damasceno Costa on 03/01/17.
//  Copyright © 2017 Luan Henrique Damasceno Costa. All rights reserved.
//

import UIKit

import UIKit
import Alamofire
import AlamofireImage
import ObjectMapper

// Create manager to controll all requests
var Service: Manager = {
    var serverTrustPolicies: [String: ServerTrustPolicy]
    var url = NSURL(string: Environment.sharedEnvironment.baseURLForJavGitPop)!
    
    serverTrustPolicies = [url.host!: .PerformDefaultEvaluation(validateHost: true)]
    
    let configuration = NSURLSessionConfiguration.defaultSessionConfiguration()
    
    return Manager(
        configuration: configuration,
        serverTrustPolicyManager: ServerTrustPolicyManager(policies: serverTrustPolicies)
    )
}()

// Extensions created to mapper json into objects
extension Alamofire.Request {
    
    private func setUnknowErrorFor(inout serviceResponse: ServiceResponse) {
        serviceResponse.title = "Dialog.Error.UnexpectedError".localize()
        serviceResponse.message = "Dialog.Error.Communication.Server".localize()
    }
    
    // Mapping error
    private func mapError(statusCode: Int, value: AnyObject?, error: NSError?, inout serviceResponse: ServiceResponse) {
        
        // If error is a specifically one, do changes
        switch statusCode {
        case 400...499:
            
            if let v = value {
                let serializedValue = Mapper<ServiceResponse>().map(v)
                
                if serializedValue?.message == nil {
                    setUnknowErrorFor(&serviceResponse)
                } else {
                    serviceResponse = serializedValue!
                }
                
            } else {
                setUnknowErrorFor(&serviceResponse)
            }
            
            break
            
        case 500...599:
            setUnknowErrorFor(&serviceResponse)
            break
            
        default:
            break
        }
    }
    
    // Using Generics to created this function
    func serializedObject<SuccessObjectType: Mappable>(onSuccess success:((SuccessObjectType?, ServiceResponse) -> Void),
                          onFailure failure: ((ServiceResponse) -> Void),
                                    onCompletion: () -> Void) -> Self {
        
        return response { (req, res, data, error) in
            
            var responseRootObject: ServiceResponse = ServiceResponse()
            
            let requestSerializer = Request.JSONResponseSerializer(options: .AllowFragments)
            let result = requestSerializer.serializeResponse(req, res, data, error)
            
            if let statusCode = res?.statusCode {
                
                responseRootObject.request = req
                responseRootObject.response = res
                
                switch statusCode {
                    
                case 200...299:
                    
                    if let value = result.value {
                        let serializedValue = Mapper<SuccessObjectType>().map(value)
                        success(serializedValue, responseRootObject)
                    } else {
                        success(nil, responseRootObject)
                    }
                    
                    break
                    
                default:
                    self.mapError(statusCode, value: result.value, error: result.error, serviceResponse: &responseRootObject)
                    failure(responseRootObject)
                    
                    break
                }
            } else {
                self.setUnknowErrorFor(&responseRootObject)
                failure(responseRootObject)
            }
            
            onCompletion()
        }
    }
    
    func serializedArray<SuccessObjectType: Mappable>(onSuccess success:(([SuccessObjectType]?, ServiceResponse) -> Void),
                         onFailure failure: ((ServiceResponse) -> Void),
                                   onCompletion: () -> Void) -> Self {
        
        return response { (req, res, data, error) in
            
            var responseRootObject: ServiceResponse = ServiceResponse()
            
            let requestSerializer = Request.JSONResponseSerializer(options: .AllowFragments)
            let result = requestSerializer.serializeResponse(req, res, data, error)
            
            if let statusCode = res?.statusCode {
                
                responseRootObject.request = req
                responseRootObject.response = res
                
                switch statusCode {
                    
                case 200...299:
                    
                    if let value = result.value {
                        let serializedValue: [SuccessObjectType]? = Mapper<SuccessObjectType>().mapArray(value)
                        success(serializedValue, responseRootObject)
                    } else {
                        success(nil, responseRootObject)
                    }
                    
                    break
                    
                default:
                    self.mapError(statusCode, value: result.value, error: result.error, serviceResponse: &responseRootObject)
                    failure(responseRootObject)
                    
                    break
                }
            } else {
                self.setUnknowErrorFor(&responseRootObject)
                failure(responseRootObject)
            }
            
            onCompletion()
        }
        
    }
    
    func serializedPhoto(onSuccess success: ((Image?, ServiceResponse) -> Void),
                                   onFailure failure: ((ServiceResponse) -> Void),
                                             onCompletion: () -> Void) -> Self {
        return responseImage { response in
            var responseRootObject: ServiceResponse = ServiceResponse()

            responseRootObject.request = response.request
            responseRootObject.response = response.response
            
            if let image = response.result.value {
                success(image, responseRootObject)
            } else {
                failure(responseRootObject)
            }
            
            onCompletion()
        }

    }
}

