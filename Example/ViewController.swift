//
//  ViewController.swift
//  Example
//
//  Created by asharijuang on 5/10/17.
//  Copyright © 2017 asharijuang. All rights reserved.
//

import UIKit
import QiscusStreaming

class ViewController: UIViewController {

    @IBOutlet weak var urlTextField: UITextField!
    @IBOutlet weak var buttonStream: UIButton!
    @IBOutlet weak var buttonLive: UIButton!
    var client : QiscusStreaming?
    var watchURL : String = "http://"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        buttonStream.addTarget(self, action: #selector(self.tapSample(_:)), for: UIControlEvents.touchUpInside)
        buttonLive.addTarget(self, action: #selector(self.goStream(_:)), for: UIControlEvents.touchUpInside)
        let config      = StreamConfig()
        config.AppId    = "elR1SnZGVElndUpDV2gxcDBuRFFhcGFmc3l0bFdSbENmOTlLQ1ZDTA=="
        client = QiscusStreaming(withConfig: config)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func tapSample(_ sender: Any) {
        client?.createStream(title: "streaming", tags: ["email" : "juang@qiscus.co"]) { (stream) in
            
            DispatchQueue.main.async {
                if let data = stream {
                    print("stream url : \(String(describing: data.streamUrl))")
                    self.urlTextField.text = data.streamUrl
                    self.watchURL = data.watchUrl
                }
            }
            
        }
    }
    
    func goStream(_ sender: Any) {
        //
        let url = self.urlTextField.text
        client?.buildStream(streamUrl: url!, completionHandler: { (target, error) in
            //
            self.present(target, animated: true, completion: nil)
        })
    }
    
    @IBAction func shareButtonClicked(sender: UIButton) {
        let textToShare = "Hi, watch me in \(watchURL). \nthis video present by Qiscus Live Streaming"
        
        if let myWebsite = NSURL(string: watchURL) {
            let objectsToShare = [textToShare, myWebsite] as [Any]
            let activityVC = UIActivityViewController(activityItems: objectsToShare, applicationActivities: nil)
            
            activityVC.popoverPresentationController?.sourceView = sender
            self.present(activityVC, animated: true, completion: nil)
        }
    }
}

