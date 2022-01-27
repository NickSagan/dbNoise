//
//  NoiseDetectorViewController.swift
//  dbNoise
//
//  Created by Nick Sagan on 27.01.2022.
//

import UIKit

class NoiseDetectorViewController: UIViewController {
    
    @IBOutlet weak var recordButton: UIButton!
    @IBOutlet weak var dbResultLabel: UILabel!
    @IBOutlet weak var minLabel: UILabel!
    @IBOutlet weak var avgLabel: UILabel!
    @IBOutlet weak var maxLabel: UILabel!
    @IBOutlet weak var textExplanationLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    
    
    @IBAction func recordPressed(_ sender: UIButton) {
        print("record")
        sender.setBackgroundImage(UIImage(named: "Rec-2.png"), for: .normal)

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
