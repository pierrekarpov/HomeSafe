//
//  BACGraphView.swift
//  HomeSafe
//
//  Created by Pierre Karpov on 10/3/15.
//  Copyright © 2015 PierreKarpov. All rights reserved.
//

import UIKit

class BACGraphView: UIView {
    
    let color = UIColor.blueColor()
    let safeColor = UIColor.greenColor()
    let lineWidth = CGFloat(0.25)
    let lineWidthLarge = CGFloat(2.0)
    let dataPoints = [(0.0, 0.011), (0.5, 0.018), (1.0, 0.035),
                      (1.5, 0.027), (2.0, 0.020), (2.5, 0.013),
                      (3.0, 0.0), (3.5, 0.011), (4.0, 0.011),
                      (4.5, 0.05), (5.0, 0.035)]
    
    let originXFactor = 0.08333333333 // Double(1/12)
    let originYFactor = 0.85714285714 //Double(12/14)
    let xUnitFactor = 0.16666666666 //Double(1/6)
    let yUnitFactor = 0.07142857142 //Double(1/14)

    override func drawRect(rect: CGRect) {
        
        self.layer.sublayers = nil
        
        drawVerticalLines()
        drawHorizontalLines()
        drawDataPoints()
    }

    
    func drawLineFromPoint(start : CGPoint, toPoint end:CGPoint, ofColor lineColor: UIColor, ofLineWidth lineWidth: CGFloat, inView view:UIView) {
        
        //design the path
        let path = UIBezierPath()
        path.moveToPoint(start)
        path.addLineToPoint(end)
        
        //design path in layer
        let shapeLayer = CAShapeLayer()
        shapeLayer.path = path.CGPath
        shapeLayer.strokeColor = lineColor.CGColor
        shapeLayer.lineWidth = lineWidth
        
        view.layer.addSublayer(shapeLayer)
    }

    func drawVerticalLines() {
        let windowWidth = self.frame.size.width
        let verticalLineXValues = [windowWidth/12, windowWidth*3/12, windowWidth*5/12,
            windowWidth*7/12, windowWidth*9/12, windowWidth*11/12]
        
        for i in 0..<verticalLineXValues.count {
            let startPoint = CGPointMake(verticalLineXValues[i], 0)
            let endPoint = CGPointMake(verticalLineXValues[i], self.frame.height)
            if (i == 0) {
                drawLineFromPoint(startPoint, toPoint: endPoint, ofColor: color, ofLineWidth: lineWidthLarge,  inView: self)
            } else {
                drawLineFromPoint(startPoint, toPoint: endPoint, ofColor: color, ofLineWidth: lineWidth,  inView: self)
            }
        }
    }
    
    func drawHorizontalLines() {
        let windowHeight = self.frame.size.height
        let horizontalLineYValues = [windowHeight/14, windowHeight*2/14, windowHeight*3/14,
            windowHeight*4/14, windowHeight*5/14, windowHeight*6/14,
            windowHeight*7/14, windowHeight*8/14, windowHeight*9/14,
            windowHeight*10/14, windowHeight*11/14, windowHeight*12/14,
            windowHeight*13/14]
        
        for i in 0..<horizontalLineYValues.count {
            let startPoint = CGPointMake(0, horizontalLineYValues[i])
            let endPoint = CGPointMake(self.frame.width, horizontalLineYValues[i])
            if (i == 1 || i == 6 || i == 11) {
                drawLineFromPoint(startPoint, toPoint: endPoint, ofColor: color, ofLineWidth: lineWidthLarge,  inView: self)
            } else if i == 9 {
                drawLineFromPoint(startPoint, toPoint: endPoint, ofColor: safeColor, ofLineWidth: lineWidthLarge,  inView: self)
            } else {
                drawLineFromPoint(startPoint, toPoint: endPoint, ofColor: color, ofLineWidth: lineWidth,  inView: self)
            }
        }
    }
    
    func drawDataPoints() {
        let pointsToDraw = convertDataPoints(dataPoints)
        let kRadius = CGFloat(4);
        
        for p in pointsToDraw {
            let  rect = CGRectMake(p.x - kRadius, p.y - kRadius, 2 * kRadius, 2 * kRadius);
            let pPath = UIBezierPath(ovalInRect: rect)
            UIColor.whiteColor().setFill()
            pPath.fill()
            
            //Set your stroke color
            let strokeColor: UIColor = UIColor.redColor()
            strokeColor.setStroke()
            
            pPath.lineWidth = 2.0
            pPath.stroke()
        }
    }
    
    
    func convertDataPoints(dataPoints: [(Double, Double)]) -> [CGPoint] {
        var result = [CGPoint]()
        
        let origin = CGPointMake(self.frame.width * CGFloat(originXFactor), self.frame.height * CGFloat(originYFactor))
        
        for i in 0..<dataPoints.count {
            let (x, y) = dataPoints[i]
            var convertedX = CGFloat(x) * (self.frame.size.width * CGFloat(xUnitFactor))
            var convertedY = CGFloat(100) * CGFloat(y) * (self.frame.size.height * CGFloat(yUnitFactor))
            
            convertedX = convertedX + origin.x
            convertedY = origin.y - convertedY
            
            result.append(CGPointMake(convertedX, convertedY))
        }
        
        return result
    }
    
    
    
    
    
    
}
