import UIKit
import CoreData



class ViewController: UIViewController {
    //persistentContainer에 접근하기
    var persistentContainer: NSPersistentContainer? {
        (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer
    }
    
    // currentProduct가 set되면 각 정보에 적절한 값 지정
    private var currentProduct: RemoteProduct? = nil {
        didSet {
            guard let currentProduct = self.currentProduct else { return }
            
            DispatchQueue.main.async {
                self.imageView.image = nil
                self.titleLabel.text = currentProduct.title
                self.descriptionLabel.text = currentProduct.description
                self.priceLabel.text = "\(currentProduct.price)$"
            }
            
            DispatchQueue.global().async { [weak self] in
                if let data = try? Data(contentsOf: currentProduct.thumbnail),
                   let image = UIImage(data: data) {
                    DispatchQueue.main.async { self?.imageView.image = image}
                }
            }
        }
    }
    
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.fetchRemoteProduct()
    }
    
    //담기 버튼
    @IBAction func tappadSave(_ sender: UIButton) {
        saveWishProduct()
    }
    //다른 상품보기 버튼
    @IBAction func fetchPresentWishList(_ sender: UIButton) {
        fetchRemoteProduct()
    }
    //위시리스트 보기
    @IBAction func tappedPresentWishList(_ sender: UIButton) {
        //WishListViewController 가져오기
        guard let nextVC = self.storyboard?.instantiateViewController(withIdentifier: "WishListViewController") as? WishListViewController else { return }
        
        // WishListViewController를 present 하기
        self.present(nextVC, animated: true)
        
    }
    
    // currentProduct를 가져와 Core Data에 저장
    private func saveWishProduct() {
        guard let context = self.persistentContainer?.viewContext else { return }
        guard let currentProduct = self.currentProduct else { return }
        
        let wishProduct = Product(context: context)
        
        wishProduct.title = currentProduct.title
        wishProduct.id = Int64(currentProduct.id)
        wishProduct.price = currentProduct.price
        
        try? context.save()
    }
    
    // URLSession을 통해 RemoteProduct를 가져와 currentProduct 변수에 저장
    private func fetchRemoteProduct() {
        // 1 ~ 50 사이 랜덤 숫자 가져오기
        let productID = Int.random(in: 1...50)
        
        //URLSession을 통해 RemoteProduct를 가져오기
        if let url = URL(string: "https://dummyjson.com/products/\(productID)") {
            let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
                if let error = error {
                    print("Error: \(error)")
                } else if let data = data {
                    do {
                        let product = try JSONDecoder().decode(RemoteProduct.self, from: data)
                        self.currentProduct = product
                    } catch {
                        print("Decode Error: \(error)")
                    }
                }
            }
            
            task.resume() //네트워크 요청 시작
        }
    }
}

