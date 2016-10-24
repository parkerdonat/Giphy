//
//  ViewController.swift
//  GifyDemo
//
//  Created by Parker Donat on 10/23/16.
//  Copyright © 2016 Parker Donat. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var gifWebView: UIWebView!
    @IBOutlet weak var giphySearchTextField: UITextField!
    let giphyAPI = Giphy(apiKey: Giphy.PublicBetaAPIKey)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.giphySearchTextField.delegate = self
        giphyAPI.translate("Cats", rating: nil) { gif, err in
            let findURL = gif?.gifMetadataForType(Giphy.Gif.ImageVersion.Original, still: false).URL
            let gifURL = NSURLRequest(URL: findURL!)
            self.gifWebView.loadRequest(gifURL)
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func searchButtonPressed(sender: AnyObject) {
        if self.giphySearchTextField.text?.characters.count > 0 {
            giphyAPI.translate("\(self.giphySearchTextField.text)", rating: nil) { gif, err in
                dispatch_async(dispatch_get_main_queue(), { () -> Void in
                    let findURL = gif?.gifMetadataForType(Giphy.Gif.ImageVersion.Original, still: false).URL
                    let gifURL = NSURLRequest(URL: findURL!)
                    self.gifWebView.loadRequest(gifURL)
                })
            }
        }
    }
    
    
    func textFieldDidEndEditing(textField: UITextField) {
        
    }
    
}

