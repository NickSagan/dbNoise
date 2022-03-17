//
//  SettingsVC.swift
//  dbNoise
//
//  Created by Nick Sagan on 15.03.2022.
//

import UIKit
import StoreKit
import MessageUI

class SettingsVC: UIViewController {

    let header: UILabel = {
        let label = UILabel()
        label.text = "Settings"
        label.textAlignment = .left
        label.font = UIFont(name: "SFProDisplay-Bold", size: 32)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    var tableView: UITableView!
    
    let settings = [
        // Section 1
        [["rate_app.png", "Rate App"], ["feedback.png", "Feedback"]],
        // Section 2
        [["subscription.png", "Subscription"], ["subscription.png", "Restore purchases"]],
        // Section 3
        [["policy.png", "Terms"], ["policy.png", "Politics"], ["policy.png", "Responsibility"]]
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView = {
            let tableView = UITableView(frame: view.frame, style: .grouped)
            tableView.translatesAutoresizingMaskIntoConstraints = false
            tableView.register(SettingsCell.self, forCellReuseIdentifier: "cell")
            return tableView
        }()

        tableView.delegate = self
        tableView.dataSource = self

        if traitCollection.userInterfaceStyle == .dark {
            view.backgroundColor = .black
            header.textColor = .white
        } else {
            view.backgroundColor = .white
            header.textColor = .black
        }
        
        subviews()
        constraints()
    }
    
    func rateApp() {
        if #available(iOS 10.3, *) {
            SKStoreReviewController.requestReview()

        } else if let url = URL(string: "itms-apps://itunes.apple.com/app/" + "appId") {
            if #available(iOS 10, *) {
                UIApplication.shared.open(url, options: [:], completionHandler: nil)

            } else {
                UIApplication.shared.openURL(url)
            }
        }
    }
}

//MARK: - Subviews & Constraints

extension SettingsVC {
    
    func subviews() {
        view.addSubview(header)
        view.addSubview(tableView)
    }
    
    func constraints() {
        NSLayoutConstraint.activate([
            header.topAnchor.constraint(equalTo: view.layoutMarginsGuide.topAnchor),
            header.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 15),
            header.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            header.heightAnchor.constraint(equalToConstant: 41),
            
            tableView.topAnchor.constraint(equalTo: header.bottomAnchor),
            tableView.leftAnchor.constraint(equalTo: view.leftAnchor),
            tableView.rightAnchor.constraint(equalTo: view.rightAnchor),
            tableView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.8)
        ])
    }
}

//MARK: - TableView

extension SettingsVC: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        3
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        switch section {
        case 0: return "FOR US"
        case 1: return "PURCHASES"
        case 2: return "POLICY"
        default: return ""
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0: return 2
        case 1: return 2
        case 2: return 3
        default: return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! SettingsCell
        cell.icon.image = UIImage(named: settings[indexPath.section][indexPath.row][0])
        cell.titleLabel.text = settings[indexPath.section][indexPath.row][1]
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if indexPath.section == 0 {
            if indexPath.row == 0 {
                rateApp()
            }
        } else if indexPath.section == 2 {
            if let url = URL(string: "https://pages.flycricket.io/dbnoise-0/terms.html") {
                UIApplication.shared.open(url, options: [:])
            }
        }
//        let vc = NoiseResultVC()
//        vc.result = results[indexPath.row]
//        navigationController?.pushViewController(vc, animated: true)
    }
}
