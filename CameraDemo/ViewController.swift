//
//  ViewController.swift
//  CameraDemo
//
//  Created by Higher Visibility on 26/12/2017.
//  Copyright © 2017 Higher Visibility. All rights reserved.
//

import UIKit
import MessageUI

class ViewController: UIViewController,UIImagePickerControllerDelegate,UINavigationControllerDelegate,MFMailComposeViewControllerDelegate {

    @IBOutlet weak var camera: UIButton!
    @IBOutlet weak var photoLibrary: UIButton!
    @IBOutlet weak var imageDisplay: UIImageView!
    
    var image = UIImage()
    var data = NSData()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    @IBAction func cameraAction(sender: UIButton) {
        
        let picker = UIImagePickerController()
        picker.delegate = self
        picker.sourceType = .Camera
        self.presentViewController(picker, animated: true, completion: nil)
        
    }
    
    @IBAction func photoLibraryAction(sender: UIButton) {
        
        let picker = UIImagePickerController()
        picker.delegate = self
        picker.sourceType = .PhotoLibrary
        self.presentViewController(picker, animated: true, completion: nil)

    }
    
    @IBAction func uploadPressed(sender: UIButton) {
        
                if MFMailComposeViewController.canSendMail() == true{
                    
                    let emailVC = MFMailComposeViewController()
                    emailVC.addAttachmentData(self.data, mimeType: "abc", fileName: "xyz.png")
                    let message = "Hi"
                    
                    emailVC.setSubject("Booking Confirmation")
                    emailVC.setMessageBody(message, isHTML: false)
                    emailVC.mailComposeDelegate = self
                    self.presentViewController(emailVC, animated: true) { () -> Void in
                        
                    }
                }
            
        
    }

    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
        
        self.image = info[UIImagePickerControllerOriginalImage] as! UIImage
       // let data = UIImageJPEGRepresentation(image, 1.0)
        self.data = UIImageJPEGRepresentation(self.image,0.25)!
        self.imageDisplay.image = UIImage(data: self.data)
        dismissViewControllerAnimated(true, completion: nil)
        
        
    }
    func mailComposeController(controller: MFMailComposeViewController,didFinishWithResult result: MFMailComposeResult, error: NSError?) {
    
        
        switch result{
        case MFMailComposeResultCancelled:
            print("Mail cancelled")
        case MFMailComposeResultSaved:
            print("Mail saved")
        case MFMailComposeResultSent:
            print("Mail sent")
        case MFMailComposeResultFailed:
            print("Mail sent failure: %@", [error!.localizedDescription])
        default:
            print("back")
        }
        
        controller.dismissViewControllerAnimated(true) { () -> Void in
            
            
        }
    
    }
   
    
    
    

}

