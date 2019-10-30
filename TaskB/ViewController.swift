//
//  ViewController.swift
//  TaskB
//
//  Created by Sina on 10/30/19.
//  Copyright © 2019 Sina. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var circularView: UIView!
    
    
    @IBOutlet weak var tapLbl: UILabel!
    @IBOutlet weak var horizontalConstraint: NSLayoutConstraint!
    @IBOutlet weak var verticalConstraint: NSLayoutConstraint!
    @IBOutlet weak var randomNumberLbl: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        CATransaction.begin()
        let layer = CAShapeLayer()
        layer.strokeColor = UIColor.black.cgColor
        layer.lineWidth = 3.0
        layer.fillColor = UIColor.clear.cgColor
        
        let path = UIBezierPath(arcCenter: CGPoint(x: 100, y: 100), radius: CGFloat(100), startAngle: CGFloat(0), endAngle: CGFloat(Double.pi * 2), clockwise: true)
        layer.path = path.cgPath
        
        let animation = CABasicAnimation(keyPath: "strokeEnd")
        animation.fromValue = 0.0
        animation.toValue = 1.0
        animation.duration = 1
        
        layer.add(animation, forKey: "myStroke")
        CATransaction.commit()
        circularView.layer.addSublayer(layer)
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(circleTap))
        circularView.isUserInteractionEnabled = true
        circularView.addGestureRecognizer(tapGesture)
        self.tapLbl.alpha = 0
        UIView.animate(withDuration: 1.5, delay: 0.5, usingSpringWithDamping: 0.7, initialSpringVelocity: 1, options: UIView.AnimationOptions.curveEaseInOut, animations: {
            self.tapLbl.alpha = 1
            self.view.layoutIfNeeded()
        }) { (_) in
            
        }
    }
    
    @objc func circleTap(){
        self.tapLbl.alpha = 0
        self.randomNumberLbl.alpha = 0
        self.verticalConstraint.constant = 90
        self.horizontalConstraint.constant = 0
        self.view.layoutIfNeeded()
        randomNumberLbl.text = "\(Int.random(in: 1..<50))"
        view.bringSubviewToFront(randomNumberLbl)
        randomNumberLbl.transform = CGAffineTransform(scaleX: 0.3, y: 0.3)
        UIView.animate(withDuration: 1, delay: 0, usingSpringWithDamping: 0.4, initialSpringVelocity: 1, options: [UIView.AnimationOptions.curveEaseIn], animations: {
            self.verticalConstraint.constant = 0
            self.randomNumberLbl.alpha = 1
            self.view.layoutIfNeeded()
        }) { (_) in
            UIView.animate(withDuration: 0.3, delay: 0.1, options: UIView.AnimationOptions.curveEaseOut, animations: {
                self.randomNumberLbl.transform = CGAffineTransform(scaleX: 1, y: 1)
                self.view.layoutIfNeeded()
            }) { (_) in
                UIView.animate(withDuration: 1.6, delay: 0.1, usingSpringWithDamping: 0.5, initialSpringVelocity: 1, options: UIView.AnimationOptions.curveEaseInOut, animations: {
                    self.randomNumberLbl.transform = CGAffineTransform(scaleX: 0.3, y: 0.3)
                }) { (_) in
                    
                }
                UIView.animate(withDuration: 1, delay: 0.35, usingSpringWithDamping: 0.9, initialSpringVelocity: 1, options: UIView.AnimationOptions.curveEaseInOut, animations: {
                    self.verticalConstraint.constant = -(self.view.frame.height/2-80)
                    self.horizontalConstraint.constant = -(self.view.frame.width/2-40)
                    self.randomNumberLbl.transform = CGAffineTransform(scaleX: 0.4, y: 0.4)
                    self.view.layoutIfNeeded()
                }) { (_) in
                    UIView.animate(withDuration: 0.4, delay: 0.2, options: UIView.AnimationOptions.curveEaseOut, animations: {
                        self.verticalConstraint.constant -= 100
                        self.view.layoutIfNeeded()
                    }) { (_) in
                        self.tapLbl.alpha = 1
                    }
                    
                }
            }
            
        }
        
    }
    
}

