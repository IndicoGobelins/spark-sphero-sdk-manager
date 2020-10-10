//
//  SandboxViewController.swift
//  SparkPerso
//
//  Created by  on 08/10/2020.
//  Copyright © 2020 AlbanPerli. All rights reserved.
//

import UIKit
import DJISDK
import VideoPreviewer
import Foundation

class SandboxViewController: UIViewController {
    
    @IBOutlet weak var logTextView: UITextView!
    
    let prev1 = VideoPreviewer()
    @IBOutlet weak var cameraView: UIView!
    
    let detector: CIDetector = CIDetector(ofType: CIDetectorTypeQRCode, context: nil, options: [CIDetectorAccuracy: CIDetectorAccuracyHigh])!
    @IBOutlet weak var extractedFrameImageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        DroneCameraManager.shared.onStartDetectQrcode(hookCallback: self.startQrcodeDetection)
        
    }
    
    
    // ====== CAMERA
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if let _ = DJISDKManager.product() {
            if let camera = DroneCameraManager.shared.getCamera(){
                camera.delegate = self
                self.setupVideoPreview()
                //self.takePictureWithTimer()
            }
            
            GimbalManager.shared.setup(withDuration: 1.0, defaultPitch: -28.0)
            
        }
    }
    
//    func getCamera() -> DJICamera? {
//        // Check if it's an aircraft
//        if let mySpark = DJISDKManager.product() as? DJIAircraft {
//             return mySpark.camera
//        }
//        return nil
//    }
    
//    func lookUnder(_ sender: Any) {
//        GimbalManager.shared.lookUnder()
//    }
    
    func startQrcodeDetection() {
         Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { timer in
            self.prev1?.snapshotThumnnail { (image) in
                
                if let img = image {
                    
                    //display image
                    self.extractedFrameImageView.image = img
                    let ciimg: CIImage = CIImage(image: img)!
                    let features = self.detector.features(in: ciimg)
                    
                    for feature in features as! [CIQRCodeFeature] {
                        Debugger.shared.log("Message du QRCODE : \(String(feature.messageString!))")
                        if feature.messageString == DogActivity.QRCODE_MESSAGE_VALID && DogActivity.shared.isQrcodeDetectionActivated {
                            DroneSequenciesManager.shared.clearSequencies()
                            DogActivity.shared.isQrcodeDetectionActivated = false
                        }
                    }
                }
            }
        }
    }
    
    func setupVideoPreview() {
        prev1?.setView(self.cameraView)

        if let _ = DJISDKManager.product(){
            //let video = DJISDKManager.videoFeeder()
            
            DJISDKManager.videoFeeder()?.primaryVideoFeed.add(self, with: nil)
        }
        prev1?.start()
    }
    
    
    // ====== BRIDGE
    
    @IBAction func bridgeClicked(_ sender: Any) {
        Debugger.shared.log("sandbooooox")
        
        USBBridge.shared.connect {
            
        }
        
        USBBridge.shared.receivedMessage({ (str) in
            let header = String(str.first!)
            
            if header == CommunicationHelper.header {
                let formatedData: CommunicationData = CommunicationHelper().formatDataToStruct(str)
                // TODO : dispatcher les methodes a éxécuter
            }
        })
    
    }
    
    
    // ====== ACTIONS
    
    @IBAction func standupClicked(_ sender: Any) {
        DogActivity.shared.standUpAction()
    }
    
    @IBAction func searchClicked(_ sender: Any) {
        DogActivity.shared.searchAction()
    }
    
    @IBAction func backClicked(_ sender: Any) {
        DogActivity.shared.backAction()
    }
    
    @IBAction func sitdownClicked(_ sender: Any) {
        DogActivity.shared.sitDownAction()
    }
    
    @IBAction func foundClicked(_ sender: Any) {
        DroneSequenciesManager.shared.clearSequencies()
    }
    
    @IBAction func stopClicked(_ sender: Any) {
        DronePilotManager.shared.stop()
    }
    
    @IBAction func startDetectionClicked(_ sender: Any) {
        DroneCameraManager.shared.startDetectQrcode()
    }
    
    @IBAction func cameraDownClicked(_ sender: Any) {
        DroneCameraManager.shared.lookUnder()
    }
}

extension SandboxViewController:DJIVideoFeedListener {
    func videoFeed(_ videoFeed: DJIVideoFeed, didUpdateVideoData videoData: Data) {
//        print([UInt8](videoData).count)
        videoData.withUnsafeBytes { (bytes:UnsafePointer<UInt8>) in
            prev1?.push(UnsafeMutablePointer(mutating: bytes), length: Int32(videoData.count))
//            prev2?.push(UnsafeMutablePointer(mutating: bytes), length: Int32(videoData.count))
        }
        
    }

}

extension SandboxViewController:DJISDKManagerDelegate {
    func appRegisteredWithError(_ error: Error?) {
        
    }
    
    
}

extension SandboxViewController:DJICameraDelegate {
    
}

