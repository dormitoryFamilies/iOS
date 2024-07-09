//
//  CompleteMyCondition.swift
//  dormitoryFamiles
//
//  Created by BAE on 7/9/24.
//

import UIKit
import SnapKit

final class CompleteMyCondition: UIViewController, ConfigUI {
    
    private let completeMyConditionLogo: UIImageView = {
        let view = UIImageView()
        view.image = UIImage(named: "completeMyCondition_logo")
        view.contentMode = .scaleAspectFit
        return view
    }()
    
    private let firstLabel: UILabel = {
        let label = UILabel()
        label.text = "나의 긱사생활 입력이 완료되었어요."
        label.font = FontManager.body3()
        label.textAlignment = .center
        label.textColor = .doomzBlack
        label.addCharacterSpacing()
        return label
    }()
    
    private let secondLabel: UILabel = {
        let label = UILabel()
        label.text = "원하는 룸메정보를 설정해봐요!"
        label.font = FontManager.title2()
        label.textAlignment = .center
        label.textColor = .doomzBlack
        label.addCharacterSpacing()
        return label
    }()
    
    private let thirdLabel: UILabel = {
        let label = UILabel()
        label.text = "나의 긱사생활 변경을 '마이페이지'에서 가능해요."
        label.font = FontManager.body2()
        label.textAlignment = .center
        label.textColor = .doomzBlack
        label.addCharacterSpacing()
        return label
    }()
    
    private let nextButton = CommonButton()
    
    private lazy var nextButtonModel = CommonbuttonModel(title: "룸메 정보 설정", titleColor: .white ,backgroundColor: .gray3!, height: 52) {
        self.didClickNextButton()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .background
        setupNavigationBar("긱사생활 설정")
        addComponents()
        setConstraints()
        nextButton.setup(model: nextButtonModel)
    }
    
    func addComponents() {
        [firstLabel, secondLabel, thirdLabel, completeMyConditionLogo, nextButton].forEach { view.addSubview($0) }
    }
    
    func setConstraints() {
        firstLabel.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(172)
            $0.centerX.equalToSuperview()
        }
        
        secondLabel.snp.makeConstraints {
            $0.top.equalTo(firstLabel.snp.bottom).offset(8)
            $0.centerX.equalToSuperview()

        }
        
        thirdLabel.snp.makeConstraints {
            $0.top.equalTo(secondLabel.snp.bottom).offset(16)
            $0.centerX.equalToSuperview()

        }
        
        completeMyConditionLogo.snp.makeConstraints {
            $0.top.equalTo(thirdLabel.snp.bottom).offset(36)
            $0.centerX.equalToSuperview()
        }
        
        nextButton.snp.makeConstraints {
            $0.left.right.equalToSuperview().inset(20)
            $0.bottom.equalToSuperview().inset(32)
        }
    }
    
    @objc
    func didClickNextButton() {
        print("nextBtn")
//        self.navigationController?.pushViewController(MiscViewController(), animated: true)
    }
}