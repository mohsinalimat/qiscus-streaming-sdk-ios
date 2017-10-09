//
//  StreamService.swift
//  QiscusLive
//
//  Created by asharijuang on 10/6/17.
//

import UIKit
import Alamofire
import SwiftyJSON

var BASE_URL : String {
    get {
        return StreamManager.shared.config.baseURL
    }
}

var APPID : String {
    get {
        return StreamManager.shared.config.AppId
    }
}

class StreamEndpoint {
    
    static var request = BASE_URL + "/stream/create"
}

class StreamService: NSObject {
    
    class func createStreaming(title : String, tags : [String], completion: @escaping (Stream?)->()) {
        
        let headers : HTTPHeaders = [
            "Authorization" : "Bearer \(APPID)"
        ]
        
        let parameter : [String : Any] = [
            "title" : title
        ]
        print("params \(parameter), \(headers)")
        
        Alamofire.request(StreamEndpoint.request, method: .post, parameters: parameter, headers: headers).responseJSON { (response)->Void in
            print(response)
            if response.result.value != nil {
                if (response.response?.statusCode)! >= 300 {
                    completion(nil)
                } else {
                    let json    = JSON(response.result.value ?? "")
                    let result  = json["data"]
                    let data    = Stream(withJSON: result)
                    completion(data)
                }
            } else {
                completion(nil)
            }
        }
    }
}
