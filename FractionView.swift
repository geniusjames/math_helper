//
//  FractionView.swift
//  Math Helper
//
//  Created by Geniusjames on 25/01/2022.
//

import Foundation
import UIKit

class FractionView: UIView {
    var font: UIFont = UIFont.systemFont(ofSize: 16) {
        didSet { self.setNeedsDisplay() }
    }
    var numerator: Int = 1 {
        didSet { self.setNeedsDisplay() }
    }
    var denominator: Int = 2 {
        didSet { self.setNeedsDisplay() }
    }
    var spacing: CGFloat = 5 {
        didSet { self.setNeedsDisplay() }
    }

    override func draw(_ rect: CGRect) {
        let numString = "\(numerator)" as NSString
        let numWidth = numString.size(withAttributes: [.font: font]).width
        let denomString = "\(denominator)" as NSString
        let denomWidth = denomString.size(withAttributes: [.font: font]).width
        let numX: CGFloat
        let denomX: CGFloat

        if numWidth <= denomWidth {
            denomX = 0
            numX = (denomWidth - numWidth) / 2
        } else {
            denomX = (numWidth - denomWidth) / 2
            numX = 0
        }

        numString.draw(at: CGPoint(x: numX, y: 0), withAttributes: [.font: font])
        let path = UIBezierPath()
        path.move(to: CGPoint(x: 0, y: font.lineHeight + spacing))
        path.addLine(to: CGPoint(x: self.frame.maxX, y: font.lineHeight + spacing))
        UIColor.black.setStroke()
        path.lineWidth = 1
        path.stroke()
        denomString.draw(at: CGPoint(x: denomX, y: font.lineHeight + spacing * 2), withAttributes: [.font: font])
    }
}
