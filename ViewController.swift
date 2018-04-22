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
    
    private var slideUpOutAnimator: UIViewPropertyAnimator = {
        let timingCurveProvider = UISpringTimingParameters(dampingRatio: 0.5, initialVelocity: CGVector(dx: 1.0, dy: 2.0))
        
        let slideAnimator = UIViewPropertyAnimator(duration: 1.0, timingParameters: timingCurveProvider)
        return slideAnimator
    }()
    
    private var resetButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .blue
        button.setTitleColor(.white, for: .normal)
        button.setTitle("Reset", for: .normal)
        button.addTarget(self, action: #selector(resetViews), for: .touchUpInside)
        
        return button
    }()
    
    private var stackView: UIStackView = {
        let stackView: UIStackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 8.0
        
        return stackView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        
        self.view.addSubview(resetButton)
//        self.view.addSubview(stackView)
//        stackView.addArrangedSubview(titleLabel)
//        stackView.addArrangedSubview(bodyLabel)
//
//        resetButton.translatesAutoresizingMaskIntoConstraints = false
//        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            stackView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor, constant: 0.0),
            stackView.centerYAnchor.constraint(equalTo: self.view.centerYAnchor, constant: 0.0),
            stackView.widthAnchor.constraint(equalTo: self.view.widthAnchor, constant: -100.0),
            
            resetButton.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            resetButton.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: -20.0),
            resetButton.widthAnchor.constraint(equalToConstant: 80.0),
            resetButton.heightAnchor.constraint(equalToConstant: 28.0)
            ])
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(didTapLabelPropertyAnimator(_:)))
        let invertTextGesture = UITapGestureRecognizer(target: self, action: #selector(invertLabel(_:)))
//        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(didTapLabel(sender:)))
        stackView.addGestureRecognizer(tapGesture)
//        titleLabel.addGestureRecognizer(invertTextGesture)
//        bodyLabel.addGestureRecognizer(invertTextGesture)
    }
    
    @objc
    func invertLabel(_ sender: UITapGestureRecognizer) {
        if let label = sender.view as? UILabel {
            label.textColor = label.textColor == .white ? .black : .white
            label.backgroundColor = label.backgroundColor == .white ? .black : .white
        }
    }
    
    @objc
    func didTapLabelPropertyAnimator(_ sender: Any) {
//        slideUpOutAnimator.addAnimations {
//            self.titleLabel.transform = CGAffineTransform(translationX: -30.0, y: 0.0)
//        }
//        slideUpOutAnimator.addAnimations({
//            self.titleLabel.transform = CGAffineTransform(translationX: self.titleLabel.transform.tx, y: -200.0)
//            self.titleLabel.alpha = 0.0
//        }, delayFactor: 0.25)
//
//        slideUpOutAnimator.addAnimations({
//            self.bodyLabel.transform = CGAffineTransform(translationX: -30.0, y: 0.0)
//        }, delayFactor: 0.35)
//
//        slideUpOutAnimator.addAnimations({
//            self.bodyLabel.transform = CGAffineTransform(translationX: self.bodyLabel.transform.tx, y: -200.0)
//            self.bodyLabel.alpha = 0.0
//        }, delayFactor: 0.7)
//
//        slideUpOutAnimator.startAnimation()
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

    @objc
    func resetViews() {
//        self.titleLabel.transform = .identity
//        self.bodyLabel.transform = .identity
//
//        self.titleLabel.alpha = 1.0
//        self.bodyLabel.alpha = 1.0
//
        switch slideUpOutAnimator.state {
        case .active, .inactive:
            break
        case .stopped:
            slideUpOutAnimator.stopAnimation(true)
        }
    }
}

class SlidingTextStack: UIStackView {

    private var titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Futura", size: 34.0)
        label.numberOfLines = 0
        label.textAlignment = .left
        label.text = "Welcome to Chained Animations"
        
        return label
    }()
    
    private var bodyLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Futura", size: 18.0)
        label.numberOfLines = 0
        label.textAlignment = .left
        label.text = "This is a simple demo on how to effectively chain animations together to produced a cohesive visual style. It was inspired by the \"let's build that app\" youtube series, and was further extended by myself when the video did not include some of the additional implementation of its demo."
        
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.axis = .vertical
        self.spacing = 8.0
        
        self.addArrangedSubview(titleLabel)
        self.addArrangedSubview(bodyLabel)
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(invertLabel(_:)))
        self.addGestureRecognizer(tapGesture)
    }

    required init(coder: NSCoder) {
        fatalError("Not Implemented")
    }
    
    @objc
    private func invertLabel(_ sender: UITapGestureRecognizer) {
        guard sender.numberOfTouches == 1 else { return }
        if let label = hitTest(sender.location(ofTouch: 0, in: self), with: nil) as? UILabel {
            label.textColor = label.textColor == .white ? .black : .white
            label.backgroundColor = label.backgroundColor == .white ? .black : .white
        }
    }
}

