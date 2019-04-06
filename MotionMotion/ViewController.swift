//
//  ViewController.swift
//  MotionMotion
//
//  Created by Elena Melnikova on 2019-04-04.
//  Copyright © 2019 Elena Melnikova. All rights reserved.
//

import UIKit
import CoreMotion

class ViewController: UIViewController {
    
    @IBOutlet var accelerometerLabel: UILabel!
    

    @IBOutlet weak var sliderX: UISlider!
    @IBOutlet weak var sliderY: UISlider!
    @IBOutlet weak var sliderZ: UISlider!
    
    private let motionManager = CMMotionManager()
    private var updateTimer: Timer!

    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if motionManager.isDeviceMotionAvailable {
            motionManager.deviceMotionUpdateInterval = 0.1
            motionManager.startDeviceMotionUpdates()
            updateTimer =
                Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: #selector(ViewController.updateDisplay), userInfo: nil, repeats: true)
        }
        
        sliderX.maximumValue = 1
        sliderX.minimumValue = -1
        sliderY.maximumValue = 1
        sliderY.minimumValue = -1
        sliderZ.maximumValue = 1
        sliderZ.minimumValue = -1
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        if motionManager.isDeviceMotionAvailable {
            motionManager.stopDeviceMotionUpdates()
            updateTimer.invalidate()
            updateTimer = nil
        }
    }
    
    @objc func updateDisplay() {
        if let motion = motionManager.deviceMotion {
            let gravity = motion.gravity
            
            let acceleratorText =
                String(format: "Gravity:\n-------------------\n" +
                    "Gravity x: %+.2f\n" +
                    "Gravity y: %+.2f\n" +
                    "Gravity z: %+.2f\n",
                       gravity.x,
                       gravity.y,
                       gravity.z)
            
            DispatchQueue.main.async {
                self.accelerometerLabel.text = acceleratorText
                self.sliderX.setValue(Float(gravity.x), animated: true)
                self.sliderY.setValue(Float(gravity.y), animated: true)
                self.sliderZ.setValue(Float(gravity.z), animated: true)
            }
        }
    }
}

