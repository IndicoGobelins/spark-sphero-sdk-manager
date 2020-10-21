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
import Vision

class SandboxViewController: UIViewController {
    
    let prev1 = VideoPreviewer()
    @IBOutlet weak var cameraView: UIView!
    let detector: CIDetector = CIDetector(ofType: CIDetectorTypeQRCode, context: nil, options: [CIDetectorAccuracy: CIDetectorAccuracyHigh])!
    @IBOutlet weak var extractedFrameImageView: UIImageView!
    private var _stopTimer: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        DroneCameraManager.shared.onStartDetectQrcode(hookCallback: self.startNumberDetection)
        
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
    
    /**
     Trigger timer to take a photo from CameraView and read QRCODE on this picture
     */
    func startQrcodeDetection() {
        self._stopTimer = false
        Timer.scheduledTimer(withTimeInterval: 0.5, repeats: true) { timer in
            self.prev1?.snapshotPreview { (image) in
                
                if let img = image {
                    
                    let croppedImage = self.cropImage(image: img, height: 500)
                    //display image
                    self.extractedFrameImageView.image = croppedImage
                    let ciimg: CIImage = CIImage(image: croppedImage)!
                    let features = self.detector.features(in: ciimg)
                    
                    for feature in features as! [CIQRCodeFeature] {
                        Debugger.shared.log("Message du QRCODE : \(String(feature.messageString!))")
                        if feature.messageString == DogActivity.QRCODE_MESSAGE_VALID && DogActivity.shared.isQrcodeDetectionActivated {
                            DronePilotManager.shared.stop()
                            DogActivity.shared.isQrcodeDetectionActivated = false
                        }
                    }
                }
                
                if self._stopTimer {
                    timer.invalidate()
                }
            }
        }
    }
    
    func startNumberDetection() {
        self._stopTimer = false
        Timer.scheduledTimer(withTimeInterval: 0.5, repeats: true) { timer in
            self.prev1?.snapshotPreview { (image) in
                
                if let img = image {
                    
                    let croppedImage = self.cropImage(image: img, height: 500)
                    //display image
                    self.extractedFrameImageView.image = croppedImage
                    self._handleTextDetection(image: croppedImage)
                }
                
                if self._stopTimer {
                    timer.invalidate()
                }
            }
        }
    }
    
    
    private func _handleTextDetection(image: UIImage) -> Void {
        guard let cgImage = image.cgImage else { return }
        
        let requestHandler = VNImageRequestHandler(cgImage: cgImage)
        
        let request = VNRecognizeTextRequest(completionHandler: _recognizeTextHandler)

        do {
            // Perform the text-recognition request.
            try requestHandler.perform([request])
        } catch {
            print("Unable to perform the requests: \(error).")
        }
    }
    
    private func _recognizeTextHandler(request: VNRequest, error: Error?) {
        guard let observations =
                request.results as? [VNRecognizedTextObservation] else {
            return
        }
        
        let recognizedStrings = observations.compactMap { observation in
            // Return the string of the top VNRecognizedText instance.
            return observation.topCandidates(1).first?.string
        }
        
        print(recognizedStrings)
        
        if let predicatNumber = recognizedStrings.first {
            if predicatNumber == DogActivity.NUMBER_SUSPECT && DogActivity.shared.isQrcodeDetectionActivated {
                Debugger.shared.log("The suspect 3 is the guilty")
                DronePilotManager.shared.stop()
                DogActivity.shared.isQrcodeDetectionActivated = false
            }
        }
    }
    
    /**
     Stop QRCODE detection
     */
    @IBAction func stopQrcodeDetection(_ sender: Any) {
        self._stopTimer = true
    }
    
    func setupVideoPreview() {
        prev1?.setView(self.cameraView)

        if let _ = DJISDKManager.product(){
            //let video = DJISDKManager.videoFeeder()
            
            DJISDKManager.videoFeeder()?.primaryVideoFeed.add(self, with: nil)
        }
        prev1?.start()
    }
    
    public func cropImage(image: UIImage, height: Double) -> UIImage {
        // Convert UIImage to CGImage
        let cgImage = image.cgImage!
        // Retrieve context and size
        let contextImage: UIImage = UIImage(cgImage: cgImage)
        let contextSize: CGSize = contextImage.size
        var posX: CGFloat = 0.0
        var posY: CGFloat = 0.0
        // Convert size param to CGImage
        let cgWidth: CGFloat = contextSize.width
        let cgHeight: CGFloat = CGFloat(height)
        
        posX = (contextSize.width - cgWidth) / 2
        posY = contextSize.height - cgHeight;
        
        let rect: CGRect = CGRect(x: posX, y: posY, width: cgWidth, height: cgHeight)
        
        // Create bitmap image from context using the rect
        let imageRef: CGImage = cgImage.cropping(to: rect)!
        
        let image: UIImage = UIImage(cgImage: imageRef, scale: image.scale, orientation: image.imageOrientation)
        
        return image
    }
    
    // ====== BRIDGE
    
    @IBAction func bridgeClicked(_ sender: Any) {
        connectBridging()
    }
    
    @IBAction func stopBridgingClick(_ sender: Any) {
        self.disconnectBridging()
    }
    
    /**
     Established USB connection with NodeJS server and registered all events routing
     */
    public func connectBridging() -> Void {
        USBBridge.shared.connect {
            Router.shared
                // Declared routes for DOG ACTIVITY
                .on(activity: Router.Activity.DOG_ACTIVITY, action: Router.Action.STANDUP, executedCallback: DogActivity.shared.standUpAction)
                .on(activity: Router.Activity.DOG_ACTIVITY, action: Router.Action.SITDOWN, executedCallback: DogActivity.shared.sitDownAction)
                .on(activity: Router.Activity.DOG_ACTIVITY, action: Router.Action.SEARCH, executedCallback: DogActivity.shared.searchAction)
            
                // Declared routes for CLUES ACTIVITY
                .on(activity: Router.Activity.CLUES_ACTIVITY, action: Router.Action.FORWARD, executedCallback: CollectCluesActivity.shared.goForwardAction)
                .on(activity: Router.Activity.CLUES_ACTIVITY, action: Router.Action.BACKWARD, executedCallback: CollectCluesActivity.shared.goBackwardAction)
                .on(activity: Router.Activity.CLUES_ACTIVITY, action: Router.Action.LEFT, executedCallback: CollectCluesActivity.shared.goLeftAction)
                .on(activity: Router.Activity.CLUES_ACTIVITY, action: Router.Action.RIGHT, executedCallback: CollectCluesActivity.shared.goRightAction)
                .on(activity: Router.Activity.CLUES_ACTIVITY, action: Router.Action.COLLECT, executedCallback: CollectCluesActivity.shared.collectAction)
                .on(activity: Router.Activity.CLUES_ACTIVITY, action: Router.Action.STOP, executedCallback: CollectCluesActivity.shared.stopAction)
            
                // Declare routes for LABO ACTIVITY
                .on(activity: Router.Activity.LABO_ACTIVITY, action: Router.Action.START, executedCallback: LaboActivity.shared.startActivity)
        }
        
        USBBridge.shared.receivedMessage({ (str) in
            let header = String(str.first!)
            
            if header == CommunicationHelper.header {
                Debugger.shared.log("Nouveau message en provenance du serveur NodeJS -> \(str)")
                let formatedData: CommunicationData = CommunicationHelper().formatDataToStruct(str)
                    
                    // Dispatch incomming data
                Router.shared.dispatch(data: formatedData)
                
            }
        })
    }
    /**
     Close connection with NodeJS server
     */
    public func disconnectBridging() -> Void {
        USBBridge.shared.disconnect()
    }
    
    
    // ====== ACTIONS
    
    @IBAction func standupClicked(_ sender: Any) {
        DogActivity.shared.standUpAction(device: Router.Device.DRONE)
    }
    
    @IBAction func searchClicked(_ sender: Any) {
        DogActivity.shared.searchAction(device: Router.Device.DRONE)
    }
    
    @IBAction func backClicked(_ sender: Any) {
        
    }
    
    @IBAction func sitdownClicked(_ sender: Any) {
        DogActivity.shared.sitDownAction(device: Router.Device.DRONE)
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

