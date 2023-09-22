//
//  MealViewController.swift
//  dormitoryFamiles
//
//  Created by leehwajin on 2023/09/21.
//

import UIKit
import SwiftSoup

enum Time: String {
    case morning = "morning"
    case lunch = "lunch"
    case evening = "evening"
}

enum ChangedDate: String {
    case past = "past"
    case future = "future"
}

class MealViewController: UIViewController {
    
    private var dateString: String = {
        let dateFormatter = DateFormatter() // Date 포맷 객체 선언
        dateFormatter.locale = Locale(identifier: "ko")
        dateFormatter.dateFormat = "yyyy.MM.dd E요일"
        let dateString = dateFormatter.string(from: Date())
        return dateString
    }()
    
    private lazy var dateLabel: UILabel = {
        let label = UILabel()
        
        label.text = "오늘의 긱식 (\(dateString))"
        return label
    }()
    
    private let schoolMealButton: UIButton = {
        let button = UIButton()
        button.setTitle("학식 보기", for: .normal)
        button.setTitleColor(UIColor.white, for: .normal)
        button.backgroundColor = UIColor.systemPink
        button.titleLabel?.font = UIFont(name: "SFProDisplay-Semibold", size: 18)
        button.layer.cornerRadius = 10
        button.layer.masksToBounds = true
        button.addTarget(self, action: #selector(schoolMealButtonTapped), for: .touchUpInside)
        return button
    }()
    
    private lazy var todayMorning: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        spacingToNewline(time: .morning) { result in
            label.text = result
        }
        return label
    }()
    
    private lazy var todayLunch: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        spacingToNewline(time: .lunch) { result in
            label.text = result
        }
        return label
    }()
    
    private lazy var todayEvening: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        spacingToNewline(time: .evening) { result in
            label.text = result
        }
        return label
    }()
    
    private lazy var menuStackView: UIStackView = {
        let st = UIStackView()
        st.addArrangedSubview(todayMorning)
        st.addArrangedSubview(todayLunch)
        st.addArrangedSubview(todayEvening)
        return st
    }()
    
    private lazy var topUIStackView: UIStackView = {
        let st = UIStackView()
        st.addArrangedSubview(dateLabel)
        st.addArrangedSubview(menuStackView)
        st.axis = .vertical
        return st
    }()
    
    private lazy var changeDateView: UIView = {
        let view = UIView()
        view.backgroundColor = .clear
        let leftSwipe = UISwipeGestureRecognizer(target: self, action: #selector(leftSwipe))
        leftSwipe.direction = .left
        let rightSwpe = UISwipeGestureRecognizer(target: self, action: #selector(rightSwipe))
        rightSwpe.direction = .right
        
        view.addGestureRecognizer(leftSwipe)
        view.addGestureRecognizer(rightSwpe)
        return view
    }()
    
    @objc private func leftSwipe() {
        updateDate(time: .future)
    }

    @objc private func rightSwipe() {
        updateDate(time: .past)
    }
    
    
    private func updateDate(time: ChangedDate) {
        if time == .past {
            print("과거로!")
        }else {
            print("미래로 !")
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        setupConstraints()
        dateLabel.heightAnchor.constraint(equalToConstant: 30).isActive = true
        
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
    
    @objc private func schoolMealButtonTapped() {
        present(SchoolWebViewController(), animated: true)
    }

    private func setupConstraints() {
        [topUIStackView, changeDateView, schoolMealButton].forEach {
            view.addSubview($0)
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
        
        NSLayoutConstraint.activate([
            topUIStackView.topAnchor.constraint(equalTo: view.topAnchor, constant: 100),
            topUIStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            topUIStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
            topUIStackView.heightAnchor.constraint(equalToConstant: 250),
            
            schoolMealButton.topAnchor.constraint(equalTo: topUIStackView.topAnchor),
            schoolMealButton.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -10),
            schoolMealButton.widthAnchor.constraint(equalToConstant: 80),
            schoolMealButton.heightAnchor.constraint(equalToConstant: 50),
            
            changeDateView.topAnchor.constraint(equalTo: topUIStackView.topAnchor),
            changeDateView.leadingAnchor.constraint(equalTo: topUIStackView.leadingAnchor),
            changeDateView.trailingAnchor.constraint(equalTo: topUIStackView.trailingAnchor),
            changeDateView.bottomAnchor.constraint(equalTo: topUIStackView.bottomAnchor)
        ])
        dateLabel.heightAnchor.constraint(equalToConstant: 30).isActive = true
    }
    
    private func spacingToNewline(time: Time, completion: @escaping (String) -> Void) {
        doCrawling(time: time) { result in
            if let result = result {
                let components = result.components(separatedBy: " ")
                var modifiedResult = ""
                
                for (index, component) in components.enumerated() {
                    if !(component == "Kcal" || component == "g") && (index > 0 && !components[index - 1].hasSuffix(" ")) {
                        modifiedResult += "\n" + component
                    } else if index == 0 {
                        modifiedResult += "" + component
                    } else {
                        modifiedResult += " " + component
                    }
                }
                completion(modifiedResult)
            } else {
                print("Crawling failed.")
                completion("")
            }
        }
    }
    
                                                 
    
    private func doCrawling(time: Time, completion: @escaping (String?) -> Void) {
        Task {
            do {
                let result = try await crawling(time: time)
                completion(result)
            } catch {
                print("Error: \(error)")
                completion(nil)
            }
        }
    }
    
    private func crawling(time: Time) async throws -> String {
        do {
            let url = URL(string: "https://dorm.chungbuk.ac.kr/home/sub.php?menukey=20041")!
            let html = try await String(contentsOf: url)
            let document = try SwiftSoup.parse(html)
            let trElement = try document.select("tr#\(formattedCurrentDate(year: true))").first()
            
            if let trElement = trElement {
                let morningTdElements = try trElement.select("td.\(time.rawValue)")
                for morningTd in morningTdElements {
                    return try morningTd.text()
                }
            } else {
                print("TR Element not found.")
            }
        } catch {
            print("Error: \(error)")
        }
        return ""
    }
}
