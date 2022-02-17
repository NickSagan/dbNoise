//
//  NoiseResultVC.swift
//  dbNoise
//
//  Created by Nick Sagan on 17.02.2022.
//

import UIKit

class NoiseResultVC: UIViewController {
    
    var result: NoiseResult!
    
    let header: MinAvgMaxView = {
        let view = MinAvgMaxView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    var peak: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = 12
        view.backgroundColor = UIColor.systemGray4
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        print(result!)
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .action, target: self, action: #selector(sharePressed))
        
        title = "Result"
        if traitCollection.userInterfaceStyle == .dark {
            view.backgroundColor = .black
        } else {
            view.backgroundColor = .white
        }
        
        subviews()
        constraints()

    }
    
    @objc func sharePressed() {
        // render UIView into UIImage
        // https://www.hackingwithswift.com/example-code/media/how-to-render-a-uiview-to-a-uiimage
        
        let renderer = UIGraphicsImageRenderer(size: view.bounds.size)
        let image = renderer.image { ctx in
            view.drawHierarchy(in: view.bounds, afterScreenUpdates: true)
        }
        
        let items: [UIImage] = [image]
        
        // let items: [Any] = ["Look at my hearing test result:", image, URL(string: "https://dbnoiseapp.com")!]
        
        // https://www.hackingwithswift.com/articles/118/uiactivityviewcontroller-by-example
        let ac = UIActivityViewController(activityItems: items, applicationActivities: nil)
        ac.excludedActivityTypes = [.airDrop, .addToReadingList, .openInIBooks, .saveToCameraRoll]
        present(ac, animated: true)
    }
    
}
extension NoiseResultVC {
    
    func subviews() {
        view.addSubview(header)
        view.addSubview(peak)
//        view.addSubview(audioRecord)
    }
    
    func constraints() {
        NSLayoutConstraint.activate([
            peak.topAnchor.constraint(equalTo: view.topAnchor),
            peak.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            peak.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            peak.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.3),
            
            header.topAnchor.constraint(equalTo: peak.bottomAnchor, constant: 20),
            header.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            header.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            header.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.30)
        ])
    }
}
