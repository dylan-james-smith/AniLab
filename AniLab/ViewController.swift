//
//  ViewController.swift
//  AniLab
//
//  Created by Dylan Smith on 3/21/16.
//  Copyright © 2016 com.heydylan. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet var parentView: UIView!
    @IBOutlet var trayView: UIView!
    @IBOutlet weak var arrow: UIImageView!
    
    var flippedUp: Bool?
    var trayOriginalCenter: CGPoint!
    var trayCenterWhenOpen: CGPoint?
    var trayCenterWhenClosed: CGPoint?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        trayCenterWhenOpen = CGPoint(x: trayView.center.x, y: trayView.center.y - 150)
        trayCenterWhenClosed = CGPoint(x: trayView.center.x, y: trayView.center.y)
        flipArrow("flipUp")
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func flipArrow(direction: String = ""){
        let pi: CGFloat!
        if direction == "left" || direction == "flipUp" || direction == "counterClockwise"{
            pi = CGFloat(-3.14159265358979)
            flippedUp = true
        }else{
            pi = CGFloat(M_PI)
            flippedUp = false
        }
        arrow.transform = CGAffineTransformRotate(arrow.transform, pi)
        }

    @IBAction func onTrayTap(sender: UITapGestureRecognizer) {
        if self.trayView.center == trayCenterWhenOpen {
            UIView.animateWithDuration(0.4, animations: { () -> Void in
                self.trayView.center = self.trayCenterWhenClosed!
                self.flipArrow("flipUp")
            })
        }else if self.trayView.center == trayCenterWhenClosed {
            UIView.animateWithDuration(0.4, animations: { () -> Void in
                self.trayView.center = self.trayCenterWhenOpen!
                self.flipArrow()
            })
        }
    }
    
    @IBAction func onTrayPan(pan: UIPanGestureRecognizer) {
        
        let velocity = pan.velocityInView(trayView).y
        let translation = pan.translationInView(parentView)
        
        if pan.state == UIGestureRecognizerState.Began {
            trayOriginalCenter = trayView.center
        
        } else if pan.state == UIGestureRecognizerState.Changed {
            trayView.center = CGPoint(x: trayOriginalCenter.x, y: trayOriginalCenter.y + translation.y)
            
        } else if pan.state == UIGestureRecognizerState.Ended {
            
            if velocity > 0 {
                UIView.animateWithDuration(0.8, delay: 0, usingSpringWithDamping: 0.8, initialSpringVelocity: 8, options: [], animations: { () -> Void in
                    self.trayView.center = self.trayCenterWhenClosed!
                    if self.flippedUp == false {
                        self.flipArrow("flipUp")
                    }
                    }, completion: { (Bool) -> Void in
                })
            }else if velocity < 0 {
                UIView.animateWithDuration(0.8, delay: 0, usingSpringWithDamping: 0.8, initialSpringVelocity: 8, options: [], animations: { () -> Void in
                    self.trayView.center = self.trayCenterWhenOpen!
                    if self.flippedUp == true {
                        self.flipArrow()
                    }
                    }, completion: { (Bool) -> Void in
                })
                
            }
        }
    }
    
    
}

