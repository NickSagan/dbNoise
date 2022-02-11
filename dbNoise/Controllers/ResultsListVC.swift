//
//  ResultsListVC.swift
//  dbNoise
//
//  Created by Nick Sagan on 05.02.2022.
//

import UIKit

class ResultsListVC: UIViewController {
    
    var results: [HearingResult] = []

    let tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(ResultListCell.self, forCellReuseIdentifier: "cell")
        return tableView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        results = Shared.instance.hearingResults
        tableView.delegate = self
        tableView.dataSource = self
        subviews()
        constraints()
    }
}

extension ResultsListVC {
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

extension ResultsListVC: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return results.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! ResultListCell
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
            Shared.instance.hearingResults = results
            tableView.reloadData()
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = ResultVC()
        vc.result = results[indexPath.row]
        navigationController?.pushViewController(vc, animated: true)
    }
}
