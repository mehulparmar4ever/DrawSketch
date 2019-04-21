//
//  ViewController.swift
//  Drawing
//
//  Created by mehul on 8/13/18.
//  Copyright © 2018 mehul. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    //MARK:
    //MARK: - Initialise Brush View
    @IBOutlet weak var viewBrushHeader: UIView!
    
    @IBOutlet weak var sliderIncDec: UISlider!
    
    @IBOutlet weak var btnClear: UIButton!
    @IBOutlet weak var btnLine: UIButton!
    @IBOutlet weak var btnLineNiyon: UIButton!
    @IBOutlet weak var btnLineDotted: UIButton!
    @IBOutlet weak var btnErash: UIButton!
    
    @IBOutlet weak var btnDone: UIButton!

    //Draw variables
    @IBOutlet weak var sketchView: SketchView!

    var lineWidth = CGFloat(8.0)
    var lineColor = UIColor.black
    
    //Color Collection
    @IBOutlet weak var collectionColors: UICollectionView!
    var arrColors = [UIColor]()

    // MARK: Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        //Default drawing peroperties..
        sketchView.drawTool         = .pen
        sketchView.drawingPenType   = .normal
        sketchView.lineWidth        = lineWidth
        sketchView.lineColor        = lineColor
        
        self.generateRandomColor()
        
        //You can add done button event.
        //And you can create drawing to image and share/save that image
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

// MARK: Color & Properties
extension ViewController {
    func generateRandomColor() {
        self.arrColors.append(UIColor(hexString: "800080"))
        self.arrColors.append(UIColor(hexString: "FF00FF"))
        self.arrColors.append(UIColor(hexString: "000080"))
        self.arrColors.append(UIColor(hexString: "0000FF"))
        self.arrColors.append(UIColor(hexString: "008080"))
        
        self.arrColors.append(UIColor(hexString: "00FFFF"))
        self.arrColors.append(UIColor(hexString: "008000"))
        self.arrColors.append(UIColor(hexString: "00FF00"))
        self.arrColors.append(UIColor(hexString: "808000"))
        self.arrColors.append(UIColor(hexString: "FFFF00"))
        
        self.arrColors.append(UIColor(hexString: "800000"))
        self.arrColors.append(UIColor(hexString: "FF0000"))
        self.arrColors.append(UIColor(hexString: "000000"))
        self.arrColors.append(UIColor(hexString: "808080"))
        self.arrColors.append(UIColor(hexString: "C0C0C0"))
        self.arrColors.append(UIColor(hexString: "FFFFFF"))
        
        self.updateColor(0)
    }
    
    func updateColor(_ selectedRow:Int?) {
        // handle tap events
        if let selectedRow = selectedRow {
            self.lineColor = self.arrColors[selectedRow]
            self.sliderIncDec.tintColor = self.lineColor
            self.sketchView.lineColor = self.lineColor
        }
        else {
            self.lineColor = self.arrColors[0]
            self.sliderIncDec.tintColor = self.lineColor
            self.sketchView.lineColor = self.lineColor
        }
    }
}


// MARK: Button Actions
extension ViewController {
    @IBAction func btnClearClicked(_ sender: UIButton) {
        sketchView.clear()
    }
    
    @IBAction func btnLineClicked(_ sender: UIButton) {
        sketchView.drawTool = .pen
        sketchView.drawingPenType = .normal
    }
    
    @IBAction func btnErasherClicked(_ sender: UIButton) {
        sketchView.drawTool = .eraser
    }
    
    @IBAction func btnNiyonClicked(_ sender: UIButton) {
        sketchView.drawingPenType = .neon
        sketchView.drawTool = .pen
    }
    
    @IBAction func btnDottedClicked(_ sender: UIButton) {
        sketchView.drawTool = .dotted
        sketchView.drawingPenType = .normal
    }
    
    @IBAction func sliderIncDecValueChanged(_ sender: UISlider) {
        self.lineWidth = CGFloat(sender.value)
        self.sketchView.lineWidth = self.lineWidth
    }
}

// MARK: UICollectionViewDataSource, UICollectionViewDelegate
extension ViewController : UICollectionViewDataSource, UICollectionViewDelegate  {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int{
        return self.arrColors.count

    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell{
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ColorListCell", for: indexPath) as! ColorListCell
        cell.btnColor.tag = indexPath.row
        cell.btnColor.addTarget(self, action: #selector(ViewController.btnColorClick(btnColor:)), for: .touchUpInside)
        cell.contentView.corner(cell.contentView.frame.size.width/2, borderColor: .white, borderWidth: 2.0)
        cell.contentView.backgroundColor = self.arrColors[indexPath.row]
        return cell
    }
    
    @objc func btnColorClick(btnColor : UIButton) {
        let indexPath = IndexPath(item: btnColor.tag, section: 0)
        self.updateColor(indexPath.row)
    }
}

//UIView extension
extension UIView {
    func corner(_ radius: CGFloat, borderColor: UIColor? = nil, borderWidth: CGFloat? = nil) {
        var layer = CALayer()
        layer = self.layer
        layer.masksToBounds = true
        
        // Corner Radius
        layer.cornerRadius = radius
        
        // Border Color
        if let borderColor = borderColor {
            layer.borderColor = borderColor.cgColor
        }
        
        // Border Width
        if let borderWidth = borderWidth {
            layer.borderWidth = borderWidth
        }
    }
}
