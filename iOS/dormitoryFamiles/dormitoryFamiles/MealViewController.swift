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

class MealViewController: UIViewController {

    private lazy var dateText: UILabel = {
        let label = UILabel()
        label.text = "오늘의 긱식 (\(formattedCurrentDate(year: false)))"
        return label
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
        [dateText, menuStackView].forEach {
            view.addSubview($0)
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
        
        NSLayoutConstraint.activate([
            dateText.topAnchor.constraint(equalTo: view.topAnchor, constant: 100),
            dateText.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            dateText.widthAnchor.constraint(equalToConstant: 500),
            dateText.heightAnchor.constraint(equalToConstant: 50),
            
            menuStackView.topAnchor.constraint(equalTo: dateText.bottomAnchor, constant: 15),
            menuStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            menuStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
            menuStackView.heightAnchor.constraint(equalToConstant: 500),
        ])
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
