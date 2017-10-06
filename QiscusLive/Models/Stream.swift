//
//  Stream.swift
//  QiscusLive
//
//  Created by asharijuang on 10/6/17.
//

import UIKit
import SwiftyJSON

/*
 {
 "status": "success",
 "data": {
 "title": "\"Qiscus\"",
 "name": "orwgE8XexL",
 "token": "5JdwxzMXPe",
 "stream_url": "rtmp://rtmp.qiscus.com/cempaka/orwgE8XexL?token=5JdwxzMXPe",
 "watch_url": "https://rtmp-api.qiscus.com/watch/stream/orwgE8XexL",
 "play_url": "rtmp://rtmp.qiscus.com/cempaka/orwgE8XexL",
 "hls_url": "https://rtmp.qiscus.com/live/cempaka/orwgE8XexL.m3u8",
 "tags": [
 "juang"
 ]
 }
 }
*/

class Stream: NSObject {
    var title       : String    = ""
    var name        : String    = ""
    var token       : String    = ""
    var stream_url  : String    = ""
    var play_url    : String    = ""
    var hls_url     : String    = ""
    var tags        : [String]  = [String]()
    
    init(withJSON : JSON) {
        
    }
}
