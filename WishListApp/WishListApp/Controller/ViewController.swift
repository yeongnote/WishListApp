import UIKit
import CoreData



class ViewController: UIViewController {
    
    
    
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    //담기 버튼
    @IBAction func tappadSave(_ sender: UIButton) {
    }
    //다른 상품보기 버튼
    @IBAction func fetchRemoteProduct(_ sender: UIButton) {
    }
    //위시리스트 보기
    @IBAction func tappedPresentWishList(_ sender: UIButton) {
    }
    
    
}

