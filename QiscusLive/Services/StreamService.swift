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

class StreamEndpoint {
    
    static var request = BASE_URL + "/stream/create"
}

class StreamService: NSObject {
    
    class func StartStreaming(title : String, tags : [String], completion: @escaping (Stream?)->()) {
        let params : [String : Any] = [
            "title" : title,
            "tags"  : tags
        ]
        
        Alamofire.request(StreamEndpoint.request, method: .post, parameters: params, encoding: URLEncoding.default, headers: nil).responseJSON { (response) in
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
