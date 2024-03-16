//
//  UIColorExtension.swift
//  dormitoryFamiles
//
//  Created by leehwajin on 2024/01/17.
//


import UIKit
extension UIColor {
   
    class var background: UIColor? { return UIColor(named: "background") }
    
    class var gray0: UIColor? { return UIColor(named: "gray0") }
   
    class var gray1: UIColor? { return UIColor(named: "gray1") }
    
    class var gray2: UIColor? { return UIColor(named: "gray2") }
    
    class var gray3: UIColor? { return UIColor(named: "gray3") }
    
    class var gray4: UIColor? { return UIColor(named: "gray4") }
    
    class var gray5: UIColor? { return UIColor(named: "gray5") }
    
    class var point: UIColor? { return UIColor(named: "point") }
    
    class var primary: UIColor? { return UIColor(named: "primary") }
    
    class var primaryLight: UIColor? { return UIColor(named: "primaryLight") }
    
    class var primaryMid: UIColor? { return UIColor(named: "primaryMid") }
    
    class var secondary: UIColor? { return UIColor(named: "secondary") }
    
    /// #191919
    static let blackYak = UIColor.init(hex: "#191919")
    
    // MARK: UIColor를 HEX 값으로 지정할 수 있게 해줌
    convenience init(hex: String) {
        let scanner = Scanner(string: hex) // 문자 파서역할을 하는 클래스
        _ = scanner.scanString("#")  // scanString은 iOS13 부터 지원
        
        var rgb: UInt64 = 0
        scanner.scanHexInt64(&rgb)
        
        let r = Double((rgb >> 16) & 0xFF) / 255.0
        let g = Double((rgb >> 8) & 0xFF) / 255.0
        let b = Double((rgb >> 0) & 0xFF) / 255.0
        self.init(red: CGFloat(r), green: CGFloat(g), blue: CGFloat(b), alpha: 1)
    }
}

