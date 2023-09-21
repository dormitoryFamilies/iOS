//
//  MealViewController.swift
//  dormitoryFamiles
//
//  Created by leehwajin on 2023/09/21.
//

import UIKit

enum Time: String {
    case morning = "morning"
    case lunch = "lunch"
    case evening = "evening"
}

class MealViewController: UIViewController {

    private lazy var dateText: UILabel = {
        let label = UILabel()
        label.text = "오늘의 긱식 (\(formattedCurrentDate(year: false)))"
        return label
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        setupConstraints()
       
    }

    private func formattedCurrentDate(year: Bool) -> String {
        let currentDate = Date()
        let dateFormatter = DateFormatter()
        if year {
            dateFormatter.dateFormat = "YYYY-MM-dd"
        }else {
            dateFormatter.dateFormat = "MM-dd"
        }
        return dateFormatter.string(from: currentDate)
        
    }
    
    private func setupConstraints() {
        [dateText].forEach {
            view.addSubview($0)
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
        
        NSLayoutConstraint.activate([
            dateText.topAnchor.constraint(equalTo: view.topAnchor, constant: 100),
            dateText.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            dateText.widthAnchor.constraint(equalToConstant: 500),
            dateText.heightAnchor.constraint(equalToConstant: 50),
        ])
    }
    
    

}
