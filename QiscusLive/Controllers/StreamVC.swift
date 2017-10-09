//
//  StreamVC.swift
//  QiscusLive
//
//  Created by asharijuang on 10/5/17.
//

import UIKit
import LFLiveKit

class StreamVC: UIViewController, LFLiveSessionDelegate {

    public init() {
        super.init(nibName: "StreamVC", bundle: QiscusStreaming.bundle)
        self.hidesBottomBarWhenPushed = true
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Getters and Setters
    
    var streamUrl : String = ""
    
    //  Resolusi default audio 368 * 640: 44,1 iphone6 di atas 48 layar vertikal dual-channel
    var session: LFLiveSession = {
        let audioConfiguration = LFLiveAudioConfiguration.defaultConfiguration(for: LFLiveAudioQuality.high)
        let videoConfiguration = LFLiveVideoConfiguration.defaultConfiguration(for: LFLiveVideoQuality.low3)
        let session = LFLiveSession(audioConfiguration: audioConfiguration, videoConfiguration: videoConfiguration)
        return session!
    }()
    
    // View
    var containerView: UIView = {
        let containerView = UIView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height))
        containerView.backgroundColor = UIColor.clear
        containerView.autoresizingMask = [UIViewAutoresizing.flexibleHeight, UIViewAutoresizing.flexibleHeight]
        return containerView
    }()
    
    // Status
    var stateLabel: UILabel = {
        let stateLabel = UILabel(frame: CGRect(x: 20, y: 20, width: 80, height: 40))
        stateLabel.text = "Offline"
        stateLabel.textColor = UIColor.white
        stateLabel.font = UIFont.systemFont(ofSize: 14)
        return stateLabel
    }()
    
    // Close
    var closeButton: UIButton = {
        let closeButton = UIButton(frame: CGRect(x: UIScreen.main.bounds.width - 10 - 44, y: 20, width: 44, height: 44))
        closeButton.setImage(UIImage(named: "close_preview", in: QiscusStreaming.bundle, compatibleWith: nil), for: UIControlState())
        return closeButton
    }()
    
    // Camera
    var cameraButton: UIButton = {
        let cameraButton = UIButton(frame: CGRect(x: UIScreen.main.bounds.width - 54 * 2, y: 20, width: 44, height: 44))
        cameraButton.setImage(UIImage(named: "camera_preview", in: QiscusStreaming.bundle, compatibleWith: nil), for: UIControlState())
        return cameraButton
    }()
    
    // Camera
    var beautyButton: UIButton = {
        let beautyButton = UIButton(frame: CGRect(x: UIScreen.main.bounds.width - 54 * 3, y: 20, width: 44, height: 44))
        beautyButton.setImage(UIImage(named: "camra_beauty"), for: UIControlState.selected)
        beautyButton.setImage(UIImage(named: "camra_beauty_close"), for: UIControlState())
        return beautyButton
    }()
    
    // Start Live Streaming Button
    var startLiveButton: UIButton = {
        let startLiveButton = UIButton(frame: CGRect(x: 30, y: UIScreen.main.bounds.height - 50, width: UIScreen.main.bounds.width - 10 - 44, height: 44))
        startLiveButton.layer.cornerRadius = 22
        startLiveButton.setTitleColor(UIColor.black, for:UIControlState())
        startLiveButton.setTitle("Live", for: UIControlState())
        startLiveButton.titleLabel!.font = UIFont.systemFont(ofSize: 14)
        startLiveButton.backgroundColor = UIColor(colorLiteralRed: 50, green: 32, blue: 245, alpha: 1)
        return startLiveButton
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        session.delegate = self
        session.preView = self.view
        
        self.requestAccessForVideo()
        self.requestAccessForAudio()
        self.view.backgroundColor = UIColor.clear
        self.view.addSubview(containerView)
        containerView.addSubview(stateLabel)
        containerView.addSubview(closeButton)
        containerView.addSubview(beautyButton)
        containerView.addSubview(cameraButton)
        containerView.addSubview(startLiveButton)
        
        cameraButton.addTarget(self, action: #selector(didTappedCameraButton(_:)), for:.touchUpInside)
        beautyButton.addTarget(self, action: #selector(didTappedBeautyButton(_:)), for: .touchUpInside)
        startLiveButton.addTarget(self, action: #selector(didTappedStartLiveButton(_:)), for: .touchUpInside)
        closeButton.addTarget(self, action: #selector(didTappedCloseButton(_:)), for: .touchUpInside)
    }
    
    override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK: AccessAuth
    
    func requestAccessForVideo() -> Void {
        let status = AVCaptureDevice.authorizationStatus(forMediaType: AVMediaTypeVideo);
        switch status  {
        case AVAuthorizationStatus.notDetermined:
            AVCaptureDevice.requestAccess(forMediaType: AVMediaTypeVideo, completionHandler: { (granted) in
                if(granted){
                    DispatchQueue.main.async {
                        self.session.running = true
                    }
                }
            })
            break;
        case AVAuthorizationStatus.authorized:
            session.running = true;
            break;
        case AVAuthorizationStatus.denied: break
        case AVAuthorizationStatus.restricted:break;
        default:
            break;
        }
    }
    
    func requestAccessForAudio() -> Void {
        let status = AVCaptureDevice.authorizationStatus(forMediaType:AVMediaTypeAudio)
        switch status  {
        case AVAuthorizationStatus.notDetermined:
            AVCaptureDevice.requestAccess(forMediaType: AVMediaTypeAudio, completionHandler: { (granted) in
                
            })
            break;
        case AVAuthorizationStatus.authorized:
            break;
        case AVAuthorizationStatus.denied: break
        case AVAuthorizationStatus.restricted:break;
        default:
            break;
        }
    }
    
    //MARK: - Callbacks
    
    func liveSession(_ session: LFLiveSession?, debugInfo: LFLiveDebug?) {
    print("debugInfo: \(debugInfo?.currentBandwidth)")
    }
    
    func liveSession(_ session: LFLiveSession?, errorCode: LFLiveSocketErrorCode) {
    print("errorCode: \(errorCode.rawValue)")
    }
    
    func liveSession(_ session: LFLiveSession?, liveStateDidChange state: LFLiveState) {
        print("liveStateDidChange: \(state.rawValue)")
        switch state {
        case LFLiveState.ready:
            stateLabel.text = "Offline"
            break;
        case LFLiveState.pending:
            stateLabel.text = "Pending"
            break;
        case LFLiveState.start:
            stateLabel.text = "Live"
            break;
        case LFLiveState.error:
            stateLabel.text = "Error"
            break;
        case LFLiveState.stop:
            stateLabel.text = "Offline"
            break;
        default:
            break;
        }
    }
    
    //MARK: - Events
    
    func didTappedStartLiveButton(_ button: UIButton) -> Void {
        startLiveButton.isSelected = !startLiveButton.isSelected;
        if (startLiveButton.isSelected) {
            startLiveButton.setTitle("Stop", for: UIControlState())
            let stream = LFLiveStreamInfo()
            stream.url = streamUrl
            session.startLive(stream)
        } else {
            startLiveButton.setTitle("Live", for: UIControlState())
            session.stopLive()
        }
    }
    
    func didTappedBeautyButton(_ button: UIButton) -> Void {
    session.beautyFace = !session.beautyFace;
    beautyButton.isSelected = !session.beautyFace
    }
    
    func didTappedCameraButton(_ button: UIButton) -> Void {
    let devicePositon = session.captureDevicePosition;
    session.captureDevicePosition = (devicePositon == AVCaptureDevicePosition.back) ? AVCaptureDevicePosition.front : AVCaptureDevicePosition.back;
    }
    
    func didTappedCloseButton(_ button: UIButton) -> Void  {
        self.dismiss(animated: true, completion: nil)
    }
}
