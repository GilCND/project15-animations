//
//  ViewController.swift
//  Project15-Animations
//
//  Created by Felipe Gil on 2021-08-09.
//

import UIKit

class ViewController: UIViewController {
    var imageView: UIImageView?
    var animationCounter: AnimationType = .increaseSize
    
    enum AnimationType: Int {
        case increaseSize, decreaseSize, moveDown, moveCenter, rotate, changeColor, resetColor
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        imageView = UIImageView(image: UIImage(named: "penguin"))
        guard let imageView = imageView else { return }
        
        imageView.center = CGPoint(x: view.frame.width / 2, y: view.frame.height / 2 )
        view.addSubview(imageView)
        
    }
    
    private func applyAnimation(animation: AnimationType){
        
        switch animation {
        case .increaseSize:
            self.imageView?.transform = CGAffineTransform(scaleX: 1.5, y: 1.5)
            break
        case .decreaseSize:
            self.imageView?.transform = .identity
            break
        case .moveDown:
            self.imageView?.transform = CGAffineTransform(translationX: self.view.frame.width / -3, y: self.view.frame.height / 3)
            break
        case .moveCenter:
            self.imageView?.transform = .identity
            break
        case .rotate:
            self.imageView?.transform = CGAffineTransform(rotationAngle: .pi)
            break
        case .changeColor:
            self.imageView?.alpha = 0.1
            self.imageView?.backgroundColor = .green
            break
        case .resetColor:
            self.imageView?.alpha = 1
            self.imageView?.backgroundColor = .clear
            break
        }
    }
    
    @IBAction func tapped(_ sender: UIButton) {
        sender.isHidden = true
        UIView.animate(withDuration: 1, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 5, options: [], animations: {
            self.applyAnimation(animation: self.animationCounter)
        }, completion: { finished in
            sender.isHidden = false
        })
        if animationCounter < .resetColor {
            animationCounter += 1
        } else {
            animationCounter = .increaseSize
        }
    }
}
extension ViewController.AnimationType {
    static func += (lhs: inout ViewController.AnimationType, rhs: Int) {
        guard let newAnimationType = ViewController.AnimationType(rawValue: lhs.rawValue + rhs) else { return }
        lhs = newAnimationType
    }
    
    static func < (lhs: ViewController.AnimationType, rhs: ViewController.AnimationType) -> Bool {        lhs.rawValue < rhs.rawValue
    }
    
    
}
