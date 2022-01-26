//
//  ViewController.swift
//  dbNoise
//
//  Created by Nick Sagan on 26.01.2022.
//

import UIKit
import SwiftyOnboard

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let swiftyOnboard = SwiftyOnboard(frame: view.frame)
        view.addSubview(swiftyOnboard)
        swiftyOnboard.dataSource = self
    }


}

//MARK: - SwiftyOnboard protocol

extension ViewController: SwiftyOnboardDataSource {

    func swiftyOnboardNumberOfPages(_ swiftyOnboard: SwiftyOnboard) -> Int {
            return 3
        }

    func swiftyOnboardPageForIndex(_ swiftyOnboard: SwiftyOnboard, index: Int) -> SwiftyOnboardPage? {
            let page = SwiftyOnboardPage()
            return page
        }
}

