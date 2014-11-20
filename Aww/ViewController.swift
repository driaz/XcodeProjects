//
//  ViewController.swift
//  Aww
//
//  Created by Daniel Riaz on 11/16/14.
//  Copyright (c) 2014 Daniel Riaz. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var scrollView: UIScrollView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let manager = AFHTTPRequestOperationManager()
        
        manager.GET( "http://www.reddit.com/r/aww/hot.json",
            parameters: nil,
            success: { (operation: AFHTTPRequestOperation!,responseObject: AnyObject!) in
                println("JSON: " + responseObject.description)
                
                if let dataArray = responseObject.valueForKey("data") as? [AnyObject] {
                    self.scrollView.contentSize = CGSizeMake(320, CGFloat(320*dataArray.count))
                    for var i = 0; i < dataArray.count; i++ {
                        let dataObject: AnyObject = dataArray[i]
                        if let imageURLString = dataObject.valueForKeyPath("images.standard_resolution.url") as? String {
                            println("image " + String(i) + " URL is " + imageURLString)
                            let imageData =  NSData(contentsOfURL: NSURL(string: imageURLString)!)
                            let imageView = UIImageView(image: UIImage(data: imageData!)!)
                            imageView.frame = CGRectMake(0, CGFloat(320*i), 320, 320)
                            self.scrollView.addSubview(imageView)
                        }
                    }
                }
                
                
                
            },
            failure: { (operation: AFHTTPRequestOperation!,error: NSError!) in
                println("Error: " + error.localizedDescription)
        })
        
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

