//
//  SpheroLedsViewController.swift
//  SparkPerso
//
//  Created by AL on 01/09/2019.
//  Copyright © 2019 AlbanPerli. All rights reserved.
//

import UIKit

class SpheroLedsViewController: UIViewController {

    @IBOutlet weak var textToDisplayTextField: UITextField!
    
    @IBOutlet weak var xGreen: UITextField!
    @IBOutlet weak var yGreen: UITextField!
    
    @IBOutlet weak var yRed: UITextField!
    @IBOutlet weak var xRed: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        SharedToyBox.instance.bolt?.setStabilization(state: SetStabilization.State.off)

    }

    @IBAction func sendTextClicked(_ sender: Any) {
        self.view.endEditing(true)
        if let displayTxt = textToDisplayTextField.text {
            SharedToyBox.instance.bolts.map{
                $0.scrollMatrix(text: displayTxt, color: .blue, speed: 8, loop: .noLoop)
            }
        }
        
    }
    
    @IBAction func greenClicked(_ sender: Any) {
        self.view.endEditing(true)
        if let xTxt = xGreen.text,
            let x = Int(xTxt),
            let yTxt = yGreen.text,
            let y = Int(yTxt)
        {
            SharedToyBox.instance.bolts.map{ $0.drawMatrix(pixel: Pixel(x: x, y: y), color: .green) }
        }
    }
    
    @IBAction func redClicked(_ sender: Any) {
        self.view.endEditing(true)
        if let xTxt = xRed.text,
            let x = Int(xTxt),
            let yTxt = yRed.text,
            let y = Int(yTxt)
        {
            SharedToyBox.instance.bolts.map{ $0.drawMatrix(pixel: Pixel(x: x, y: y), color: .red) }
        }
    }
 

    @IBAction func heartClicked(_ sender: Any) {
        SpheroLedManager.shared.drawPatternInScreen(givenPattern: "heart")
    }
    @IBAction func starClicked(_ sender: Any) {
        SpheroLedManager.shared.drawPatternInScreen(givenPattern: "star")
    }
    
    @IBAction func clearClicked(_ sender: Any) {
        SpheroLedManager.shared.clearLedScreen()
    }
}

