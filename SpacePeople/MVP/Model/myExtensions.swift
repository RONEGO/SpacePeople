//
//  myExtensions.swift
//  SpacePeople
//
//  Created by Yegor Geronin on 04.03.2022.
//

import Foundation
import UIKit

extension CGFloat {
    public static let headerHeight:CGFloat  = 100
}

extension UIView {
    public var width: CGFloat{      return self.frame.width }
    public var height: CGFloat{     return self.frame.height }
    public var top: CGFloat{        return self.frame.origin.y }
    public var bottom: CGFloat {    return self.frame.origin.y + self.frame.height }
    public var centerX: CGFloat {   return self.frame.origin.x + self.frame.width / 2 }
    public var centerY: CGFloat {   return self.frame.origin.y + self.frame.height / 2 }
}
