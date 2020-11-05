//
//  AdminViewController.swift
//  SparkPerso
//
//  Created by Théo Champion on 21/10/2020.
//  Copyright © 2020 AlbanPerli. All rights reserved.
//

import UIKit
import DJISDK
import VideoPreviewer
import Foundation
import Vision

class AdminViewController: UIViewController {
    // PROPERTIES
    @IBOutlet weak var connectSpherosButton: UIButton!
    @IBOutlet weak var connectDroneButton: UIButton!
    @IBOutlet weak var bridgeButton: UIButton!
    @IBOutlet weak var headingBarSphero1: UISlider!
    @IBOutlet weak var headingBarSphero2: UISlider!
    @IBOutlet weak var cameraView: UIView!
    @IBOutlet weak var extractedFrameImageView: UIImageView!
    
    /* Route config */
    private var isRouteInit: Bool = false
    private var isSensorRecording: Bool = false
    
    /* Sensor config */
    let initialArrayPatterns = SpheroLedManager.shared.getRandomChoicesPatterns()
    var currentArrayPattern = SpheroLedManager.shared.getRandomChoicesPatterns()
    var nbRandomChoices = 0
    
    /* Camera config */
    let prev1 = VideoPreviewer()
    private var _stopTimer: Bool = false
    
    // LIFECYCLE METHODS
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    // CLICK LISTENERS
    @IBAction func onCLickConnectSpheros(_ sender: Any) {
        SharedToyBox.instance.searchForBoltsNamed(["SB-2020", "SB-8C49"]) { err in
            if err == nil {
                self.connectSpherosButton.backgroundColor = UIColor.systemGreen
            }
        }
    }
    
    @IBAction func onClickConnectDrone(_ sender: Any) {
        self.trySparkConnection()
    }
    
    @IBAction func onClickBridge(_ sender: Any) {
        /* Need to init route one time */
        if !self.isRouteInit {
            self._initRoutes()
        }
        
        USBBridge.shared.connect {
            self.bridgeButton.backgroundColor = UIColor.systemGreen
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
    
    @IBAction func onValueChangeHeadingSphero1(_ sender: UISlider) {
        SpheroPilotManager.shared.setSpheroTarget(spheroNumber: 1)
        SpheroPilotManager.shared.setReferenceHeading(Double(sender.value))
        SpheroPilotManager.shared.setHeading(Double(sender.value))
        SpheroPilotManager.shared.stop()
    }
    
    @IBAction func onValueChangeHeadingSphero2(_ sender: UISlider) {
        SpheroPilotManager.shared.setSpheroTarget(spheroNumber: 2)
        SpheroPilotManager.shared.setReferenceHeading(Double(sender.value))
        SpheroPilotManager.shared.setHeading(Double(sender.value))
        SpheroPilotManager.shared.stop()
    }
    
    @IBAction func onValueChangeSensor(_ sender: UISwitch) {
        if sender.isOn {
            self._startSensor()
        } else {
            self._stopSensor()
        }
    }
    
    @IBAction func onCLickCollectAnimation(_ sender: Any) {
        print("collect animation")
        SpheroLedManager.shared.drawPatternInScreen(givenPattern: "blood")
    }
    
    @IBAction func onClickOneAnimation(_ sender: Any) {
        SpheroLedManager.shared.setSpheroTarget(spheroNumber: 1)
        SpheroLedManager.shared.drawPatternInScreen(givenPattern: "one")
    }
    
    @IBAction func onClickTwoAnimation(_ sender: Any) {
        SpheroLedManager.shared.setSpheroTarget(spheroNumber: 2)
        SpheroLedManager.shared.drawPatternInScreen(givenPattern: "two")
    }
    
    @IBAction func onClickAdnAnimation(_ sender: Any) {
        LaboActivityManager.shared.displaySymbol()
    }
    
    @IBAction func onClickLaunchLaboActivity(_ sender: Any) {
        LaboActivity.shared.startActivity(device: Router.Device.NONE)
    }
    
    @IBAction func onValueChangeCameraDetection(_ sender: UISwitch) {
        if sender.isOn {
            self.startNumberDetection()
        } else {
            self.stopNumberDetection()
        }
    }
    
    @IBAction func onClickStopDog(_ sender: Any) {
        DronePilotManager.shared.stop()
    }
    
    @IBAction func onClickSitDownDog(_ sender: Any) {
        DogActivity.shared.sitDownAction(device: Router.Device.DRONE)
    }
    
    @IBAction func onClickLeftDog(_ sender: Any) {
        DronePilotManager.shared.goLeft()
    }
    
    @IBAction func onClickRightDog(_ sender: Any) {
        DronePilotManager.shared.goRight()
    }
    
    @IBAction func onReleaseRightDog(_ sender: Any) {
        if let mySpark = DJISDKManager.product() as? DJIAircraft {
            mySpark.mobileRemoteController?.rightStickHorizontal = 0
        }
    }
    
    @IBAction func onReleaseLeftDog(_ sender: Any) {
        if let mySpark = DJISDKManager.product() as? DJIAircraft {
            mySpark.mobileRemoteController?.rightStickHorizontal = 0
        }
    }
    
    @IBAction func onValueChangeWorkshopTab(_ sender: UISegmentedControl) {
        print("New change -> \(sender.selectedSegmentIndex)")
        switch sender.selectedSegmentIndex {
        
        case 1:
            USBBridge.shared.send("CLUE_ACTIVITY") { (error: Error?) in
                if error == nil {
                    print("Success send CLUE_ACTIVITY")
                }
            }
            break
        case 2:
            USBBridge.shared.send("LABO_ACTIVITY") { (error: Error?) in
                if error == nil {
                    print("Success send LABO_ACTIVITY")
                }
                
            }
            break
        case 3:
            USBBridge.shared.send("DOG_ACTIVITY") { (error: Error?) in
                if error == nil {
                    print("Success send DOG_ACTIVITY")
                }
            }
            break
        default:
            USBBridge.shared.send("CLUE_ACTIVITY") { (error: Error?) in
                if error == nil {
                    print("Success send CLUE_ACTIVITY")
                }
            }
            break
        }
    }
    
    @IBAction func onClickSwitchOffLed(_ sender: Any) {
        SpheroLedManager.shared.clearLedScreen()
    }
    
    @IBAction func onClickStopLaboActivity(_ sender: Any) {
        LaboActivityManager.shared.stopActivity()
    }
    
    @IBAction func onChangeAimingSphero1(_ sender: UISwitch) {
        SpheroLedManager.shared.setSpheroTarget(spheroNumber: 1)
        if sender.isOn {
            SpheroLedManager.shared.startAiming()
        } else {
            SpheroLedManager.shared.stopAiming()
        }
    }
    
    @IBAction func onChangeAimingSphero2(_ sender: UISwitch) {
        SpheroLedManager.shared.setSpheroTarget(spheroNumber: 2)
        if sender.isOn {
            SpheroLedManager.shared.startAiming()
        } else {
            SpheroLedManager.shared.stopAiming()
        }
    }
    @IBAction func onValueChangeSpeedSpheros(_ sender: UISlider) {
        let newSpeed = sender.value
        SpheroPilotManager.shared.setSpeed(Double(newSpeed))
    }
    
    
    
    // METHODS
    private func _initRoutes() -> Void {
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
    
    private func _configureSensor() -> Void {
        SpheroLedManager.shared.setSpheroTarget(spheroNumber: 3)
        
        SharedToyBox.instance.bolts[2].sensorControl.enable(sensors: SensorMask.init(arrayLiteral: .accelerometer,.gyro))
        SharedToyBox.instance.bolts[2].sensorControl.interval = 1
        SharedToyBox.instance.bolts[2].setStabilization(state: SetStabilization.State.off)
        SharedToyBox.instance.bolts[2].sensorControl.onDataReady = { data in
            DispatchQueue.main.async {
                print("data received")
                
                if self.isSensorRecording {
                    
                    if let acceleration = data.accelerometer?.filteredAcceleration {
                        // Retrieve data from sphero
                        let absSum = abs(acceleration.x!)+abs(acceleration.y!)+abs(acceleration.z!)
                        
                        if absSum > 7 {
                            print("Secousse")
                            self.nbRandomChoices += 1
                            SpheroLedManager.shared.drawPatternInScreen(givenPattern: self._getRandomPattern())
                            self.isSensorRecording = false
                            
                            // Ajouter un delay pour restart tout seul le second choix random ? (en gros faire l'action du bouton randomClicked)
                            DispatchQueue.main.asyncAfter(deadline: .now() + 7.0) { // Change `2.0` to the desired number of seconds.
                               SpheroLedManager.shared.clearLedScreen()
                                
                                if self.nbRandomChoices == self.initialArrayPatterns.count {
                                    self.nbRandomChoices = 0
                                    SpheroLedManager.shared.drawPatternInScreen(givenPattern: "stop")
                                } else {
                                    self.isSensorRecording = true
                                }
                            }
                        }
                    }
                }
            }
        }
    }
    
    private func _startSensor() -> Void {
        self.isSensorRecording = true
        self._configureSensor()
    }
    
    private func _stopSensor() -> Void {
        SharedToyBox.instance.bolts[2].sensorControl.disable()
        self.isSensorRecording = false
    }
    
    private func _getRandomPattern() -> String {
        if self.currentArrayPattern.isEmpty {
            self.currentArrayPattern = self.initialArrayPatterns
        }
        let randomIndex = Int(arc4random_uniform(UInt32(currentArrayPattern.count)))
        let randomString = currentArrayPattern[randomIndex]
        currentArrayPattern.remove(at: randomIndex)
        
        return randomString
    }
    
    @IBAction func stopDog(_ sender: Any) {
        DronePilotManager.shared.stop()
    }
    
    func startNumberDetection() {
        // TODO - Remove the line above on prod
        DogActivity.shared.isQrcodeDetectionActivated = true
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
    
    func stopNumberDetection() {
        self._stopTimer = true
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
                USBBridge.shared.send("SUSPECT_FOUND") { (error: Error?) in
                    if error == nil {
                        print("Success send SUSPECT_FOUND")
                    }
                }
            }
        }
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
        posY = contextSize.height - cgHeight
        
        let rect: CGRect = CGRect(x: posX, y: posY, width: cgWidth, height: cgHeight)
        
        // Create bitmap image from context using the rect
        let imageRef: CGImage = cgImage.cropping(to: rect)!
        
        let image: UIImage = UIImage(cgImage: imageRef, scale: image.scale, orientation: image.imageOrientation)
        
        return image
    }
    
    func setupVideoPreview() {
        self.prev1?.setView(self.cameraView)

        if let _ = DJISDKManager.product(){
            DJISDKManager.videoFeeder()?.primaryVideoFeed.add(self, with: nil)
        }
        prev1?.start()
    }
    
    func activateCameraFlux() -> Void {
        if let _ = DJISDKManager.product() {
            if let camera = DroneCameraManager.shared.getCamera() {
                camera.delegate = self
                self.setupVideoPreview()
            }
            GimbalManager.shared.setup(withDuration: 1.0, defaultPitch: -28.0)
        }
    }
}


// DRONE CONNECTION
extension AdminViewController {
    func trySparkConnection() {
        
        guard let connectedKey = DJIProductKey(param: DJIParamConnection) else {
            NSLog("Error creating the connectedKey")
            return;
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            DJISDKManager.keyManager()?.startListeningForChanges(on: connectedKey, withListener: self, andUpdate: { (oldValue: DJIKeyedValue?, newValue : DJIKeyedValue?) in
                if let newVal = newValue {
                    if newVal.boolValue {
                         DispatchQueue.main.async {
                            self.productConnected()
                        }
                    }
                }
            })
            DJISDKManager.keyManager()?.getValueFor(connectedKey, withCompletion: { (value:DJIKeyedValue?, error:Error?) in
                if let unwrappedValue = value {
                    if unwrappedValue.boolValue {
                        // UI goes on MT.
                        DispatchQueue.main.async {
                            self.productConnected()
                        }
                    }
                }
            })
        }
    }
    
    func productConnected() {
        guard let newProduct = DJISDKManager.product() else {
            NSLog("Product is connected but DJISDKManager.product is nil -> something is wrong")
            return;
        }
     
        if let model = newProduct.model {
            self.connectDroneButton.backgroundColor = UIColor.systemGreen
            Spark.instance.airCraft = DJISDKManager.product() as? DJIAircraft
            self.activateCameraFlux()
        }
        
        //Updates the product's firmware version - COMING SOON
        newProduct.getFirmwarePackageVersion{ (version:String?, error:Error?) -> Void in
            
            if let _ = error {
                self.connectDroneButton.backgroundColor = UIColor.systemRed
            }
            
            print("Firmware package version is: \(version ?? "Unknown")")
        }
    }
    
    func productDisconnected() {
        self.connectDroneButton.backgroundColor = UIColor.systemGray2
    }
}

// DRONE CAMERA
extension AdminViewController:DJIVideoFeedListener {
    func videoFeed(_ videoFeed: DJIVideoFeed, didUpdateVideoData videoData: Data) {
        videoData.withUnsafeBytes { (bytes:UnsafePointer<UInt8>) in
            prev1?.push(UnsafeMutablePointer(mutating: bytes), length: Int32(videoData.count))
        }
        
    }

}

extension AdminViewController:DJISDKManagerDelegate {
    func appRegisteredWithError(_ error: Error?) {
        
    }
    
    
}

extension AdminViewController:DJICameraDelegate {
    
}
