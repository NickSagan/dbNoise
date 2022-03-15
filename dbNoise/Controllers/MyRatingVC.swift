//
//  MyRatingVC.swift
//  dbNoise
//
//  Created by Nick Sagan on 11.02.2022.
//

import UIKit

class MyRatingVC: UIViewController {
    
    var results: [NoiseResult]!
    
    let header: MinAvgMaxView = {
        let view = MinAvgMaxView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(MyRatingCell.self, forCellReuseIdentifier: "cell")
        return tableView
    }()
    
    let clearButton: UIButton = {
        let btn = UIButton(type: .system)
        btn.translatesAutoresizingMaskIntoConstraints = false
        if #available(iOS 15.0, *) {
            btn.configuration = .filled()
        } else {
            // Fallback on earlier versions
        }
        btn.setTitle("Clear measurement history", for: .normal)
        btn.titleLabel?.font = UIFont.boldSystemFont(ofSize: 17)
        return btn
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        results = Shared.instance.noiseResults

        tableView.delegate = self
        tableView.dataSource = self
        
        title = "My rating"
        if traitCollection.userInterfaceStyle == .dark {
            view.backgroundColor = .black
        } else {
            view.backgroundColor = .white
        }
        
        let btn = UIButton(type: .custom)
        btn.setBackgroundImage(UIImage(named: "settings"), for: .normal)
        btn.frame = CGRect(x: 0, y: 0, width: 35, height: 35)
        btn.addTarget(self, action: #selector(settingsPressed), for: .touchUpInside)
        let item  = UIBarButtonItem(customView: btn)
        self.navigationItem.setRightBarButton(item, animated: true)
        
        subviews()
        constraints()
        setHeader()
        clearButton.addTarget(self, action: #selector(clearPressed), for: .touchUpInside)
    }
    
    func setHeader() {
        var min = Int.max
        var avg = 0
        var avgSum = 0
        var avgCounter = 0
        var max = Int.min
        
        for result in results {
            
            avgCounter += 1
            avgSum += result.avg
            
            if result.min < min {
                min = result.min
            }
            
            if result.max > max {
                max = result.max
            }
        }
        
        avg = avgSum / avgCounter
        
        header.minValueLabel.text = "\(min) dB"
        header.avgValueLabel.text = "\(avg) dB"
        header.maxValueLabel.text = "\(max) dB"
    }
    
    @objc func clearPressed() {
        results.removeAll()
        Shared.instance.noiseResults = results
        tableView.reloadData()
    }
    
    @objc func settingsPressed() {
        let vc = SettingsVC()
        navigationController?.pushViewController(vc, animated: true)
    }
}

//MARK: - Subviews & Constraints

extension MyRatingVC {
    
    func subviews() {
        view.addSubview(header)
        view.addSubview(tableView)
        view.addSubview(clearButton)
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
            
            clearButton.topAnchor.constraint(equalTo: tableView.bottomAnchor, constant: 20),
            clearButton.heightAnchor.constraint(equalToConstant: 50),
            clearButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            clearButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            clearButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -30)
        ])
    }
}

//MARK: - TableView

extension MyRatingVC: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return results.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! MyRatingCell
        cell.result = results[indexPath.row]
        return cell
    }
    
    // https://stackoverflow.com/questions/24103069/add-swipe-to-delete-uitableviewcell
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if (editingStyle == .delete) {
            results.remove(at: indexPath.row)
            Shared.instance.noiseResults = results
            tableView.reloadData()
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
                let vc = NoiseResultVC()
                vc.result = results[indexPath.row]
                navigationController?.pushViewController(vc, animated: true)
    }
}
