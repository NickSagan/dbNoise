//
//  ResultVC.swift
//  dbNoise
//
//  Created by Nick Sagan on 06.02.2022.
//

import UIKit

class ResultVC: UIViewController {
    
    var result: HearingResult!
    var resultView: ResultView!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = result.date
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .action, target: self, action: #selector(sharePressed))
        
        if traitCollection.userInterfaceStyle == .dark {
            view.backgroundColor = .black
        } else {
            view.backgroundColor = .white
        }
        
        resultView = ResultView()
        view.addSubview(resultView)
        
        resultView.translatesAutoresizingMaskIntoConstraints = false
        
        var leftMargin = (view.frame.size.width - 350) / 2
        if leftMargin < 0 { leftMargin = 0 }
        
        NSLayoutConstraint.activate([
            resultView.topAnchor.constraint(equalTo: view.topAnchor, constant: 100),
            resultView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: leftMargin)
        ])
        
        if result == nil { print("Failed to get HearingResult data") }

        resultView.leftResult.text = result.leftPercent
        resultView.rightResult.text = result.rightPercent
        resultView.hearingIsBetter.text = result.hearingCompare
        
        UIView.animate(withDuration: 0.9, delay: 0.15, usingSpringWithDamping: 1, initialSpringVelocity: 0.1, options: []) {
            self.resultView.knobCircle.transform = CGAffineTransform(translationX: CGFloat(-self.result.xForKnob * 3), y: 0)
        } completion: { _ in
            
        }
        
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
        
        present(ac, animated: true)
    }
}
