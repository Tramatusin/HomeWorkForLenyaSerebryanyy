//
//  ToolsBar.swift
//  DrawWithLenya
//
//  Created by Виктор Поволоцкий on 27.07.2021.
//

import Foundation
import UIKit

class ToolsForDraw{
    
    func callWantedDrawFunc(tool: ModeDraw, line: [CGPoint]) -> UIBezierPath{
        switch tool {
        case .circle:
            return drawCircle(line: line)
        case .rect:
            return drawRectangle(line: line)
        case .triangle:
            return drawTriangle(line: line)
        case .rectWithCornRadius:
            return drawRectangleWithCornerRadius(line: line)
        case .line:
            return drawLine(line: line)
        case .straight:
            return drawStraight(line: line)
        }
    }
    
    func drawTriangle(line :[CGPoint])->UIBezierPath{
        guard let firstP = line.first, let secondP = line.last else {
            return UIBezierPath.init()
        }
        let rect = CGRect(x: firstP.x, y: firstP.y, width: secondP.x - firstP.x , height:  secondP.y - firstP.y)
        
        let path = UIBezierPath()
        let quar = calculateQuarter(firstP: firstP, secondP: secondP)
        
        path.move(to: firstP)
        path.addLine(to: CGPoint(x: firstP.x + quar.widthCoef * rect.width, y: firstP.y))
        path.addLine(to: CGPoint(x: rect.origin.x + quar.widthCoef * rect.width/2, y: firstP.y + quar.heightCoef * rect.height))
        path.close()
        
        let color = UIColor.red
        color.setStroke()
        path.stroke()
        return path
    }
    
    func drawRectangleWithCornerRadius(line :[CGPoint])->UIBezierPath{
        guard let firstP = line.first, let secondP = line.last else {
            return UIBezierPath.init()
        }
        let rectForCircle = CGRect(x: firstP.x, y: firstP.y, width: secondP.x - firstP.x , height:  secondP.y - firstP.y)
        let quarter = calculateQuarter(firstP: firstP, secondP: secondP)
        
        let path = UIBezierPath.init(roundedRect:
                    CGRect.init(x: firstP.x, y: firstP.y,
                                width: quarter.widthCoef * rectForCircle.width,
                                height: quarter.heightCoef * rectForCircle.height),
                                     cornerRadius: 20)
        
        let color = UIColor.red
        color.setStroke()
        path.stroke()
        return path
    }
    
    func drawStraight(line :[CGPoint])->UIBezierPath{
        guard let firstP = line.first, let secondP = line.last else {
            return UIBezierPath.init()
        }
        
        let path = UIBezierPath.init()
        
        path.move(to: firstP)
        path.addLine(to: secondP)
        
        let color = UIColor.red
        color.setStroke()
        path.stroke()
        return path
    }
    
    func drawLine(line :[CGPoint])->UIBezierPath{
        let path = UIBezierPath.init()
        for (i,point) in line.enumerated(){
            if i == 0{
                path.move(to: point)
            }else{
                path.addLine(to: point)
            }
        }
        
        let color = UIColor.red
        color.setStroke()
        path.stroke()
        return path
    }
    
    func drawRectangle(line :[CGPoint])->UIBezierPath{
        guard let firstP = line.first, let secondP = line.last else {
            return UIBezierPath.init()
        }
        let rectForCircle = CGRect(x: firstP.x, y: firstP.y, width: secondP.x - firstP.x , height:  secondP.y - firstP.y)
        let quarter = calculateQuarter(firstP: firstP, secondP: secondP)
        
        let path = UIBezierPath.init(rect: CGRect.init(x: firstP.x, y: firstP.y,
                                    width: quarter.widthCoef * rectForCircle.width,
                                    height: quarter.heightCoef * rectForCircle.height))
        
        let color = UIColor.red
        color.setStroke()
        path.stroke()
        return path
    }
    
    func drawCircle(line :[CGPoint])->UIBezierPath{
        guard let firstP = line.first, let secondP = line.last else {
            return UIBezierPath.init()
        }
        let rectForCircle = CGRect(x: firstP.x, y: firstP.y, width: secondP.x - firstP.x , height:  secondP.y - firstP.y)
        
        let quarter = calculateQuarter(firstP: firstP, secondP: secondP)
        
        let path = UIBezierPath.init(ovalIn: CGRect.init(x: firstP.x, y: firstP.y,
                                     width: quarter.widthCoef * rectForCircle.width,
                                     height: quarter.heightCoef * rectForCircle.height))
        
        let color = UIColor.red
        color.setStroke()
        path.stroke()
        return path
    }
    
    func CGPointDistanceSquared(from: CGPoint, to: CGPoint) -> CGFloat {
        return (from.x - to.x) * (from.x - to.x) + (from.y - to.y) * (from.y - to.y)
    }
    
    func CGPointDistance(from: CGPoint, to: CGPoint) -> CGFloat {
        return sqrt(CGPointDistanceSquared(from: from, to: to))
    }
    
    func calculateQuarter(firstP: CGPoint, secondP: CGPoint)->(widthCoef: CGFloat,heightCoef: CGFloat){
        if secondP.x > firstP.x && secondP.y > firstP.y{
            //4 четверть
            return (1,1)
        }else if secondP.x > firstP.x && secondP.y < firstP.y{
            return (1,-1)
            //1 четверть
        }else if secondP.x < firstP.x && secondP.y < firstP.y{
            return (-1,-1)
            //2 четверть
        }else{
            return (-1,1)
            // 3 четверть
        }
    }
    
}
