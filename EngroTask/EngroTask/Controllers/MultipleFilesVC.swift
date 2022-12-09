//
//  MultipleFilesVC.swift
//  EngroTask
//
//  Created by Suman Guntuka on 09/12/22.
//

import UIKit
import BSImagePicker
import Photos

class MultipleFilesVC: UIViewController {

    @IBOutlet weak var filesCV: UICollectionView!
    @IBOutlet weak var uploadBtn: UIButton!
    var photoArray: [UIImage] = []
    var selectedAssets : [PHAsset] = []

    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Gallery"
        self.navigationController?.navigationBar.tintColor = UIColor.black

    }
    
    @IBAction func uploadBtnAction(_ sender: Any) {
        uploadImagesCall()
    }
    func uploadImagesCall() {
        if self.photoArray.count >= 3 {
            self.photoArray.removeAll()
        }
        self.selectedAssets.removeAll()
        let imagePicker = ImagePickerController()
        presentImagePicker(imagePicker, select: { (asset) in
        }, deselect: { (asset) in
        }, cancel: { (assets) in
        }, finish: { (assets) in
            for i in 0..<assets.count {
                self.selectedAssets.append(assets[i])
            }
            self.convertAssetToImages()
        })
    }
    func convertAssetToImages() -> Void {
        
        if selectedAssets.count != 0{

         for i in 0..<selectedAssets.count{
             let manager = PHImageManager.default()
             let option = PHImageRequestOptions()
             var thumbnail = UIImage()
             option.isSynchronous = true
             manager.requestImage(for: selectedAssets[i], targetSize: CGSize(width: 250, height: 250), contentMode: .aspectFill, options: option, resultHandler: {(result, info)->Void in
                    thumbnail = result!
            })
             self.photoArray.append(thumbnail)
          }
        }
        self.filesCV.reloadData()
    }
    
}
extension MultipleFilesVC: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.photoArray.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "UploadFileCell", for: indexPath) as! UploadFileCell
        cell.fileImg.image = self.photoArray[indexPath.row]
        return cell
    }

}
