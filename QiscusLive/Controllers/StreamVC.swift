//
//  StreamVC.swift
//  QiscusLive
//
//  Created by asharijuang on 10/5/17.
//

import UIKit
import LFLiveKit

class StreamVC: UIViewController {

    @IBOutlet weak var StreamView: UIView!
    @IBOutlet weak var buttonStream: UIButton!
    
    var session: LFLiveSession {
        get {
            return StreamManager.shared.session
        }
    }
    
    var manager : StreamManager {
        get {
            return StreamManager.shared
        }
    }
    
    public init() {
        super.init(nibName: "StreamVC", bundle: QiscusStream.bundle)
        self.hidesBottomBarWhenPushed = true
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // self.session.delegate = self
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @IBAction func didTapStream(_ sender: Any) {
        self.buttonStream.isSelected = !self.buttonStream.isSelected
        if (buttonStream.isSelected) {
            manager.startLive()
        }else {
            manager.stopLive()
        }
    }
    
}
