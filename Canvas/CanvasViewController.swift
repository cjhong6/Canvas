//
//  CanvasViewController.swift
//  Canvas
//
//  Created by Chengjiu Hong on 10/14/18.
//  Copyright © 2018 Chengjiu Hong. All rights reserved.
//

import UIKit

class CanvasViewController: UIViewController {
    @IBOutlet weak var dead: UIImageView!
    @IBOutlet weak var happy: UIImageView!
    @IBOutlet weak var happy2: UIImageView!
    @IBOutlet weak var sad: UIImageView!
    @IBOutlet weak var tongue: UIImageView!
    @IBOutlet weak var wink: UIImageView!
    
    

    @IBOutlet weak var trayView: UIView!
    var trayOriginalCenter: CGPoint!
    var trayDownOffset: CGFloat!
    var trayUp: CGPoint!
    var trayDown: CGPoint!
    var newlyCreatedFace: UIImageView!
    var newlyCreatedFaceOriginalCenter: CGPoint!

    override func viewDidLoad() {
        super.viewDidLoad()
        trayDownOffset = 190
        trayUp = trayView.center // The initial position of the tray
        trayDown = CGPoint(x: trayView.center.x ,y: trayView.center.y + trayDownOffset) // The position of the tray transposed down
    }
    
    @IBAction func onPanTray(_ sender: UIPanGestureRecognizer) {
        let translation = sender.translation(in: view)
        let velocity = sender.velocity(in: view)

        //gesture state
        if sender.state == UIGestureRecognizer.State.began{
            NSLog("begin")
            trayOriginalCenter = trayView.center
        } else if sender.state == UIGestureRecognizer.State.changed{
            NSLog("change")
            trayView.center = CGPoint(x: trayOriginalCenter.x, y: trayOriginalCenter.y + translation.y)
        }else if sender.state == UIGestureRecognizer.State.ended{
            NSLog("end")
            if (velocity.y > 0){
                UIView.animate(withDuration: 0.2) {
                    self.trayView.center = self.trayDown
                }
            }else{
                UIView.animate(withDuration: 0.2) {
                    self.trayView.center = self.trayUp
                }
            }
        }
    }
    
    @IBAction func didPanFace(_ sender: UIPanGestureRecognizer) {
        let translation = sender.translation(in: view)
        
        //gesture state
        if sender.state == UIGestureRecognizer.State.began{
            let imageView = sender.view as! UIImageView
            newlyCreatedFace = UIImageView(image: imageView.image)
            view.addSubview(newlyCreatedFace)
            newlyCreatedFace.center = imageView.center
            newlyCreatedFace.center.y += trayView.frame.origin.y
            newlyCreatedFaceOriginalCenter = newlyCreatedFace.center
            
            let panGestureRecognizer = UIPanGestureRecognizer(target: self, action: #selector(didPan(sender:)))
            newlyCreatedFace.isUserInteractionEnabled = true
            newlyCreatedFace.addGestureRecognizer(panGestureRecognizer)
            
        } else if sender.state == UIGestureRecognizer.State.changed{
            newlyCreatedFace.center = CGPoint(x: newlyCreatedFaceOriginalCenter.x + translation.x, y: newlyCreatedFaceOriginalCenter.y + translation.y)
            
        }else if sender.state == UIGestureRecognizer.State.ended{

        }
    }
    
    @objc func didPan(sender: UIPanGestureRecognizer){
        let translation = sender.translation(in: view)
        
        //gesture state
        if sender.state == UIGestureRecognizer.State.began{
            newlyCreatedFace = sender.view as? UIImageView // to get the face that we panned on.
            newlyCreatedFaceOriginalCenter = newlyCreatedFace.center // so we can offset by translation later.
            
            UIView.animate(withDuration: 0.2) {
                self.newlyCreatedFace.transform = CGAffineTransform(scaleX: 1.3,y: 1.3)
            }
        } else if sender.state == UIGestureRecognizer.State.changed{
            newlyCreatedFace.center = CGPoint(x: newlyCreatedFaceOriginalCenter.x + translation.x, y: newlyCreatedFaceOriginalCenter.y + translation.y)
        }else if sender.state == UIGestureRecognizer.State.ended{
            UIView.animate(withDuration: 0.2) {
                self.newlyCreatedFace.transform = CGAffineTransform(scaleX: 1,y: 1)
            }
        }
        
    }
    
    
    
}
