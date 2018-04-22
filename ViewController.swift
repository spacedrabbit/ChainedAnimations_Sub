//
//  ViewController.swift
//  ChainedAnimations
//
//  Created by Louis Tur on 4/22/18.
//  Copyright © 2018 catthoughts. All rights reserved.
//

import UIKit

// TODO: label styles to match H1, H2, etc.

class ViewController: UIViewController {
    
    private let slidingTextStack = SlidingTextStack(frame: .zero)
    
    private var resetButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .blue
        button.setTitleColor(.white, for: .normal)
        button.setTitle("Reset", for: .normal)
        
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        
        self.view.addSubview(resetButton)
        self.view.addSubview(slidingTextStack)
        
        let tapGesture = UITapGestureRecognizer(target: slidingTextStack, action: #selector(slidingTextStack.resetViews))
        resetButton.addGestureRecognizer(tapGesture)
        
        slidingTextStack.translatesAutoresizingMaskIntoConstraints = false
        resetButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            slidingTextStack.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            slidingTextStack.centerYAnchor.constraint(equalTo: self.view.centerYAnchor),
            slidingTextStack.widthAnchor.constraint(equalTo: self.view.widthAnchor, constant: -100.0),

            resetButton.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            resetButton.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: -20.0),
            resetButton.widthAnchor.constraint(equalToConstant: 80.0),
            resetButton.heightAnchor.constraint(equalToConstant: 28.0)
            ])
        
        
    }
    
    @objc
    func didTapLabel(sender: Any) {
        
//        UIView.animate(withDuration: 0.5, delay: 0.0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.5, options: [], animations: {
//            let leftTranslate = CGAffineTransform(translationX: -30, y: 0.0)
//            self.titleLabel.transform = leftTranslate
//
//        }, completion: { (_) in
//
//            UIView.animate(withDuration: 0.5, delay: 0.0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.5, options: [], animations: {
//
//                let topTranslate = CGAffineTransform(translationX: self.titleLabel.transform.tx, y: -200.0)
//                self.titleLabel.transform = topTranslate
//                self.titleLabel.alpha = 0.0
//
//            }, completion: nil)
//
//        })
//
//        UIView.animate(withDuration: 0.5, delay: 0.4, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.5, options: [], animations: {
//            let leftTranslate = CGAffineTransform(translationX: -30, y: 0.0)
//            self.bodyLabel.transform = leftTranslate
//
//        }, completion: { (_) in
//
//            UIView.animate(withDuration: 0.5, delay: 0.0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.5, options: [], animations: {
//
//                let topTranslate = CGAffineTransform(translationX: self.bodyLabel.transform.tx, y: -200.0)
//                self.bodyLabel.transform = topTranslate
//                self.bodyLabel.alpha = 0.0
//
//            }, completion: nil)
//
//
//        })
    }
}

class SlidingTextStack: UIStackView {

    private var titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Futura", size: 34.0)
        label.numberOfLines = 0
        label.textAlignment = .left
        label.textColor = .black
        label.backgroundColor = .white
        label.text = "Welcome to Chained Animations"
        
        return label
    }()
    
    private var bodyLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Futura", size: 18.0)
        label.numberOfLines = 0
        label.textAlignment = .left
        label.textColor = .black
        label.backgroundColor = .white
        label.text = "This is a simple demo on how to effectively chain animations together to produced a cohesive visual style. It was inspired by the \"let's build that app\" youtube series, and was further extended by myself when the video did not include some of the additional implementation of its demo."
        
        return label
    }()
    
    private var slideUpOutAnimator: UIViewPropertyAnimator = {
        let timingCurveProvider = UISpringTimingParameters(dampingRatio: 0.5, initialVelocity: CGVector(dx: 1.0, dy: 2.0))
        
        let slideAnimator = UIViewPropertyAnimator(duration: 1.0, timingParameters: timingCurveProvider)
        return slideAnimator
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.axis = .vertical
        self.spacing = 8.0
        
        self.addArrangedSubview(titleLabel)
        self.addArrangedSubview(bodyLabel)
        
        let tapGestureInvert = UITapGestureRecognizer(target: self, action: #selector(handleViewTapped(_:)))
        self.addGestureRecognizer(tapGestureInvert)
    }

    required init(coder: NSCoder) {
        fatalError("Not Implemented")
    }
    
    @objc func handleViewTapped(_ sender: UITapGestureRecognizer) {
        invertLabelIfNeeded(at: sender.location(ofTouch: 0, in: self))
        slideLabels()
    }
    
    private func invertLabelIfNeeded(at position: CGPoint) {
        if titleLabel.frame.contains(position) {
            titleLabel.textColor = titleLabel.textColor == .white ? .black : .white
            titleLabel.backgroundColor = titleLabel.backgroundColor == .white ? .black : .white
        } else if bodyLabel.frame.contains(position) {
            bodyLabel.textColor = bodyLabel.textColor == .white ? .black : .white
            bodyLabel.backgroundColor = bodyLabel.backgroundColor == .white ? .black : .white
        }
    }
    
    private func slideLabels() {
        slideUpOutAnimator.addAnimations {
            self.titleLabel.transform = CGAffineTransform(translationX: -30.0, y: 0.0)
        }
        slideUpOutAnimator.addAnimations({
            self.titleLabel.transform = CGAffineTransform(translationX: self.titleLabel.transform.tx, y: -200.0)
            self.titleLabel.alpha = 0.0
        }, delayFactor: 0.25)
        
        slideUpOutAnimator.addAnimations({
            self.bodyLabel.transform = CGAffineTransform(translationX: -30.0, y: 0.0)
        }, delayFactor: 0.35)
        
        slideUpOutAnimator.addAnimations({
            self.bodyLabel.transform = CGAffineTransform(translationX: self.bodyLabel.transform.tx, y: -200.0)
            self.bodyLabel.alpha = 0.0
        }, delayFactor: 0.7)
        
        slideUpOutAnimator.startAnimation()
    }
    
    @objc
    func  resetViews() {
        self.titleLabel.transform = .identity
        self.bodyLabel.transform = .identity
        
        self.titleLabel.alpha = 1.0
        self.bodyLabel.alpha = 1.0
        
        switch slideUpOutAnimator.state {
        case .active, .inactive:
            break
        case .stopped:
            slideUpOutAnimator.stopAnimation(true)
        }
    }
}

