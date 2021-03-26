//
//  ViewController.swift
//  BMISmart
//
//  Created by Nguyễn Hữu Khánh on 26/03/2021.
//

import UIKit

class HomeVC: UIViewController {
    
    //MARK: - DECLARE 4 ARRAYS STORE CONSTRAINTS
    private var compactConstraints = [NSLayoutConstraint]()
    private var regularConstraints = [NSLayoutConstraint]()
    private var shareConstraints = [NSLayoutConstraint]()
    private var compactHeightConstraint = [NSLayoutConstraint]()
    
    //MARK:- DECLARING USER INTERFACE
    let container = UIView()
    
    //MARK:- DECLARING AGE SESSION
    
    // CONTAINER OF BOTH AGE AND WEIGHT
    private lazy var ageWeightSession = UIStackView()
    
    //MARK:- DECLARING AGE SESSION
    private lazy var containerAge = UIView()
    let ageWrapper = UIStackView()
    let ageValueLabelContainer = UIStackView()
    let ageLabelImage = UIImageView()
    let ageValueLable = UILabel()
    let ageUnitLabel = UILabel()
    let ageButtonContainer = UIStackView()
    let ageMinusButton = UIButton()
    let agePlusButton = UIButton()
    
    
    //MARK:- DECLARING WEIGHT SESSION
    private lazy var containerWeight = UIView()
    let weightWrapper = UIStackView()
    let weightValueLabelContainer = UIStackView()
    let weightLabelImage = UIImageView()
    let weightValueLable = UILabel()
    let weightUnitLabel = UILabel()
    let weightButtonContainer = UIStackView()
    let weightMinusButton = UIButton()
    let weightPlusButton = UIButton()
    
    //MARK:- DECLARING HEIGHT SESSION
    private lazy var heightSession = UIView()
    
    // MEASURE
    let measureContainer = UIView()
    let imageMeasure = UIImageView()
    let heightSlider = UISlider()
    
    // HEIGHT SPEC
    let heightValueSide = UIView()
    
    let heightWrapper = UIStackView()
    let heightValueLabelContainer = UIStackView()
    let heightLabelImage = UIImageView()
    let heightValueLabel = UILabel()
    let heightUnitLabel = UILabel()
    
    // HEIGHT IMAGE
    let heightImageSide = UIView()
    let heightImage = UIImageView()
    
    //MARK:- DE CLARING GENDER SESSION
    
    private lazy var genderSession = UIView()
    let genderWrapper = UIStackView()
    let firstLable = UILabel()
    let genderGroup = UIStackView()
    let femaleText = UILabel()
    let genderButton = UIButton()
    let maleText = UILabel()
    
    //MARK:- DECLARING BUTTON CALCULATOR
    private lazy var calculateButton = UIButton()
    
    //MARK: - DECLARE VALUES
    var ageValue = 18
    var weightValue: Float = 50.0
    var heightValue: Float = 150.0
    var bmiValue: Float = 0.0
    
    var genderState = false
    var gender: Gender = .female
    var humanlooks: Human = .womanSlim
    
    //MARK:- LOAD VIEW
    override func loadView() {
        super.loadView()
        
        // Title
        title = "BMI CALCULATOR"
        
        // Background
        view.backgroundColor = .bgColor
        
        // configureUI
        configureUI()
        
        // add Subviews
        addSubviews()
        
        // Set up constraints
        setupConstraints()
        
        // Activate Common constraints
        NSLayoutConstraint.activate(shareConstraints)
        
        // Capture current trait collections
        layoutTrait(traitCollection: UIScreen.main.traitCollection)
        
        // EVENT UPDATE AGE VALUE
        ageMinusButton.addTarget(self, action: #selector(updateAgeValue(_:)), for: .touchUpInside)
        agePlusButton.addTarget(self, action: #selector(updateAgeValue(_:)), for: .touchUpInside)
        
        //EVENT UPDATE WEIGHT VALUE
        weightMinusButton.addTarget(self, action: #selector(updateWeightValue(_:)), for: .touchUpInside)
        weightPlusButton.addTarget(self, action: #selector(updateWeightValue(_:)), for: .touchUpInside)
        
        // EVEN UPDATE HEIGHT VALUE
        heightSlider.addTarget(self, action: #selector(updateHeightValue(_:)), for: .valueChanged)
        
        // EVEN GENDER
        genderButton.addTarget(self, action: #selector(getGender(_:)), for: .touchUpInside)
        
        //UPDATE UI AFTER INTERACT
        calculateButton.addTarget(self, action: #selector(calculate(_:)), for: .touchUpInside)
        
        
        
    }
    
    
    //MARK:- EVENTS
    
    // CALCULATE BMI AND SHOW RESULT
    @objc func calculate(_ sender: UIButton) {
        calculateBMI(weight: weightValue, height: heightValue)
        let resultsVC = ResultsVC()
        resultsVC.bmiReceived = bmiValue
        resultsVC.humanLooks = humanlooks
        navigationController?.pushViewController(resultsVC, animated: true)
    }
    
    // CALCULATE BMI
    func calculateBMI(weight: Float, height: Float) {
        bmiValue = (weight * 10_000) / (height*height)
    }
    
    // UPDATE AGE VALUE
    @objc func updateAgeValue(_ sender: UIButton) {
        if sender.tag == 1 {
            ageValue -= 1
            if ageValue < 0 {
                ageValue = 0
            }
        } else {
            ageValue += 1
            if ageValue > 149 {
                ageValue = 150
            }
        }
        ageValueLable.text = "\(ageValue)"
        // Update UI
        humanlooks = humanLook(gender: gender, age: ageValue, bmi: bmiValue)
        heightImage.image = changeHuman(humanlooks)
        
    }
    
    // UPDATE WEIGHT VALUE
    @objc func updateWeightValue(_ sender: UIButton) {
        if sender.tag == 1 {
            weightValue -= 1
            if weightValue < 0 {
                weightValue = 0
            }
        } else {
            weightValue += 1
            if weightValue > 149 {
                weightValue = 150
            }
        }
        weightValueLable.text = String(format: "%.0f", weightValue)
        calculateBMI(weight: weightValue, height: heightValue)
        // Update UI
        humanlooks = humanLook(gender: gender, age: ageValue, bmi: bmiValue)
        heightImage.image = changeHuman(humanlooks)
    }
    
    // UPDATE HEIGHT VALUE
    @objc func updateHeightValue(_ sender: UISlider) {
        heightValue = heightSlider.value
        heightValueLabel.text = String(format: "%.0f", heightValue)
        calculateBMI(weight: weightValue, height: heightValue)
        // Update UI
        humanlooks = humanLook(gender: gender, age: ageValue, bmi: bmiValue)
        heightImage.image = changeHuman(humanlooks)
    }
    
    //MARK:- HUMAM LOOK
    func humanLook(gender: Gender, age: Int, bmi: Float) -> Human{
        
        if gender == .male {
            if age <= 15 { // if age < 15
                if bmi >= 25 {
                    return .boyObese
                } else {
                    return .boySlim
                }
            } else { // if age > 15
                if bmi >= 25 {
                    return .manObese
                } else {
                    return .manSlim
                }
            }
        } else { // Female case
            if age <= 15 { // if age < 15
                if bmi >= 25 {
                    return .girlObese
                } else {
                    return .girlSlim
                }
            } else { // if age > 15
                if bmi >= 25 {
                    return .womanObese
                } else {
                    return .womanSlim
                }
            }
        }
    }
    
    func changeHuman(_ humanlook: Human) -> UIImage {
        switch humanlook {
        case .boySlim:
            return UIImage(named: "boySlim")!
        case .boyObese:
            return UIImage(named: "boyObese")!
        case .girlSlim:
            return UIImage(named: "girlSlim")!
        case .girlObese:
            return UIImage(named: "girlObese")!
        case .manSlim:
            return UIImage(named: "manSlim")!
        case .manObese:
            return UIImage(named: "manObese")!
        case .womanSlim:
            return UIImage(named: "womanSlim")!
        case .womanObese:
            return UIImage(named: "womanObese")!
        }
    }
    
    // GET GENDER
    @objc func getGender(_ sender: UIButton) {
        genderState = !genderState
        
        switch genderState {
        case true:
            genderButton.setImage(UIImage(named: "genderButtonMale"), for: .normal)
            gender = .male
        case false:
            genderButton.setImage(UIImage(named: "genderButtonFemale"), for: .normal)
            gender = .female
        }
        // Update UI
        humanlooks = humanLook(gender: gender, age: ageValue, bmi: bmiValue)
        heightImage.image = changeHuman(humanlooks)
    }
    
    
    //MARK:- CONFIGURING USER INTERFACE
    func configureUI() {
        
        //MARK:- CONFIGURING AGE AND WEIGHT SESSION
        
        //MARK:- CONFIGURING AGE SESSION
        ageWeightSession.alignment = .fill
        ageWeightSession.distribution = .fillEqually
        ageWeightSession.spacing = 20
        ageWeightSession.axis = .horizontal
        
        containerAge.containerbg()
        ageWrapper.alignment = .center
        ageValueLabelContainer.axis = .horizontal
        ageLabelImage.image = UIImage(named: "ageButton")
        
        ageValueLable.text = "18"
        ageValueLable.textAlignment = .right
        ageValueLable.font = UIFont(name: "Roboto-Bold", size: 40)
        ageValueLable.textColor = .lightGrayColor
        
        ageUnitLabel.text = "tuổi"
        ageUnitLabel.font = UIFont(name: "Roboto-Thin", size: 20)
        ageUnitLabel.textColor = .lightGrayColor
        ageUnitLabel.textAlignment = .left
        
        ageButtonContainer.axis = .horizontal
        
        ageMinusButton.setImage(UIImage(named: "minusButton"), for: .normal)
        ageMinusButton.tag = 1
        ageMinusButton.setImage(UIImage(named: "minusButtonPressed"), for: .highlighted)
        
        agePlusButton.setImage(UIImage(named: "plusButton"), for: .normal)
        agePlusButton.tag = 2
        agePlusButton.setImage(UIImage(named: "plusButtonPressed"), for: .highlighted)
        
        //MARK:- CONFIGURING WEIGHT SESSION
        containerWeight.containerbg()
        
        weightWrapper.alignment = .center
        
        weightValueLabelContainer.axis = .horizontal
        
        weightLabelImage.image = UIImage(named: "weightButton")
        
        weightValueLable.text = "50"
        weightValueLable.textColor = .lightGrayColor
        weightValueLable.textAlignment = .center
        weightValueLable.font = UIFont(name: "Roboto-Bold", size: 40)
        weightValueLable.textAlignment = .right
        
        weightUnitLabel.text = "kg"
        weightUnitLabel.textColor = .lightGrayColor
        weightUnitLabel.font = UIFont(name: "Roboto-Thin", size: 20)
        weightUnitLabel.textAlignment = .left
        weightUnitLabel.textAlignment = .center
        
        weightButtonContainer.axis = .horizontal
        
        weightMinusButton.setImage(UIImage(named: "minusButton"), for: .normal)
        weightMinusButton.setImage(UIImage(named: "minusButtonPressed"), for: .highlighted)
        weightMinusButton.tag = 1
        
        weightPlusButton.setImage(UIImage(named: "plusButton"), for: .normal)
        weightPlusButton.setImage(UIImage(named: "plusButtonPressed"), for: .highlighted)
        weightPlusButton.tag = 2
        
        
        //MARK:- CONFIGURING HEIGHT SESSION
        heightSession.containerbg()
        
        imageMeasure.image = UIImage(named: "heightMeasure")
        imageMeasure.contentMode = .scaleToFill
        
        heightSlider.transform = CGAffineTransform(rotationAngle: CGFloat(-Double.pi/2))
        heightSlider.minimumTrackTintColor = .clear
        heightSlider.maximumTrackTintColor = .clear
        heightSlider.minimumValue = 30.0
        heightSlider.maximumValue = 250.0
        heightSlider.value = 150.0
        
        heightWrapper.axis = .vertical
        heightWrapper.alignment = .center
        heightWrapper.spacing = 10
        
        heightValueLabelContainer.axis = .vertical
        
        heightLabelImage.image = UIImage(named: "heightButton")
        
        heightValueLabel.text = "150"
        heightValueLabel.textAlignment = .right
        heightValueLabel.font = UIFont(name: "Roboto-Bold", size: 40)
        heightValueLabel.textColor = .lightGrayColor
        
        heightUnitLabel.text = "cm"
        heightUnitLabel.font = UIFont(name: "Roboto-Thin", size: 20)
        heightUnitLabel.textColor = .lightGrayColor
        heightUnitLabel.textAlignment = .center
        
        
        
        heightImage.image = UIImage(named: "womanSlim")
        heightImage.contentMode = .scaleAspectFit
        
        
        //MARK:- CONFIGURING GENDER SESSION
        genderSession.containerbg()
        
        genderWrapper.axis = .horizontal
        genderWrapper.spacing = 10
        
        firstLable.text = "i'm a"
        firstLable.font = UIFont(name: "Roboto-Bold", size: 24)
        firstLable.textColor = .lightGrayColor
        
        genderGroup.axis = .horizontal
        genderGroup.spacing = 10
        
        femaleText.text = "Female"
        femaleText.font = UIFont(name: "Roboto-Thin", size: 14)
        femaleText.textColor = .lightGrayColor
        
        genderButton.setImage(UIImage(named: "genderButtonFemale"), for: .normal)
        
        maleText.text = "Male"
        maleText.font = UIFont(name: "Roboto-Thin", size: 14)
        maleText.textColor = .lightGrayColor
        
        //MARK:- CONFIGURING CALCULATE BUTTON SESSION
        calculateButton.setTitle("CALCULATE BMI", for: .normal)
        calculateButton.setTitleColor(.white, for: .normal)
        calculateButton.setTitleColor(.lightGray, for: .highlighted)
        calculateButton.titleLabel?.font = UIFont(name: "Roboto-Regular", size: 20)
        calculateButton.backgroundColor = .lightBlueColor
        calculateButton.layer.cornerRadius = 10
    }
    
    
    
    //MARK:- ADD SUBVIEWS
    func addSubviews() {
        view.addSubview(container)
        container.translatesAutoresizingMaskIntoConstraints = false
        
        ([ageWeightSession, heightSession, genderSession, calculateButton]).forEach {
            container.addSubview($0)
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
        
        // ADD SUBVIEWS AGE AND WEIGHT SESSION
        [containerAge, containerWeight].forEach {
            ageWeightSession.addArrangedSubview($0)
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
        // AGE
        containerAge.addSubview(ageWrapper)
        ageWrapper.translatesAutoresizingMaskIntoConstraints = false
        
        [ageLabelImage, ageValueLabelContainer, ageButtonContainer].forEach {
            ageWrapper.addArrangedSubview($0)
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
        
        [ageValueLable, ageUnitLabel].forEach{
            ageValueLabelContainer.addArrangedSubview($0)
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
        [ageMinusButton, agePlusButton].forEach{
            ageButtonContainer.addArrangedSubview($0)
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
        
        // WEIGHT
        containerWeight.addSubview(weightWrapper)
        weightWrapper.translatesAutoresizingMaskIntoConstraints = false
        
        [weightLabelImage, weightValueLabelContainer, weightButtonContainer].forEach {
            weightWrapper.addArrangedSubview($0)
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
        [weightValueLable, weightUnitLabel].forEach{
            weightValueLabelContainer.addArrangedSubview($0)
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
        [weightMinusButton, weightPlusButton].forEach{
            weightButtonContainer.addArrangedSubview($0)
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
        
        // ADD SUBVIEWS HEIGHT SESSION
        [heightValueSide, heightImageSide, measureContainer].forEach {
            heightSession.addSubview($0)
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
        ([imageMeasure, heightSlider]).forEach{
            measureContainer.addSubview($0)
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
        
        heightValueSide.addSubview(heightWrapper)
        heightWrapper.translatesAutoresizingMaskIntoConstraints = false
        
        [heightLabelImage, heightValueLabelContainer].forEach {
            heightWrapper.addArrangedSubview($0)
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
        [heightValueLabel, heightUnitLabel].forEach{
            heightValueLabelContainer.addArrangedSubview($0)
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
        
        heightImageSide.addSubview(heightImage)
        heightImage.translatesAutoresizingMaskIntoConstraints = false
        
        // ADD SUBVIEWS GENDER SESSION
        genderSession.addSubview(genderWrapper)
        genderWrapper.translatesAutoresizingMaskIntoConstraints = false
        
        ([firstLable, genderGroup]).forEach {
            genderWrapper.addArrangedSubview($0)
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
        ([femaleText, genderButton, maleText]).forEach {
            genderGroup.addArrangedSubview($0)
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
    }
    
    //MARK:- SET UP CONSTRAINTS
    func setupConstraints() {
        //MARK:- SHARE CONSTRAINTS
        shareConstraints.append(contentsOf: [
            // SETUP CONSTRAINT CONTAINER
            container.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            container.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            container.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20),
            container.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20),
            
            // SETUP CONSTRAINTS AGE AND WEIGHT SESSION
            ageWeightSession.topAnchor.constraint(equalTo: container.topAnchor),
            ageWeightSession.leadingAnchor.constraint(equalTo: container.leadingAnchor),
            
            // CONSTRAINTS AGE
            ageWrapper.centerYAnchor.constraint(equalTo: containerAge.centerYAnchor),
            ageWrapper.centerXAnchor.constraint(equalTo: containerAge.centerXAnchor),
            
            // CONSTRAINTS WEIGHT
            weightWrapper.centerYAnchor.constraint(equalTo: containerWeight.centerYAnchor),
            weightWrapper.centerXAnchor.constraint(equalTo: containerWeight.centerXAnchor),
            
            // SETUP CONSTRAINTS HEIGHT SESSION
            
            measureContainer.centerXAnchor.constraint(equalTo: heightSession.centerXAnchor),
            measureContainer.centerYAnchor.constraint(equalTo: heightSession.centerYAnchor),
            measureContainer.heightAnchor.constraint(equalTo: heightSession.heightAnchor),
            measureContainer.widthAnchor.constraint(equalTo: measureContainer.heightAnchor, multiplier: 1/8),
            
            imageMeasure.widthAnchor.constraint(equalTo: measureContainer.widthAnchor),
            imageMeasure.heightAnchor.constraint(equalTo: measureContainer.heightAnchor),
            imageMeasure.centerXAnchor.constraint(equalTo: measureContainer.centerXAnchor),
            imageMeasure.centerYAnchor.constraint(equalTo: measureContainer.centerYAnchor),
            
            heightSlider.centerXAnchor.constraint(equalTo: measureContainer.centerXAnchor),
            heightSlider.centerYAnchor.constraint(equalTo: measureContainer.centerYAnchor),
            heightSlider.widthAnchor.constraint(equalTo: measureContainer.heightAnchor),
            
            heightValueSide.topAnchor.constraint(equalTo: heightSession.topAnchor),
            heightValueSide.leadingAnchor.constraint(equalTo: heightSession.leadingAnchor),
            heightValueSide.widthAnchor.constraint(equalTo: heightSession.widthAnchor, multiplier: 0.5),
            heightValueSide.heightAnchor.constraint(equalTo: heightSession.heightAnchor),
            
            heightImageSide.topAnchor.constraint(equalTo: heightSession.topAnchor),
            heightImageSide.trailingAnchor.constraint(equalTo: heightSession.trailingAnchor),
            heightImageSide.widthAnchor.constraint(equalTo: heightSession.widthAnchor, multiplier: 0.5),
            heightImageSide.heightAnchor.constraint(equalTo: heightSession.heightAnchor),
            
            
            heightWrapper.centerYAnchor.constraint(equalTo: heightValueSide.centerYAnchor),
            heightWrapper.centerXAnchor.constraint(equalTo: heightValueSide.centerXAnchor),
            
            heightImage.topAnchor.constraint(equalTo: heightImageSide.topAnchor),
            heightImage.leadingAnchor.constraint(equalTo: heightImageSide.leadingAnchor),
            heightImage.trailingAnchor.constraint(equalTo: heightImageSide.trailingAnchor),
            heightImage.bottomAnchor.constraint(equalTo: heightImageSide.bottomAnchor),
            
            //SETUP CONSTRAINTS GENDER SESSION
            genderWrapper.centerXAnchor.constraint(equalTo: genderSession.centerXAnchor),
            genderWrapper.centerYAnchor.constraint(equalTo: genderSession.centerYAnchor),
            
        ])
        
        //MARK: - REGULAR CONSTRAINTS
        regularConstraints.append(contentsOf: [
            // AGE WEIGHT SESSION
            ageWeightSession.trailingAnchor.constraint(equalTo: container.trailingAnchor),
            ageWeightSession.heightAnchor.constraint(equalTo: container.heightAnchor, multiplier: 1/3),
            
            // HEIGHT SESSION
            heightSession.topAnchor.constraint(equalTo: ageWeightSession.bottomAnchor, constant: 20),
            heightSession.leadingAnchor.constraint(equalTo: ageWeightSession.leadingAnchor),
            heightSession.trailingAnchor.constraint(equalTo: ageWeightSession.trailingAnchor),
            heightSession.heightAnchor.constraint(equalTo: container.heightAnchor, multiplier: 1/3),
            
            //GENDER SESSION
            genderSession.topAnchor.constraint(equalTo: heightSession.bottomAnchor, constant: 20),
            genderSession.leadingAnchor.constraint(equalTo:heightSession.leadingAnchor),
            genderSession.trailingAnchor.constraint(equalTo:heightSession.trailingAnchor),
            
            //BUTTON SECTION
            calculateButton.topAnchor.constraint(equalTo: genderSession.bottomAnchor, constant: 20),
            calculateButton.leadingAnchor.constraint(equalTo: genderSession.leadingAnchor),
            calculateButton.trailingAnchor.constraint(equalTo: genderSession.trailingAnchor),
            calculateButton.bottomAnchor.constraint(equalTo: container.bottomAnchor, constant: -20),
            calculateButton.heightAnchor.constraint(equalToConstant: 60),
            
            // AGE BUTTON
            ageMinusButton.widthAnchor.constraint(equalToConstant: 60),
            ageMinusButton.heightAnchor.constraint(equalTo: ageMinusButton.widthAnchor, multiplier: 1),
            agePlusButton.widthAnchor.constraint(equalToConstant: 60),
            agePlusButton.heightAnchor.constraint(equalTo: agePlusButton.widthAnchor, multiplier: 1),
            
            // WEIGHT BUTTON
            weightMinusButton.widthAnchor.constraint(equalToConstant: 60),
            weightMinusButton.heightAnchor.constraint(equalTo: weightMinusButton.widthAnchor, multiplier: 1),
            weightPlusButton.widthAnchor.constraint(equalToConstant: 60),
            weightPlusButton.heightAnchor.constraint(equalTo: weightPlusButton.widthAnchor, multiplier: 1),
            
            // GENDER BUTTON
            genderButton.widthAnchor.constraint(equalToConstant: 180),
            genderButton.heightAnchor.constraint(equalTo: genderButton.widthAnchor, multiplier: 2/5),
        ])
        
        
        //MARK:- COMPACT CONSTRAINTS
        compactConstraints.append(contentsOf: [
            // AGE WEIGHT SESSION
            ageWeightSession.trailingAnchor.constraint(equalTo: container.trailingAnchor),
            ageWeightSession.heightAnchor.constraint(equalTo: container.heightAnchor, multiplier: 1/3),
            
            // HEIGHT SESSION
            heightSession.topAnchor.constraint(equalTo: ageWeightSession.bottomAnchor, constant: 20),
            heightSession.leadingAnchor.constraint(equalTo: ageWeightSession.leadingAnchor),
            heightSession.trailingAnchor.constraint(equalTo: ageWeightSession.trailingAnchor),
            heightSession.heightAnchor.constraint(equalTo: container.heightAnchor, multiplier: 1/3),
            
            //GENDER SESSION
            genderSession.topAnchor.constraint(equalTo: heightSession.bottomAnchor, constant: 20),
            genderSession.leadingAnchor.constraint(equalTo:heightSession.leadingAnchor),
            genderSession.trailingAnchor.constraint(equalTo:heightSession.trailingAnchor),
            
            //BUTTON SECTION
            calculateButton.topAnchor.constraint(equalTo: genderSession.bottomAnchor, constant: 20),
            calculateButton.leadingAnchor.constraint(equalTo: genderSession.leadingAnchor),
            calculateButton.trailingAnchor.constraint(equalTo: genderSession.trailingAnchor),
            calculateButton.bottomAnchor.constraint(equalTo: container.bottomAnchor, constant: -20),
            calculateButton.heightAnchor.constraint(equalToConstant: 50),
            
            // AGE BUTTON
            ageMinusButton.widthAnchor.constraint(equalToConstant: 40),
            ageMinusButton.heightAnchor.constraint(equalTo: ageMinusButton.widthAnchor, multiplier: 1),
            agePlusButton.widthAnchor.constraint(equalToConstant: 40),
            agePlusButton.heightAnchor.constraint(equalTo: agePlusButton.widthAnchor, multiplier: 1),
            
            // WEIGHT BUTTON
            weightMinusButton.widthAnchor.constraint(equalToConstant: 40),
            weightMinusButton.heightAnchor.constraint(equalTo: weightMinusButton.widthAnchor, multiplier: 1),
            weightPlusButton.widthAnchor.constraint(equalToConstant: 40),
            weightPlusButton.heightAnchor.constraint(equalTo: weightPlusButton.widthAnchor, multiplier: 1),
            
            // GENDER BUTTON
            genderButton.widthAnchor.constraint(equalToConstant: 125),
            genderButton.heightAnchor.constraint(equalTo: genderButton.widthAnchor, multiplier: 2/5),
            
        ])
        
        //MARK: - LANSCAPE PHONE CONSTRAINTS
        compactHeightConstraint.append(contentsOf: [
            // AGE WEIGHT SESSION
            ageWeightSession.widthAnchor.constraint(equalTo: container.widthAnchor, multiplier: 0.5, constant: -10),
            ageWeightSession.bottomAnchor.constraint(equalTo: genderSession.topAnchor, constant: -20),
            
            // HEIGHT SESSION
            heightSession.leadingAnchor.constraint(equalTo: ageWeightSession.trailingAnchor, constant: 20),
            heightSession.topAnchor.constraint(equalTo: container.topAnchor),
            heightSession.trailingAnchor.constraint(equalTo: container.trailingAnchor),
            heightSession.heightAnchor.constraint(equalTo: ageWeightSession.heightAnchor),
            
            //GENDER SESSION
            genderSession.topAnchor.constraint(equalTo: ageWeightSession.bottomAnchor, constant: 20),
            genderSession.leadingAnchor.constraint(equalTo: ageWeightSession.leadingAnchor),
            genderSession.widthAnchor.constraint(equalTo: ageWeightSession.widthAnchor),
            genderSession.bottomAnchor.constraint(equalTo: container.bottomAnchor),
            genderSession.heightAnchor.constraint(equalToConstant: 80),
            
            //BUTTON SECTION
            calculateButton.topAnchor.constraint(equalTo: heightSession.bottomAnchor, constant: 20),
            calculateButton.trailingAnchor.constraint(equalTo: container.trailingAnchor),
            calculateButton.heightAnchor.constraint(equalTo: genderSession.heightAnchor),
            calculateButton.widthAnchor.constraint(equalTo: heightSession.widthAnchor),
            
            // AGE BUTTON
            ageMinusButton.widthAnchor.constraint(equalToConstant: 40),
            ageMinusButton.heightAnchor.constraint(equalTo: ageMinusButton.widthAnchor, multiplier: 1),
            agePlusButton.widthAnchor.constraint(equalToConstant: 40),
            agePlusButton.heightAnchor.constraint(equalTo: agePlusButton.widthAnchor, multiplier: 1),
            
            // WEIGHT BUTTON
            weightMinusButton.widthAnchor.constraint(equalToConstant: 40),
            weightMinusButton.heightAnchor.constraint(equalTo: weightMinusButton.widthAnchor, multiplier: 1),
            weightPlusButton.widthAnchor.constraint(equalToConstant: 40),
            weightPlusButton.heightAnchor.constraint(equalTo: weightPlusButton.widthAnchor, multiplier: 1),
            
            // GENDER BUTTON
            genderButton.widthAnchor.constraint(equalToConstant: 125),
            genderButton.heightAnchor.constraint(equalTo: genderButton.widthAnchor, multiplier: 2/5),
        ])
    }
    
    //MARK: - decisions for autolayout with selected iphone screen size and orientations
    func layoutTrait(traitCollection: UITraitCollection){
        if let first = shareConstraints.first {
            // if shareConstraints.isActivate = false, then activate it
            if !first.isActive {
                NSLayoutConstraint.activate(shareConstraints)
            }
        }
        if traitCollection.verticalSizeClass == .compact {
            if compactConstraints.count > 0 && compactConstraints[0].isActive {
                NSLayoutConstraint.deactivate(compactConstraints)
            }
            changeSize(.CompactHeight)
            NSLayoutConstraint.activate(compactHeightConstraint)
        } else {
            if compactHeightConstraint.count > 0 && compactHeightConstraint[0].isActive {
                NSLayoutConstraint.deactivate(compactHeightConstraint)
            }
            changeSize(.Compact)
            NSLayoutConstraint.activate(compactConstraints)
        }
        
        if traitCollection.horizontalSizeClass == .regular && traitCollection.verticalSizeClass == .regular {
            if (compactConstraints.count > 0 && compactConstraints[0].isActive) || (compactHeightConstraint.count > 0 && compactHeightConstraint[0].isActive) {
                NSLayoutConstraint.deactivate(compactConstraints)
                NSLayoutConstraint.deactivate(compactHeightConstraint)
            }
            NSLayoutConstraint.activate(regularConstraints)
            changeSize(.Regular)
        }
    }
    
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
        layoutTrait(traitCollection: traitCollection)
    }
    
    //MARK:- CHANGE SIZES
    func changeSize(_ size: Size) {
        if size == .CompactHeight {
            ageWeightSession.axis = .vertical
            ageWrapper.axis = .horizontal
            ageWrapper.spacing = 5
            ageButtonContainer.spacing = 5
            weightWrapper.axis = .horizontal
            weightWrapper.spacing = 10
            weightButtonContainer.spacing = 5
            
        } else if size == .Compact {
            ageWeightSession.axis = .horizontal
            ageWrapper.axis = .vertical
            ageWrapper.spacing = 10
            ageButtonContainer.spacing = 10
            weightWrapper.axis = .vertical
            weightWrapper.spacing = 10
            weightButtonContainer.spacing = 10
            
        } else if size == .Regular {
            ageValueLable.font = UIFont(name: "Roboto-Bold", size: 60)
            weightValueLable.font = UIFont(name: "Roboto-Bold", size: 60)
            heightValueLabel.font = UIFont(name: "Roboto-Bold", size: 60)
            firstLable.font = UIFont(name: "Roboto-Bold", size: 40)
            ageWrapper.spacing = 20
            ageButtonContainer.spacing = 20
            weightWrapper.spacing = 20
            weightButtonContainer.spacing = 20
        }
    }
}

