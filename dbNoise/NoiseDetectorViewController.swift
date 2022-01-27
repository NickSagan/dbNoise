//
//  NoiseDetectorViewController.swift
//  dbNoise
//
//  Created by Nick Sagan on 27.01.2022.
//

import UIKit

class NoiseDetectorViewController: UIViewController {
    
    @IBOutlet weak var dbResultLabel: UILabel!
    @IBOutlet weak var minLabel: UILabel!
    @IBOutlet weak var avgLabel: UILabel!
    @IBOutlet weak var maxLabel: UILabel!
    @IBOutlet weak var textExplanationLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    
    @IBAction func recordPressed(_ sender: UIButton) {
        print("record")
    }
    
    @IBAction func settingsPressed(_ sender: UIButton) {
        print("settings")
    }
    
    @IBAction func proPressed(_ sender: UIButton) {
        print("pro")
    }
    
    @IBAction func hearingPressed(_ sender: UIButton) {
        print("hearing")
    }
    
    @IBAction func menuPressed(_ sender: UIButton) {
        print("menu")
    }
}
