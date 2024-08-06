// Filename: PadlanDanica-HW10
// EID: dmp3357
// Course: CS371L

import UIKit
import AVFoundation

public var imageList = [UIImage]()

class MainViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    @IBOutlet weak var collectionView: UICollectionView!
    
    let reuseId = "customCell"
    let picker = UIImagePickerController()
    
    var selectedImageIndex = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        collectionView.delegate = self
        collectionView.dataSource = self
        picker.delegate = self
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        let layout = UICollectionViewFlowLayout()
        
        //set 3 cells per row
        let containerWidth = collectionView.bounds.width
        let cellSize = containerWidth / 3
        layout.itemSize = CGSize(width: cellSize, height: cellSize)
        
        //setting minimum spacing
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        
        collectionView.collectionViewLayout = layout
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return imageList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

        //set cell's image
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseId, for: indexPath) as! CustomCollectionViewCell
        cell.savedImage.image = imageList[indexPath.row]
        return cell
    }
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        //segue to detailVC with the imageView at index
        print("selected image index: \(indexPath.row)")
        selectedImageIndex = indexPath.row
        
        performSegue(withIdentifier: "mainToDetailVCSegue", sender: nil)
    }
    
    @IBAction func folderButtonPressed(_ sender: Any) {
        
        //show picker
        picker.allowsEditing = false
        picker.sourceType = .photoLibrary
        present(picker, animated: true)
    }
    
    @IBAction func cameraButtonPressed(_ sender: Any) {

        //check if camera is available
        if UIImagePickerController.availableCaptureModes(for: .rear) != nil {
            // there is a rear camera available
            switch AVCaptureDevice.authorizationStatus(for: .video) {
            case .notDetermined:
                AVCaptureDevice.requestAccess(for: .video) {
                    (accessGranted) in
                    guard accessGranted == true else { return }
                }
            case .authorized:
                break
            default:
                print("Access was previously denied")
                return
            }
            
            // we have authorization;  now do stuff
            picker.allowsEditing = false
            picker.sourceType = .camera
            picker.cameraCaptureMode = .photo
            present(picker,animated: true)
            
        } else {
            
            // there is no rear camera
            let alertVC = UIAlertController(title: "No camera", message: "Sorry, this device has no rear camera", preferredStyle: .alert)
            let okAction = UIAlertAction(title: "OK", style: .default)
            alertVC.addAction(okAction)
            present(alertVC,animated:true)
        }
        
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        //get selected image
        let chosenImage = info[.originalImage] as! UIImage
        
        //append to list
        imageList.append(chosenImage)
        
        //reload collectionView
        collectionView.reloadData()
        
        //dissmiss the picker
        dismiss(animated: true)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        
        //dismiss picker if user clicks 'Cancel'
        dismiss(animated: true)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if(segue.identifier == "mainToDetailVCSegue"), let nextVC = segue.destination as? DetailViewController {
            
            nextVC.incomingImage = imageList[selectedImageIndex]
        }
    }
    
}

