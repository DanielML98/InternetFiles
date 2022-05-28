//
//  FileViewController.swift
//  Internet Files
//
//  Created by Daniel Martínez on 27/05/22.
//

import UIKit
import WebKit

class FileViewController: UIViewController {
  @IBOutlet weak var webView: WKWebView!
  var selectedFile: Files?
  let baseURL = "http://janzelaznog.com/DDAM/iOS/vim/"
  let libraryURL = FileManager.default.urls(for: .libraryDirectory, in: .userDomainMask)[0]
  let loaderView: UIActivityIndicatorView = {
    let a_i = UIActivityIndicatorView()
    a_i.style = .large
    a_i.color = .red
    a_i.hidesWhenStopped = true
    return a_i
  }()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    loaderView.center = self.view.center
    self.view.addSubview(loaderView)
    if fileIsDownloaded(name: selectedFile?.rawValue){
      let localURL = libraryURL.appendingPathComponent(selectedFile!.rawValue)
      webView.loadFileURL(localURL, allowingReadAccessTo: localURL)
    } else {
      if let file: Files = selectedFile,
         ConnectionValidator.shared.hasInternetCollection {
          self.saveFile(file.rawValue)
      } else {
        showConnectionAlert()
      }
    }
  }
  
  private func fileIsDownloaded(name: String?) -> Bool {
    guard let name = name else { return false }
    let fileURL = libraryURL.appendingPathComponent(name)
    print(fileURL.path)
    return FileManager.default.fileExists(atPath: fileURL.path)
  }
  
  private func showConnectionAlert() {
    let alert = UIAlertController(title: "Can't download file", message: "There's no Internet Connection", preferredStyle: .alert)
    let boton = UIAlertAction(title: "Ok", style: .default) { alert in
      self.dismiss(animated: true)
    }
    alert.addAction(boton)
    self.present(alert, animated:true)
  }
  
  private func saveFile(_ name: String) {
    let fileURL = libraryURL.appendingPathComponent(name)
    if let url = URL(string: baseURL + name) {
      let request = URLRequest(url: url)
      let dataTask = URLSession.shared.dataTask(with: request) { data, response, error in
        guard error == nil else { return }
        if let data = data {
          do{
            try data.write(to: fileURL)
            print("Succesfully saved file")
            DispatchQueue.main.async {
              self.webView.load(request)
              self.loaderView.stopAnimating()
            }
          } catch {
            print("Error saving file \(error.localizedDescription)")
          }
        }
      }
      loaderView.startAnimating()
      dataTask.resume()
    }
  }
  
}
