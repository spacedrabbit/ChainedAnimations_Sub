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
    
    private var stackView: UIStackView = {
        let stackView: UIStackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 8.0
        
        return stackView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        
        self.view.addSubview(stackView)
        stackView.addArrangedSubview(titleLabel)
        stackView.addArrangedSubview(bodyLabel)
        
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            stackView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor, constant: 0.0),
            stackView.centerYAnchor.constraint(equalTo: self.view.centerYAnchor, constant: 0.0),
            stackView.widthAnchor.constraint(equalTo: self.view.widthAnchor, constant: -100.0)
            ])
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(didTapLabel(sender:)))
        stackView.addGestureRecognizer(tapGesture)
    }
    
    @objc
    func didTapLabel(sender: Any) {
        
        UIView.animate(withDuration: 0.5, delay: 0.0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.5, options: [], animations: {
            let leftTranslate = CGAffineTransform(translationX: -30, y: 0.0)
            self.titleLabel.transform = leftTranslate
            
        }, completion: { (_) in
        
            UIView.animate(withDuration: 0.5, delay: 0.0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.5, options: [], animations: {
                
                let topTranslate = CGAffineTransform(translationX: self.titleLabel.transform.tx, y: -200.0)
                self.titleLabel.transform = topTranslate
                self.titleLabel.alpha = 0.0
                
            }, completion: nil)

        })
        
        UIView.animate(withDuration: 0.5, delay: 0.4, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.5, options: [], animations: {
            let leftTranslate = CGAffineTransform(translationX: -30, y: 0.0)
            self.bodyLabel.transform = leftTranslate
            
        }, completion: { (_) in
            
            UIView.animate(withDuration: 0.5, delay: 0.0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.5, options: [], animations: {
                
                let topTranslate = CGAffineTransform(translationX: self.bodyLabel.transform.tx, y: -200.0)
                self.bodyLabel.transform = topTranslate
                self.bodyLabel.alpha = 0.0
                
            }, completion: nil)
            
            
            
        })
    }

}

