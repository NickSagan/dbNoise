//
//  SettingsVC.swift
//  dbNoise
//
//  Created by Nick Sagan on 15.03.2022.
//

import UIKit

class SettingsVC: UIViewController {

    let header: UILabel = {
        let label = UILabel()
        label.text = "Settings"
        label.textAlignment = .left
        label.font = UIFont(name: "SFProDisplay-Bold", size: 32)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(MyRatingCell.self, forCellReuseIdentifier: "cell")
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

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
}

//MARK: - Subviews & Constraints

extension SettingsVC {
    
    func subviews() {
        view.addSubview(header)
        view.addSubview(tableView)
    }
    
    func constraints() {
        NSLayoutConstraint.activate([
            header.topAnchor.constraint(equalTo: view.topAnchor),
            header.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            header.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            header.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.30),
            
            tableView.topAnchor.constraint(equalTo: header.bottomAnchor),
            tableView.leftAnchor.constraint(equalTo: view.leftAnchor),
            tableView.rightAnchor.constraint(equalTo: view.rightAnchor),
        ])
    }
}

//MARK: - TableView

extension SettingsVC: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! MyRatingCell
        //cell.result = results[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        let vc = NoiseResultVC()
//        vc.result = results[indexPath.row]
//        navigationController?.pushViewController(vc, animated: true)
    }
}
