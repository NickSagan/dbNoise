//
//  NoiseDetectorViewController.swift
//  dbNoise
//
//  Created by Nick Sagan on 27.01.2022.
//

import UIKit

class NoiseDetectorViewController: UIViewController {
    
    @IBOutlet weak var proButton: UIButton!
    @IBOutlet weak var recordButton: UIButton!
    @IBOutlet weak var dbResultLabel: UILabel!
    @IBOutlet weak var minLabel: UILabel!
    @IBOutlet weak var avgLabel: UILabel!
    @IBOutlet weak var maxLabel: UILabel!
    @IBOutlet weak var textExplanationLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let btn = UIButton(type: .custom)
        btn.setBackgroundImage(UIImage(named: "settings"), for: .normal)
        btn.frame = CGRect(x: 0, y: 0, width: 37, height: 37)
        btn.addTarget(self, action: #selector(settingsPressed), for: .touchUpInside)
        let item  = UIBarButtonItem(customView: btn)
        self.navigationItem.setRightBarButton(item, animated: true)
        
        textExplanationLabel.layer.masksToBounds = true
        textExplanationLabel.layer.cornerRadius = 5
    }
    
//    override func viewWillAppear(_ animated: Bool) {
//        super.viewWillAppear(animated)
//        navigationController?.setNavigationBarHidden(true, animated: animated)
//    }
//
//    override func viewWillDisappear(_ animated: Bool) {
//        super.viewWillDisappear(animated)
//        navigationController?.setNavigationBarHidden(false, animated: animated)
//    }
    
    
    @IBAction func recordPressed(_ sender: UIButton) {
        print("record")
        sender.setBackgroundImage(UIImage(named: "Rec-2.png"), for: .normal)

    }
    
    @objc func settingsPressed(_ sender: UIButton) {
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
