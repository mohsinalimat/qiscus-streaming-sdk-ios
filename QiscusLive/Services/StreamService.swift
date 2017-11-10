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
    
    class func createStreaming(title : String, tags : String, completion: @escaping (Stream?)->()) {
        
        var params  = [String : Any]()
        params["tags"]  = tags
        params["title"] = title
        
        var headers = [String : String]()
        headers["Authorization"] = "Bearer \(APPID)"
        HttpClientApi.instance().makeAPICall(url: StreamEndpoint.request, params: params, method: HttpMethod.POST, headers: headers, success: { (data, response, error) in
            if error != nil {
                print(error!.localizedDescription)
            } else {
                if let data = data {
                    if let stringData = String(data: data, encoding: String.Encoding.utf8) {
                        print(stringData) //JSONSerialization
                    }
                }
            }
        }) { (data, response, error) in
            //
        }
//
//        let headers : HTTPHeaders = [
//            "Authorization" : "Bearer \(APPID)"
//        ]
//
//        let params = [
//            "iostags" : "example : hello",
//            "title" : "title",
//        ]
//        print("params \(params), \(headers)")
//
//        let request = Alamofire.request(StreamEndpoint.request, method: .post, parameters: params, headers: headers).responseJSON { (response)->Void in
//            print(response)
//            if response.result.value != nil {
//                if (response.response?.statusCode)! >= 300 {
//                    completion(nil)
//                } else {
//                    let json    = JSON(response.result.value ?? "")
//                    let result  = json["data"]
//                    let data    = Stream(withJSON: result)
//                    completion(data)
//                }
//            } else {
//                completion(nil)
//            }
//        }
//        print("request \(request)")
    }
}
