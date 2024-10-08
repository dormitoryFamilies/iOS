//
//  YourChattingTableViewCell.swift
//  dormitoryFamiles
//
//  Created by leehwajin on 2024/07/21.
//

import UIKit
import SnapKit
import Kingfisher

class YourChattingTableViewCell: UITableViewCell, ConfigUI {
    
    let circleView = UIImageView(image: UIImage(named: "chattingDetailCircleGray"))
    
    var profileImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.layer.cornerRadius = 20
        imageView.clipsToBounds = true
        return imageView
    }() {
        didSet {
            if let newImageView = profileImageView.image {
                oldValue.image = newImageView
            }
        }
    }
    
    let nicknameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.button
        return label
    }()
    
    let messageLabel: RoundLabel = {
        let label = RoundLabel(top: 8, left: 16, bottom: 8, right: 16)
        label.layer.cornerRadius = 28
        label.backgroundColor = .gray1
        label.numberOfLines = 0
        label.font = .body1
        return label
    }()
    
    let timeLabel: UILabel = {
        let label = UILabel()
        label.textColor = .lightGray
        label.font = FontManager.small1()
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        addComponents()
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func addComponents() {
        contentView.addSubview(profileImageView)
        contentView.addSubview(nicknameLabel)
        contentView.addSubview(messageLabel)
        contentView.addSubview(timeLabel)
        contentView.addSubview(circleView)
    }
    
    func setConstraints() {
        profileImageView.snp.makeConstraints {
            $0.top.equalToSuperview().offset(10)
            $0.leading.equalToSuperview()
            $0.width.height.equalTo(40)
        }
        
        nicknameLabel.snp.makeConstraints {
            $0.top.equalTo(profileImageView)
            $0.leading.equalTo(profileImageView.snp.trailing).offset(10)
            $0.trailing.lessThanOrEqualToSuperview().offset(-15)
        }
        
        circleView.snp.makeConstraints {
            $0.bottom.equalTo(profileImageView.snp.bottom).inset(3.5)
            $0.leading.equalTo(nicknameLabel.snp.leading)
        }
        
        messageLabel.snp.makeConstraints {
            $0.top.equalTo(circleView.snp.top)
            $0.leading.equalTo(circleView.snp.trailing)
            $0.trailing.lessThanOrEqualToSuperview().offset(-50)
            $0.bottom.equalToSuperview().inset(10)
        }
        
        timeLabel.snp.makeConstraints {
            $0.leading.equalTo(messageLabel.snp.trailing).offset(8)
            $0.bottom.equalTo(messageLabel.snp.bottom)
        }
    }
    
    func configure(with message: ChatMessage) {
        messageLabel.text = message.chatMessage
        timeLabel.text = DateUtility.formatTime(message.sentTime)
        nicknameLabel.text = message.memberNickname
    }
}
