//
//  KingFisherViewController.swift
//  Figma
//
//  Created by 方仕賢 on 2022/3/15.
//

import UIKit
import SwiftyDraw

class SwiftyDrawViewController: UIViewController {
    let drawView = SwiftyDrawView(frame: CGRect(x: 30, y: 100, width: 370, height: 650))

    @IBOutlet weak var chooseColorButton: UIButton!
    @IBOutlet weak var colorView: UIView!
    
    var currentColor = Color(.black)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        chooseColor()
       
        drawView.layer.shadowOffset = CGSize(width: 5, height: -5)
        drawView.layer.shadowRadius = 10
        drawView.layer.shadowOpacity = 20
        drawView.backgroundColor = .white
        drawView.brush.width = 5
        drawView.brush.color = Color(UIColor(red: 0, green: 0, blue: 1, alpha: 1))
        view.addSubview(drawView)
    }
    
   
    @IBAction func useBrush(_ sender: Any) {
        drawView.brush = Brush()
        drawView.brush.width = 5
        drawView.brush.color = currentColor
    }
    
    func chooseColor(){
        var actions = [UIAction]()
        let colorNames = ["Black", "White", "Red", "Orange", "Yellow", "Green", "Blue", "Purple", "Gray"]
        let colors = [UIColor.black, UIColor.white, UIColor.red, UIColor.orange, UIColor.yellow, UIColor.green, UIColor.blue, UIColor.purple, UIColor.gray]
        
        for i in 0...colors.count-1 {
            actions.append(UIAction(title: colorNames[i], handler: { action in
                self.colorView.backgroundColor = colors[i]
                self.drawView.brush.color = Color(colors[i])
                self.currentColor = Color(colors[i])
            }))
        }
        
        chooseColorButton.showsMenuAsPrimaryAction = true
        chooseColorButton.menu = UIMenu(children: actions)
    }
    
    
    @IBAction func erase(_ sender: Any) {
        drawView.brush.color = Color(.white)
        drawView.brush.width = 10
    }
    
    
    @IBAction func clear(_ sender: Any) {
        
        let alert = UIAlertController(title: "Clear All", message: "Do you want to clear the board?", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Yes", style: .default, handler: { alert in
            self.drawView.clear()
            
        }))
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        
        present(alert, animated: true, completion: nil)
    }
    
    
    @IBAction func redo(_ sender: Any) {
        drawView.undo()
    }
    
}
