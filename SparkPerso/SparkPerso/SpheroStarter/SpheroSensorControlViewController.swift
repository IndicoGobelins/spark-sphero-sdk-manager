//
//  SensorControlViewController.swift
//  SparkPerso
//
//  Created by AL on 01/09/2019.
//  Copyright © 2019 AlbanPerli. All rights reserved.
//

import UIKit
import simd
import AVFoundation

class SpheroSensorControlViewController: UIViewController {

    enum Classes:Int {
        case Carre,Triangle,Rond
        
        func neuralNetResponse() -> [Double] {
            switch self {
            case .Carre: return [1.0,0.0,0.0]
            case .Triangle: return [0.0,1.0,0.0]
            case .Rond: return [0.0,0.0,1.0]
            }
        }
        
    }
    
    var neuralNet:FFNN? = nil
    
    @IBOutlet weak var gyroChart: GraphView!
    @IBOutlet weak var acceleroChart: GraphView!
    var movementData = [Classes:[[Double]]]()
    var selectedClass = Classes.Carre
    var isRecording = false
    var isPredicting = false
    
    let initialArrayPatterns = SpheroLedManager.shared.getRandomChoicesPatterns()
    var currentArrayPattern = SpheroLedManager.shared.getRandomChoicesPatterns()
    var nbRandomChoices = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        neuralNet = FFNN(inputs: 1800, hidden: 20, outputs: 3, learningRate: 0.3, momentum: 0.2, weights: nil, activationFunction: .Sigmoid, errorFunction:.crossEntropy(average: false))// .default(average: true))
        
        
        movementData[.Carre] = []
        movementData[.Rond] = []
        movementData[.Triangle] = []
        
        var currentAccData = [Double]()
        var currentGyroData = [Double]()
        
        SharedToyBox.instance.bolt?.sensorControl.enable(sensors: SensorMask.init(arrayLiteral: .accelerometer,.gyro))
        SharedToyBox.instance.bolt?.sensorControl.interval = 1
        SharedToyBox.instance.bolt?.setStabilization(state: SetStabilization.State.off)
        SharedToyBox.instance.bolt?.sensorControl.onDataReady = { data in
            DispatchQueue.main.async {
                
                if self.isRecording || self.isPredicting {
                    
                    if let acceleration = data.accelerometer?.filteredAcceleration {
                        // PAS BIEN!!!
                        currentAccData.append(contentsOf: [acceleration.x!, acceleration.y!, acceleration.z!])
//                        if acceleration.x! >= 0.65 {
//                            print("droite")
//                        }else if acceleration.x! <= -0.65 {
//                            print("gauche")
//                        }
                        let absSum = abs(acceleration.x!)+abs(acceleration.y!)+abs(acceleration.z!)
                        
                        if absSum > 14 {
                            print("Secousse")
                            self.nbRandomChoices += 1
                            SpheroLedManager.shared.drawPatternInScreen(givenPattern: self.getRandomPattern())
                            self.isRecording = false
                            
                            // Ajouter un delay pour restart tout seul le second choix random ? (en gros faire l'action du bouton randomClicked)
                            
                            DispatchQueue.main.asyncAfter(deadline: .now() + 3.0) { // Change `2.0` to the desired number of seconds.
                               SpheroLedManager.shared.clearLedScreen()
                                
                                if self.nbRandomChoices == self.initialArrayPatterns.count {
                                    self.nbRandomChoices = 0
                                    SpheroLedManager.shared.drawPatternInScreen(givenPattern: "stop")
                                } else {
                                    self.isRecording = true
                                }
                               
                            }
                        }
                        
                        let dataToDisplay: double3 = [acceleration.x!, acceleration.y!, acceleration.z!]
                        self.acceleroChart.add(dataToDisplay)
                    }
                    
                    if let gyro = data.gyro?.rotationRate {
                        // TOUJOURS PAS BIEN!!!
                        let rotationRate: double3 = [Double(gyro.x!)/2000.0, Double(gyro.y!)/2000.0, Double(gyro.z!)/2000.0]
                        currentGyroData.append(contentsOf: [Double(gyro.x!), Double(gyro.y!), Double(gyro.z!)])
                        self.gyroChart.add(rotationRate)
                    }
                }
            }
        }
        
    }
    
    @IBAction func trainButtonClicked(_ sender: Any) {
        trainNetwork()
    }
    
    @IBAction func nextRandomClicked(_ sender: Any) {
        SpheroLedManager.shared.clearLedScreen()
        self.isRecording = true
    }
    
    func getRandomPattern() -> String {
        if self.currentArrayPattern.isEmpty {
            self.currentArrayPattern = self.initialArrayPatterns
        }
        let randomIndex = Int(arc4random_uniform(UInt32(currentArrayPattern.count)))
        let randomString = currentArrayPattern[randomIndex]
        currentArrayPattern.remove(at: randomIndex)
        return randomString
    }
    
    @IBAction func predictButtonClicked(_ sender: Any) {
        self.isPredicting = true
    }
    
    func trainNetwork() {
        
        // --------------------------------------
        // TRAINING
        // --------------------------------------
        for i in 0...20 {
            print(i)
            if let selectedClass = movementData.randomElement(),
                let input = selectedClass.value.randomElement(){
                let expectedResponse = selectedClass.key.neuralNetResponse()
                
                let floatInput = input.map{ Float($0) }
                let floatRes = expectedResponse.map{ Float($0) }
                
                try! neuralNet?.update(inputs: floatInput) // -> [0.23,0.67,0.99]
                try! neuralNet?.backpropagate(answer: floatRes)
                
            }
        }
        
        // --------------------------------------
        // VALIDATION
        // --------------------------------------
        for k in movementData.keys {
            print("Inference for \(k)")
            let values = movementData[k]!
            for v in values {
                let floatInput = v.map{ Float($0) }
                let prediction = try! neuralNet?.update(inputs:floatInput)
                print(prediction!)
            }
        }
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(true)
        SharedToyBox.instance.bolt?.sensorControl.disable()
    }

    @IBAction func segementedControlChanged(_ sender: UISegmentedControl) {
        let index = sender.selectedSegmentIndex
        if let s  = Classes(rawValue: index){
            selectedClass = s
        }
    }
    
    @IBAction func startButtonClicked(_ sender: Any) {
        isRecording = true
    }
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
