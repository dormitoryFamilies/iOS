//
//  BulluetinBoardCollectionViewCell.swift
//  dormitoryFamiles
//
//  Created by leehwajin on 2024/01/27.
//

import UIKit

class BulluetinBoardCollectionViewCell: UICollectionViewCell {
    var articleId: Int?
    var profileUrl: String?
    var amIWish: Int?
    var status: String?
    var createdDate: String?
    var thumbnailUrl: String?
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var nickName: UILabel!
    
    @IBOutlet weak var viewCount: UILabel!
    @IBOutlet weak var commentCount: UILabel!
    @IBOutlet weak var wishCount: UILabel!
    @IBOutlet weak var content: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}
