//
//  ViewController.swift
//  randomImageAPI
//
//  Created by 羅承志 on 2021/9/24.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var imageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        catchImage()
        TapChange()
    }
    
    @objc func catchImage() {
        //讀取url
        let urlStr = "https://picsum.photos/200/300"
        if let url = URL(string: urlStr) {
            //於其他執行緒 打開文件，讀取內容
            URLSession.shared.dataTask(with: url) { (data, response, error) in
                if let data = data {
                    //主執行緒執行 顯示內容
                    DispatchQueue.main.async {
                        self.imageView.image = UIImage(data: data)
                    }
                }
            }.resume() //執行task
        }
    }
    
    @IBAction func changImage(_ sender: UIButton) {
        catchImage()
    }
    
    func TapChange() {
        //點擊手勢功能，selector為執行function
        let doubleTap = UITapGestureRecognizer(target: self, action: #selector(catchImage))
        doubleTap.numberOfTapsRequired = 1 //點擊次數
        imageView.isUserInteractionEnabled = true //觸碰反應
        imageView.addGestureRecognizer(doubleTap)  //加入手勢
    }
}

