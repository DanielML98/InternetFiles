//
//  ViewController.swift
//  Internet Files
//
//  Created by Daniel Martínez on 27/05/22.
//

import UIKit

class ViewController: UIViewController {

  override func viewDidLoad() {
    super.viewDidLoad()
    self.navigationItem.title = "Select the file you want to see"
    // Do any additional setup after loading the view.
  }


  @IBAction func didTapFileButton(_ sender: UIButton) {
    var selectedFile: Files = .image
    switch sender.tag {
    case 0:
      selectedFile = .excel
    case 1:
      selectedFile = .pdf
    case 2:
      selectedFile = .image
    default:
      selectedFile = .image
    }
    guard let vc = storyboard?.instantiateViewController(withIdentifier: "FileVC") as? FileViewController else { return }
    vc.selectedFile = selectedFile
    self.show(vc, sender: nil)
  }
}

enum Files: String {
  case excel = "localidades.xlsx"
  case pdf = "Articles.pdf"
  case image = "geo_vertical.jpg"
}
