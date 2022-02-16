//
//  RoundProgressBar.swift
//  dbNoise
//
//  Created by Nick Sagan on 16.02.2022.
//

import UIKit

class RoundProgressBar: UIView {

    var background: UIBezierPath!
    var shapeLayer: CAShapeLayer!
    var progressLayer: CAShapeLayer!
    var progress: Float = 0 {
        willSet(Value) {
            progressLayer.strokeEnd = CGFloat(Value)
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        background = UIBezierPath()
        self.Shape()
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        background = UIBezierPath()
        self.Shape()
    }
    
    func Shape() {
        CreateCircleProgress()
        
        shapeLayer = CAShapeLayer()
        shapeLayer.path = background.cgPath
        shapeLayer.lineWidth = 10
        shapeLayer.fillColor = nil
        shapeLayer.strokeColor = UIColor.lightText.cgColor
        
        progressLayer = CAShapeLayer()
        progressLayer.path = background.cgPath
        progressLayer.lineCap = CAShapeLayerLineCap.round
        progressLayer.lineWidth = 5
        progressLayer.fillColor = nil
        progressLayer.strokeColor = UIColor.red.cgColor
        progressLayer.strokeEnd = 0.0
        
        self.layer.addSublayer(shapeLayer)
        self.layer.addSublayer(progressLayer)
    }

    private func CreateCircleProgress() {
        let x = self.frame.width / 2
        let y = self.frame.height / 2
        let center = CGPoint(x: x, y: y + 7)
        
        background.addArc(withCenter: center, radius: x * 0.8, startAngle: CGFloat(1.7), endAngle: CGFloat(8.0), clockwise: true)
        background.close()
    }
}
