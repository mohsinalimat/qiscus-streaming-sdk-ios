//
//  ViewController.swift
//  Example
//
//  Created by asharijuang on 5/10/17.
//  Copyright © 2017 asharijuang. All rights reserved.
//

import UIKit
import QiscusLive

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @IBAction func tapSample(_ sender: Any) {
        let setup = StreamConfig.init(AppId: "Qiscus")
        let client = QiscusLive()
        client.getStreamVC { (target, error) in
            self.navigationController?.present(target, animated: true, completion: nil) 
        }
    }
}

