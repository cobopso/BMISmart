//
//  ResultsVC.swift
//  BMISmart
//
//  Created by Nguyễn Hữu Khánh on 26/03/2021.
//

import UIKit

class ResultsVC: UIViewController {
    
    //MARK: - DECLARE 4 ARRAYS STORE CONSTRAINTS
    private var compactConstraints = [NSLayoutConstraint]()
    private var regularConstraints = [NSLayoutConstraint]()
    private var shareConstraints = [NSLayoutConstraint]()
    private var compactHeightConstraint = [NSLayoutConstraint]()
    
    //MARK:-
    private lazy var container = UIView()
    private lazy var button = UIButton()
    
    let contentWrapper = UIStackView()
    let imageResult = UIImageView()
    let bmiValueLabel = UILabel()
    let adVice = UILabel()
    
    //MARK:- Receive data
    var bmiReceived: Float = 0.0
    var humanLooks: Human = .womanSlim
    
    var genderReceived: Gender?
    var ageReceived: Int?
    
    //MARK:- bodyfit
    var fit: HumanFit = .Normal
    var ageRecieved: Int?
    var genderRecieved: Gender?
    
    
    //MARK:- Load View
    override func loadView() {
        super.loadView()
        
        // Title
        navigationItem.title = "YOUR RESULTS"
        
        // Background
        view.backgroundColor = .bgColor
        
        // Setup UI
        addSubviews()
        configureUI()
        setupConstraints()
        
        // Get advice
        getFit(bmi: bmiReceived)

        let humanVisual = HumanVisual(gender: genderReceived!, age: ageReceived!, look: fit)
        imageResult.image = UIImage(named: humanVisual.getVisual())
        adVice.text = humanVisual.getAdvice()
        bmiValueLabel.textColor = humanVisual.getColor()
        
        
        // Recalculator
        button.addTarget(self, action: #selector(reCalculate), for: .touchUpInside)
        
        // Activate Common constraint
        NSLayoutConstraint.activate(shareConstraints)
        
        // capture current trait collection
        layoutTrait(traitCollection: UIScreen.main.traitCollection)
        
    }
    
    //MARK:- Get Advice
    func getFit(bmi: Float) {
        switch bmi {
        case 0..<18.5:
            fit = .Underweight
        case 18.5..<25:
            fit = .Normal
        case 25..<30:
            fit = .Overweight
        case 30...:
            fit = .Obese
        default:
            fit = .Normal
        }
    }
    
    // Pop to Root
    @objc func reCalculate() {
        navigationController?.popViewController(animated: true)
    }
    
    
    //MARK:- Configure UI
    func configureUI() {
        // Container
        container.containerbg()
        
        // Button
        button.setTitle("RE-CALCULATE", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.setTitleColor(.lightGray, for: .highlighted)
        button.titleLabel?.font = UIFont(name: "Roboto-Regular", size: 20)
        button.backgroundColor = .lightBlueColor
        button.layer.cornerRadius = 10
        
        //Content wrapper
        contentWrapper.axis = .vertical
        contentWrapper.alignment = .center
        
        // image
        imageResult.contentMode = .scaleAspectFit
        
        // Advice
        adVice.text = "Congratulation! \n you have a fit body, best ratio, your height is pretty good! but dont forget t keep your winning!"
        adVice.numberOfLines = 0
        adVice.textAlignment = .center
        adVice.textColor = .darkGray
        
        // BMI value albel
        bmiValueLabel.text = "\(String(format: "%.1f", bmiReceived))"
        bmiValueLabel.textAlignment = .center
        
    }
    
    //MARK: - decisions for autolayout with selected iphone screen size and orientations
    func layoutTrait(traitCollection: UITraitCollection) {
        if let first = shareConstraints.first {
            // if shareConstraint has not active yet, then activate it
            if first.isActive == false {
                NSLayoutConstraint.activate(shareConstraints)
            }
        }
        
        if traitCollection.verticalSizeClass == .compact {
            // We are in iphone devices with horizontal orientation
            if compactConstraints.count > 0 && compactConstraints[0].isActive {
                NSLayoutConstraint.deactivate(compactConstraints)
            }
            NSLayoutConstraint.activate(compactHeightConstraint)
            bmiValueLabel.font = UIFont(name: "Roboto-Bold", size: 80)
            adVice.font = UIFont(name: "Roboto-Thin", size: 18)
        } else {
            if compactHeightConstraint.count > 0 && compactHeightConstraint[0].isActive {
                NSLayoutConstraint.deactivate(compactHeightConstraint)
            }
            NSLayoutConstraint.activate(compactConstraints)
            bmiValueLabel.font = UIFont(name: "Roboto-Bold", size: 100)
            adVice.font = UIFont(name: "Roboto-Thin", size: 24)
        }
        
        if traitCollection.verticalSizeClass == .regular && traitCollection.horizontalSizeClass == .regular {
            if compactConstraints.count > 0 && compactConstraints[0].isActive || compactHeightConstraint.count > 0 && compactHeightConstraint[0].isActive {
                NSLayoutConstraint.deactivate(compactConstraints)
                NSLayoutConstraint.deactivate(compactHeightConstraint)
            }
            NSLayoutConstraint.activate(regularConstraints)
            bmiValueLabel.font = UIFont(name: "Roboto-Bold", size: 120)
            adVice.font = UIFont(name: "Roboto-Thin", size: 30)
        }
        
    }
    
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
        layoutTrait(traitCollection: traitCollection)
    }
    
    
    //MARK:- Setup Constraints
    func setupConstraints() {
        
        //MARK:- Share Constraints
        shareConstraints.append(contentsOf: [
            // Container
            container.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            container.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            container.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20),
            
            // Button
            button.topAnchor.constraint(equalTo: container.bottomAnchor, constant: 20),
            button.leadingAnchor.constraint(equalTo: container.leadingAnchor),
            button.trailingAnchor.constraint(equalTo: container.trailingAnchor),
            button.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20),
            
            // Content wrapper
            contentWrapper.centerXAnchor.constraint(equalTo: container.centerXAnchor),
            contentWrapper.centerYAnchor.constraint(equalTo: container.centerYAnchor),
            
            // imageView
            imageResult.heightAnchor.constraint(equalTo: imageResult.widthAnchor),
            
            // Advice
            adVice.widthAnchor.constraint(equalTo: container.widthAnchor, multiplier: 0.8)
        ])
        
        // MARK:- Compact constraint
        compactConstraints.append(contentsOf: [
            button.heightAnchor.constraint(equalToConstant: 50),
            imageResult.widthAnchor.constraint(equalToConstant: 200),
        ])
        
        //MARK:- Regular constraints
        regularConstraints.append(contentsOf: [
            button.heightAnchor.constraint(equalToConstant: 60),
            imageResult.widthAnchor.constraint(equalToConstant: 360),
        ])
        
        //MARK:- Compact Height Constraints
        compactHeightConstraint.append(contentsOf: [
            button.heightAnchor.constraint(equalToConstant: 50),
            imageResult.widthAnchor.constraint(equalToConstant: 0),
        ])
        
        
    }
    
    //MARK:- Add Subviews
    func addSubviews() {
        ([container, button]).forEach{
            view.addSubview($0)
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
        
        container.addSubview(contentWrapper)
        contentWrapper.translatesAutoresizingMaskIntoConstraints = false
        
        ([imageResult, bmiValueLabel, adVice]).forEach {
            contentWrapper.addArrangedSubview($0)
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
    }
    
}
