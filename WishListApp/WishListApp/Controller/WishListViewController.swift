import UIKit
import CoreData


class WishListViewController: UITableViewController {

    var persistentContainer: NSPersistentContainer? {
        (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer
    }
    
    private var productList: [Product] = []
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.dataSource = self
        setProductList()
    }
    
    //CoreData에서 상품 정보를 불러와, productList 변수에 저장
    private func setProductList() {
        guard let context = self.persistentContainer?.viewContext else { return }
        let request = Product.fetchRequest()
        
        if let productList = try? context.fetch(request) {
            self.productList = productList
        }
    }
    
    // 테이블 뷰
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.productList.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        let product = self.productList[indexPath.row]
        
        let id = product.id
        let title = product.title ?? ""
        let price = product.price
        
        cell.textLabel?.text = "[\(id)] \(title) - \(price)$"
        
        return cell
    }
}
