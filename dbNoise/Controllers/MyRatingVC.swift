//
//  MyRatingVC.swift
//  dbNoise
//
//  Created by Nick Sagan on 11.02.2022.
//

import UIKit

class MyRatingVC: UIViewController {
    
    var results: [NoiseResult] = []

    let tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(MyRatingCell.self, forCellReuseIdentifier: "cell")
        return tableView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        results = Shared.instance.noiseResults
        tableView.delegate = self
        tableView.dataSource = self
        subviews()
        constraints()
    }
}

extension MyRatingVC {
    func subviews() {
        view.addSubview(tableView)
    }

    func constraints() {
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.leftAnchor.constraint(equalTo: view.leftAnchor),
            tableView.rightAnchor.constraint(equalTo: view.rightAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
}

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
            // handle delete (by removing the data from your array and updating the tableview)
            results.remove(at: indexPath.row)
            Shared.instance.noiseResults = results
            tableView.reloadData()
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // TODO - New VC for MyRating result view
//        let vc = ResultVC()
//        vc.result = results[indexPath.row]
//        navigationController?.pushViewController(vc, animated: true)
    }
}
