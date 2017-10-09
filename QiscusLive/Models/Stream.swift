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

open class StreamConfig : NSObject {
    public var AppId    : String = ""
    public var baseURL  : String = "http://rtmp-api.qiscus.com"
    
    public override init(){
        super.init()
    }
}

class Stream: NSObject {
    var title       : String    = ""
    var name        : String    = ""
    var token       : String    = ""
    var streamUrl   : String    = ""
    var watchUrl    : String    = ""
    var playUrl     : String    = ""
    var hlsUrl      : String    = ""
    var tags        : [String]  = [String]()
    
    init(withJSON data: JSON) {
        self.title      = data["title"].stringValue
        self.streamUrl  = data["stream_url"].stringValue
        self.playUrl    = data["play_url"].stringValue
        self.watchUrl   = data["watch_url"].stringValue
        self.name       = data["name"].stringValue
    }
}
