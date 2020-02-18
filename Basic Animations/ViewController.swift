//
//  ViewController.swift
//  Basic Animations
//
//  Created by Joseph Rogers on 11/14/19.
//  Copyright © 2019 Joseph Rogers. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    //MARK: - Properties
    
    var label: UILabel!
    
    //MARK: - View Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        configureLabel()
        configureButtons()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        label.center = view.center
    }
    
    
    private func configureLabel() {
        //all views are all rectangles and positioned from upper left corner of view sized with width and height
        label = UILabel(frame: CGRect(x: 0, y: 0, width: 200, height: 200))
        label.translatesAutoresizingMaskIntoConstraints = false
        //constrain the width to the heighth. to ensure to make sure it stays a square even in the case of animation
        label.widthAnchor.constraint(equalTo: label.heightAnchor).isActive = true
        view.addSubview(label)
        label.text = "🧠"
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 96)
        
        label.layer.borderWidth = 2
        label.layer.cornerRadius = 12
    }
    
    private func configureButtons() {
        let rotateButton = UIButton(type: .system)
        rotateButton.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(rotateButton)
        rotateButton.setTitle("Rotate", for: .normal)
        rotateButton.addTarget(self, action: #selector(rotateButtonTapped), for: .touchUpInside)
        
        let springButton = UIButton(type: .system)
        springButton.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(springButton)
        springButton.setTitle("Spring", for: .normal)
        springButton.addTarget(self, action: #selector(springButtonTapped), for: .touchUpInside)
        
        let keyButton = UIButton(type: .system)
        keyButton.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(keyButton)
        keyButton.setTitle("Key", for: .normal)
        keyButton.addTarget(self, action: #selector(keyButtonTapped), for: .touchUpInside)
        
        let squashButton = UIButton(type: .system)
        squashButton.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(squashButton)
        squashButton.setTitle("Squash", for: .normal)
        squashButton.addTarget(self, action: #selector(squashButtonTapped), for: .touchUpInside)
        
        let anticipationButton = UIButton(type: .system)
        anticipationButton.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(anticipationButton)
        anticipationButton.setTitle("Anticipation", for: .normal)
        anticipationButton.addTarget(self, action: #selector(anticipationButtonTapped), for: .touchUpInside)
        
        
        //MARK: - StackView
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(stackView)
        
        stackView.axis = .horizontal
        stackView.distribution = .equalSpacing
        stackView.addArrangedSubview(rotateButton)
        stackView.addArrangedSubview(springButton)
        stackView.addArrangedSubview(keyButton)
        stackView.addArrangedSubview(squashButton)
        stackView.addArrangedSubview(anticipationButton)
        
        
        NSLayoutConstraint.activate([
            stackView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            stackView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20),
            stackView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20)
        ])
    }
    
    //MARK: Actions
    //actions for the buttons
    
    @objc func springButtonTapped() {
        label.center = view.center
        
        label.transform = CGAffineTransform(scaleX: 0.0001, y: 0.0001)
        UIView.animate(withDuration: 3.0, delay: 0, usingSpringWithDamping: 0.95, initialSpringVelocity: 0, options: [], animations: {
            self.label.transform = .identity
        }, completion: nil)
    }
    
    @objc func rotateButtonTapped() {
        
        //beginning animations
        label.center = view.center
        
        UIView.animate(withDuration: 2.0, animations: {
            self.label.transform = CGAffineTransform(rotationAngle: CGFloat.pi/4)
            //run a set of instructions once the animation is completed below
            //it runs ignore the bool
        }) { (_) in
            UIView.animate(withDuration: 2.0) {
                //returns it back to its original identity/animation
                self.label.transform = .identity
            }
        }
        
    }
    
    @objc func keyButtonTapped() {
        
        label.center = view.center
        
        UIView.animateKeyframes(withDuration: 5.0, delay: 0, options: [], animations: {
            //keyframes
            UIView.addKeyframe(withRelativeStartTime: 0, relativeDuration: 0.25) {
                self.label.transform = CGAffineTransform(rotationAngle: CGFloat.pi/4)
            }
            UIView.addKeyframe(withRelativeStartTime: 0.25, relativeDuration: 0.25) {
                self.label.transform = .identity
            }
            UIView.addKeyframe(withRelativeStartTime: 0.5, relativeDuration: 0.25) {
                self.label.center = CGPoint(x: self.view.center.x, y: self.view.center.y - 50)
            }
            UIView.addKeyframe(withRelativeStartTime: 0.75, relativeDuration: 0.25) {
                self.label.center = self.view.center
            }
        }, completion: nil)
    }
    
    @objc func squashButtonTapped() {
        
        label.center = CGPoint(x: view.center.x, y: -label.bounds.size.height)
        
        let animationBlock = {
            UIView.addKeyframe(withRelativeStartTime: 0, relativeDuration: 0.4) {
                self.label.center = self.view.center
            }
            UIView.addKeyframe(withRelativeStartTime: 0.3, relativeDuration: 0.2) {
                self.label.transform = CGAffineTransform(scaleX: 1.7, y: 0.6)
            }
            UIView.addKeyframe(withRelativeStartTime: 0.5, relativeDuration: 0.2) {
                self.label.transform = CGAffineTransform(scaleX: 0.6, y: 1.7)
            }
            UIView.addKeyframe(withRelativeStartTime: 0.7, relativeDuration: 0.15) {
                self.label.transform = CGAffineTransform(scaleX: 1.11, y: 0.9)
            }
            UIView.addKeyframe(withRelativeStartTime: 0.85, relativeDuration: 0.15) {
                self.label.transform = .identity
            }
        }
        UIView.animateKeyframes(withDuration: 2.9, delay: 0, options: [], animations: animationBlock, completion: nil)
        
        //this is dont with the completion handler handling ALL of the keyframes 👆 this is doing it at the bottom and giving a closure at the end to finish the animation 👇
        
//        UIView.animateKeyframes(withDuration: 1.5, delay: 0, options: [], animations: {
//            //keyframes
//
//            UIView.addKeyframe(withRelativeStartTime: 0, relativeDuration: 0.4) {
//                self.label.center = self.view.center
//            }
//            UIView.addKeyframe(withRelativeStartTime: 0.3, relativeDuration: 0.2) {
//                self.label.transform = CGAffineTransform(scaleX: 1.7, y: 0.6)
//            }
//            UIView.addKeyframe(withRelativeStartTime: 0.5, relativeDuration: 0.2) {
//                self.label.transform = CGAffineTransform(scaleX: 0.6, y: 1.7)
//            }
//            UIView.addKeyframe(withRelativeStartTime: 0.7, relativeDuration: 0.15) {
//                self.label.transform = CGAffineTransform(scaleX: 1.11, y: 0.9)
//            }
//            UIView.addKeyframe(withRelativeStartTime: 0.85, relativeDuration: 0.15) {
//                self.label.transform = .identity
//            }
//        }, completion: nil)
    }
    
    @objc func anticipationButtonTapped() {
        let anticipationBlock = {
            //keyframes
            UIView.addKeyframe(withRelativeStartTime: 0, relativeDuration: 0.1) {
                self.label.transform = CGAffineTransform(rotationAngle: CGFloat.pi/16.0)
            }
            
            UIView.addKeyframe(withRelativeStartTime: 0.1, relativeDuration: 0.2) {
                //negative 1 reverses the sign on a call. this goes counter clockwise instead of clockwise like it would have
                self.label.transform = CGAffineTransform(rotationAngle: -1 * CGFloat.pi/16.0)
            }
            
            UIView.addKeyframe(withRelativeStartTime: 0.2, relativeDuration: 0.8) {
                //take the entire width of the view and add the width of the label/ i.e push the label off the screen
                self.label.center = CGPoint(
                    x: self.view.bounds.size.width + self.label.bounds.width,
                    y: self.view.center.y)
            }
        }
        UIView.animateKeyframes(withDuration: 1.5, delay: 0, options: [], animations: anticipationBlock, completion: { _ in
            self.label.center = CGPoint(x: -self.label.bounds.size.width, y: self.view.center.y)
            UIView.animate(withDuration: 1.5) {
                self.label.center = self.view.center
                self.label.transform = .identity
            }
        })
    }
}
//
//UIView.animateKeyframes(withDuration: 1.5, delay: 0, options: [], animations: {
//      //ketframes
//      UIView.addKeyframe(withRelativeStartTime: 0, relativeDuration: 0.1) {
//          self.label.transform = CGAffineTransform(rotationAngle: CGFloat.pi/16.0)
//      }
//
//      UIView.addKeyframe(withRelativeStartTime: 0.1, relativeDuration: 0.2) {
//          //negative 1 reverses the sign on a call. this goes counter clockwise instead of clockwise like it would have
//          self.label.transform = CGAffineTransform(rotationAngle: -1 * CGFloat.pi/16.0)
//      }
//
//      UIView.addKeyframe(withRelativeStartTime: 0.2, relativeDuration: 0.8) {
//          //take the entire width of the view and add the width of the label/ i.e push the label off the screen
//          self.label.center = CGPoint(
//              x: self.view.bounds.size.width + self.label.bounds.width,
//              y: self.view.center.y)
//      }
//
//  }, completion: nil)
