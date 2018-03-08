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
    
    class func createStreaming(title : String, tags : [String:Any], completion: @escaping (Stream?)->()) {
        
        var params  = [String : Any]()
        let tags = try! JSONSerialization.data(withJSONObject: tags, options: [])
        let tagString = String(data: tags, encoding: .ascii)
        params["tags"]  = tagString
        params["title"] = title
        
        print("params: \(params)")
        var headers = [String : String]()
        headers["Authorization"] = "Bearer \(APPID)"
        HttpClientApi.instance().makeAPICall(url: StreamEndpoint.request, params: params, method: HttpMethod.POST, headers: headers, success: { (data, response, error) in
            if error != nil {
                print(error!.localizedDescription)
            } else {
                
                if let data = data {
                    do {
                        let json = try JSONSerialization.jsonObject(with: data, options: .allowFragments) as! [String:Any]
                        let stream = Stream(withDictionary: json)
                        completion(stream)
                    } catch let _ as NSError {
                        completion(nil)
                    }
                }else {
                    completion(nil)
                }
            }
        }) { (data, response, error) in
            completion(nil)
        }
    }
}
