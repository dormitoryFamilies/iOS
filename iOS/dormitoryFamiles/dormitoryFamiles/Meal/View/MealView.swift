//
//  MealView.swift
//  dormitoryFamiles
//
//  Created by leehwajin on 2023/09/22.
//

import UIKit

class MealView: UIView {

    private let nowTimeLable: UILabel = {
        let label = UILabel()
        label.text = "아침/점심/저녁"
        return label
    }()
    
    private lazy var mealImageView: UIImageView = {
        let image = UIImageView()
        image.backgroundColor = .black
        return image
    }()
    
   

}
