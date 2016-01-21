//
//  ImagePickerViewController.swift
//  PKImageMatrixCropper
//
//  Created by Pavan Kataria on 10/01/2016.
//  Copyright © 2016 Pavan Kataria. All rights reserved.
//

import UIKit

enum SegueIdentifiers: String {
    case ImageViewer = "ShowImageViewer"
}

class ImagePickerViewController: UIViewController {
    @IBOutlet weak var pickedImage: UIImageView!
    @IBOutlet weak var rows: UITextField!
    @IBOutlet weak var cols: UITextField!
    @IBOutlet weak var maintainAspect: UISwitch!

    var image: UIImage {
        set {
            pickedImage.image = newValue
            self.navigationItem.rightBarButtonItem?.enabled = true
        }
        get {
            if let image = pickedImage.image {
                return image
            }
            assertionFailure("image is nil")
            return UIImage()
        }
    }
    var images = [UIImage]()
    let imagePicker = UIImagePickerController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let pickerButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.Camera, target: self, action: "displayPicker")

        let processButton = UIBarButtonItem(title: "Process", style: UIBarButtonItemStyle.Done, target: self, action: Selector("process"))
        processButton.enabled = false
        self.navigationItem.leftBarButtonItem? = pickerButton
        self.navigationItem.rightBarButtonItem? = processButton

        imagePicker.delegate = self
        displayHowToUseMessage()
    }
    
    func process(){
        if rows.text?.characters.count == 0 {
            rows.text = "2"
        }
        if cols.text?.characters.count == 0 {
            cols.text = "2"
        }
        var rowsNum: Int = 2
        var colsNum: Int = 2
        if let text = rows.text {
            rowsNum = Int(text)!
        }
        if let text = cols.text {
            colsNum = Int(text)!
        }

        // You can use this method to chop by four
        if maintainAspect.on {
            images = image.cropWithMatrixResize((rowsNum, colsNum))
        }
        else {
            images = image.cropWithMatrix((rowsNum, colsNum))
        }
        performSegueWithIdentifier(SegueIdentifiers.ImageViewer.rawValue, sender: self)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func displayHowToUseMessage(){
        let alertController = UIAlertController(title: "How to use", message: "Pick an image,\nspecify a small number for both rows and columns,\nthen tap process", preferredStyle: UIAlertControllerStyle.Alert)
        let action = UIAlertAction(title: "Ok", style: UIAlertActionStyle.Default, handler: nil)
        alertController.addAction(action)
        presentViewController(alertController, animated: true, completion: nil)
    }

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == SegueIdentifiers.ImageViewer.rawValue {
            let controller = segue.destinationViewController as! ImageCollectionViewController
            controller.images = images
        }
    }
}
extension ImagePickerViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func displayPicker(){
        imagePicker.allowsEditing = true
        imagePicker.sourceType = .PhotoLibrary
        presentViewController(imagePicker, animated: true, completion: nil)
    }
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
        if let pickedImage = info[UIImagePickerControllerEditedImage] as? UIImage {
            self.pickedImage.contentMode = .ScaleAspectFill
            self.image = pickedImage
        }
        dismissViewControllerAnimated(true, completion: nil)
    }
}