//
//  ImageViewController.swift
//  com.powerschool.attachit
//
//  Created by Mike Folcher on 9/13/17.
//  Copyright © 2017 Mike Folcher. All rights reserved.
//

import UIKit

class ImageViewController: UIViewController {
    
    //class variables
    var lastPoint = CGPoint.zero
    let brushWidth: CGFloat = 6.0
    let opacity: CGFloat = 1.0
    var swiped = false
    
    var allowDraw = false
    
    //Outlets
    @IBOutlet weak var imageView: UIImageView!

    @IBOutlet weak var bottomToolBar: UIToolbar!
    @IBOutlet weak var annotateButton: UIBarButtonItem!
    @IBOutlet weak var undoButton: UIBarButtonItem!


    override func viewDidLoad() {
        super.viewDidLoad()
        if let image = self.selectedImage {
            self.imageView.image = image
        }
        self.undoButton.isEnabled = false
        if let data = self.selectedAttachData {
            self.title = data.title
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func annotatePressed(_ sender: Any) {
        self.annotateButton.isEnabled = false
        self.undoButton.isEnabled = true
        self.allowDraw = true
        
    }
    
    @IBAction func undoPressed(_ sender: Any) {
        self.annotateButton.isEnabled = true
        self.undoButton.isEnabled = false
        self.allowDraw = false
        self.lastPoint = CGPoint.zero
        self.swiped = false
        if let image = self.selectedImage {
            self.imageView.image = image
        }
    }
    
    @IBAction func savePressed(_ sender: Any) {
        let attachImage = self.generateAttachmentImage()
        self.imageView.image = attachImage
        //TO DO: Send the data
        
        self.navigationController?.popViewController(animated: true)
        
    }
    
    //MARK: Helper methods
    func generateAttachmentImage() -> UIImage {
        
        //Hide stuff
        self.bottomToolBar.isHidden = true
        
        // Render view to an image
        UIGraphicsBeginImageContext(self.view.frame.size)
        self.view.drawHierarchy(in: self.view.frame,
                                afterScreenUpdates: true)
        let attachImage : UIImage =
            UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        
        //Show stuff
        self.bottomToolBar.isHidden = false
        
        return attachImage
    }
    
    //MARK: Finger drawing take two
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if !self.allowDraw {
            return
        }
        swiped = false
        if let touch = touches.first {
            lastPoint = touch.location(in: self.imageView)
        }
        
    }
    
    func drawLineFrom(fromPoint: CGPoint, toPoint: CGPoint) {
        
        // 1
        UIGraphicsBeginImageContext(imageView.frame.size)
        let context = UIGraphicsGetCurrentContext()
        self.imageView.image?.draw(in: CGRect(x: 0, y: 0, width: imageView.frame.size.width, height: imageView.frame.size.height))
        
        // 2
        if let context = context {
            context.move(to: CGPoint(x: fromPoint.x, y: fromPoint.y))
            context.addLine(to: CGPoint(x: toPoint.x, y: toPoint.y))
        
        
            // 3
            context.setLineCap(.round)
            context.setLineWidth(brushWidth)
            context.setStrokeColor(UIColor.black.cgColor)
            context.setBlendMode(.normal)
        
            // 4
            context.strokePath()
        }
        
        // 5
        self.imageView.image = UIGraphicsGetImageFromCurrentImageContext()
        self.imageView.alpha = opacity
        self.imageView.contentMode = .scaleAspectFill
        UIGraphicsEndImageContext()
        
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        if !self.allowDraw {
            return
        }
        
        // 6
        swiped = true
        if let touch = touches.first {
            let currentPoint = touch.location(in: imageView)
            drawLineFrom(fromPoint: lastPoint, toPoint: currentPoint)
            
            // 7
            lastPoint = currentPoint
        }
        
        
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        if !self.allowDraw {
            return
        }
        
        if !swiped {
            // draw a single point
            drawLineFrom(fromPoint: lastPoint, toPoint: lastPoint)
        }
        
    }

}
