//
//  DrawImageView.swift
//  com.powerschool.attachit
//
//  Created by Mike Folcher on 9/14/17.
//  Copyright © 2017 Mike Folcher. All rights reserved.
//

import UIKit

class DrawImageView : UIImageView {
    
    //class variables
    var fingerTouch : UITouch!
    var lineArray : [[CGPoint]] = [[CGPoint]()]
    var lineIndex = -1
    
    //MARK: Drawing Stuff
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        fingerTouch = touches.first! as UITouch
        let lastPoint = fingerTouch.location(in: self)
        
        lineIndex += 1
        lineArray.append([CGPoint]())
        lineArray[lineIndex].append(lastPoint)
        
        print("touch begin")
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        fingerTouch = touches.first! as UITouch
        let currentPoint = fingerTouch.location(in: self)
        
        self.setNeedsDisplay()
        
        lineArray[lineIndex].append(currentPoint)
        print("Touch moved")
        
    }
    
    override func draw(_ rect: CGRect) {
  
        if(lineIndex >= 0){
            let context = UIGraphicsGetCurrentContext()
            context!.setLineWidth(5)
            context!.setStrokeColor((UIColor(red:0.00, green:0.38, blue:0.83, alpha:1.0)).cgColor)
            context!.setLineCap(.round)
            
            var j = 0
            while( j <= lineIndex ){
                context!.beginPath()
                var i = 0
                context?.move(to: lineArray[j][0])
                while(i < lineArray[j].count){
                    context?.addLine(to: lineArray[j][i])
                    i += 1
                }
                
                context!.strokePath()
                j += 1
                
            }
            print("Redrawing")
            
            
        }
    }
    
}
