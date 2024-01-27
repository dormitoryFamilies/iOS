//
//  bulletinBoardMainViewController.swift
//  dormitoryFamiles
//
//  Created by leehwajin on 2024/01/01.
//

import UIKit

class BulletinBoardMainViewController: UIViewController {
    let cellIdentifier = "BulletinBoardMainTableViewCell"
    let tagScrollView = TagScrollView()
    var tags = ["도와주세요","함께해요","나눔해요","궁금해요","분실신고"]
    @IBOutlet weak var naviCustomView: UIView!
    
    
    override func viewDidLoad() {
       
        setTag()
        getTagMakeButton()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        self.navigationController?.setNavigationBarHidden(true, animated: false)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(true)
        self.navigationController?.setNavigationBarHidden(false, animated: false)
    }
    
    private func setTag() {
        //네비게이션
        let allTagButton = TagButton(title: "전체")
        tagScrollView.tagStackView.addArrangedSubview(allTagButton)
        allTagButton.backgroundColor = UIColor.black
        allTagButton.setTitleColor(UIColor.white, for: .normal)
        allTagButton.layer.borderWidth = 0
        tagLayout()
        allTagButton.addTarget(nil, action: #selector(categoryButtonTapped), for: .touchUpInside)
    }
    
    private func tagLayout() {
        self.view.addSubview(tagScrollView)
        tagScrollView.translatesAutoresizingMaskIntoConstraints = false
        
        let height: CGFloat = self.view.frame.height
        let width: CGFloat = self.view.frame.width
        let figmaHeight: CGFloat = 852
        let figmaWidth: CGFloat = 391
        let heightRatio: CGFloat = height/figmaHeight
        let widthRatio: CGFloat = width/figmaWidth
        NSLayoutConstraint.activate([
            tagScrollView.bottomAnchor.constraint(equalTo: self.naviCustomView.bottomAnchor, constant: -10*heightRatio),
            tagScrollView.leadingAnchor.constraint(equalTo: self.naviCustomView.leadingAnchor, constant: 16*widthRatio),
            tagScrollView.trailingAnchor.constraint(equalTo: self.naviCustomView.trailingAnchor, constant: -16*widthRatio),
            tagScrollView.heightAnchor.constraint(equalToConstant: 32*heightRatio)
        ])
    }
    
    private func makeButton(tag: String)  {
        let tagButton = TagButton(title: tag)
        tagScrollView.tagStackView.addArrangedSubview(tagButton)
        tagButton.addTarget(self, action: #selector(categoryButtonTapped(_:)), for: .touchUpInside)
        tagButton.tag = 4
    }
    
    @objc private func categoryButtonTapped(_ sender: TagButton) {
        
        //(버튼)활성화UI를 비활성화UI로
        for case let button as TagButton in tagScrollView.tagStackView.arrangedSubviews {
            if button.backgroundColor == .black {
                button.changeWhiteColor()
                button.setTitleColor(.black, for: .normal)
                button.layer.borderWidth = 1
            }
        }
        
        guard sender.currentTitle != "전체" else {
            sender.changeOrangeColor()
            sender.setTitleColor(UIColor.white, for: .normal)
            sender.layer.borderWidth = 0
            //page = 0
            // fetchItemList(page: page)
            return
        }
        
        //(버튼)비활성화UI를 활성화UI로
        //categoryNumber = sender.tag
        sender.changeOrangeColor()
        sender.setTitleColor(UIColor.white, for: .normal)
        sender.layer.borderWidth = 0
        
        //해당 상품리스트가 조회되도록
        //page = 0
        //fetchItemList(page: page, categoryNumber: categoryNumber)
    }
    
    private func getTagMakeButton() {
        //찜했던 상품들이 해당하는 카테고리를 버튼으로 만듬
        tags.forEach { tag in
            self.makeButton(tag: tag)
        }
    }
}

