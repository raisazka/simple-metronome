//
//  ViewController.swift
//  Metronome
//
//  Created by Rais on 04/03/20.
//  Copyright © 2020 Rais. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    

    @IBOutlet weak var btnPlus: UIButton!
    @IBOutlet weak var btnMinus: UIButton!
    @IBOutlet weak var instructionLabel: UILabel!
    @IBOutlet weak var beat: UILabel!
    @IBOutlet weak var btnChangeTheme: UIButton!
    @IBOutlet weak var btnSongs: UIButton!
    @IBOutlet weak var arrow: UIImageView!
    @IBOutlet weak var homeTitle: UILabel!
    
    var played = true
    var stopped = false
    var audioPlayer = AVAudioPlayer()
    var metronome = Metronome()
    var themes = ["White", "Blue"]
    var pickerRow = 0
    var theTheme = "White"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setBtnPlusMinusAttribute(btn: btnPlus)
        setBtnPlusMinusAttribute(btn: btnMinus)
        setBtnShadowAndRadius(btn: btnChangeTheme)
        setBtnShadowAndRadius(btn: btnSongs)
        updateBpm()
        metronome.setAnchorPoint(anchorPoint: CGPoint(x: 1,y: 1), view: arrow)
    }
    
    func setBtnShadowAndRadius(btn : UIButton) {
        btn.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.25).cgColor
        btn.layer.shadowOffset = CGSize(width: 0.0, height: 4.0)
        btn.layer.shadowOpacity = 2.0
        btn.layer.shadowRadius = 1.0
        btn.layer.cornerRadius = 20
    }
    
    
    func setBtnPlusMinusAttribute(btn: UIButton) {
        btn.imageView?.contentMode = .scaleAspectFit
        btn.imageEdgeInsets = UIEdgeInsets(top: 45, left:45, bottom: 45, right: 45)
    }
    

    @IBAction func plusClicked(_ sender: Any) {
        metronome.bpm += 1
        updateBpm()
        print("Metronome Beat: \(metronome.bpm)")
    }
    
    @IBAction func minusPressed(_ sender: Any) {
        metronome.bpm -= 1
        updateBpm()
        print("Metronome Beat: \(metronome.bpm)")
    }
    
    private func updateBpm() {
        beat.text = String(Int(metronome.bpm))
        btnSongs.setTitle("Songs with \(Int(metronome.bpm)) BPM", for: .normal)
    }
    
    
    @IBAction func metronomeClicked(_ sender: Any) {
        if played {
            played = false
            instructionLabel.text = InstructionEnum.METRONOME_STOP.rawValue
            metronome.enabled = true
            rotateRight()
            stopped = false
        } else {
            played = true
            instructionLabel.text =     InstructionEnum.METRONOME_PLAY.rawValue;   metronome.enabled = false
            arrow.stopAnimating()
            arrow.layer.removeAllAnimations()
            stopped = true
        }
    }
    
    
    private func rotateRight() {
        UIView.animate(withDuration: 60 / metronome.bpm, animations: {
            self.arrow.transform = CGAffineTransform(rotationAngle: CGFloat(45))
        }, completion: { finished in
            if !self.stopped {
                self.rotateLeft()
            }
        })
    }
    
    private func rotateLeft() {
        UIView.animate(withDuration: 60/metronome.bpm, animations: {
            self.arrow.transform = CGAffineTransform(rotationAngle: CGFloat(0))
        }, completion: { finished in
            if !self.stopped {
                self.rotateRight()
            }
        })
    }
    
    
    @IBAction func btnThemeClicked(_ sender: Any) {
        let alert = UIAlertController(title: "Choose Theme", message: "\n\n\n\n\n\n", preferredStyle: .alert)
        alert.isModalInPresentation = true
        let pickerFrame = UIPickerView(frame: CGRect(x: 5, y: 10, width: 250, height: 170))
        alert.view.addSubview(pickerFrame)
        pickerFrame.dataSource = self
        pickerFrame.delegate = self
        pickerFrame.selectRow(pickerRow, inComponent: 0, animated: true)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { (UIAlertAction) in
            print("You selected ")
        }))
        self.present(alert, animated: true, completion: nil)
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        themes.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return themes[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if row == 0 {
            whiteTheme()
        } else if row == 1 {
            blueTheme()
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destination = segue.destination as? MusicViewController {
            destination.bpm = Int(metronome.bpm)
            destination.theme = theTheme
        }
    }
    
    func blueTheme() {
        view.backgroundColor =  UIColor(red: 0/255.0, green: 0/255.0, blue: 51/255.0, alpha: 1.0)
        homeTitle.textColor = .white
        instructionLabel.textColor = UIColor(red: 191/255.0, green: 164/255.0, blue: 114/255.0, alpha: 1.0)
        btnPlus.tintColor = .white
        beat.textColor = .white
        btnMinus.tintColor = .white
        theTheme = "Blue"
        pickerRow = 1
    }
    
    func whiteTheme() {
        view.backgroundColor = .white
        homeTitle.textColor = .black
        instructionLabel.textColor = .black
        btnPlus.tintColor = .black
        beat.textColor = .black
        btnMinus.tintColor = .black
        theTheme = "White"
        pickerRow = 0
    }
 
}

