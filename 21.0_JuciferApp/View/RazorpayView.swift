import Razorpay
import SwiftUI

//View that conforms to UIViewControllerRepresentable
struct RazorPayView:UIViewControllerRepresentable{
    @EnvironmentObject var cartVm:CartViewModel
    @State var totalPrie:Int
    typealias UIViewControllerType = ViewController
    
    func makeUIViewController(context: Context) -> ViewController {
        let vc = ViewController()
        return vc
    }
    
    func updateUIViewController(_ uiViewController: ViewController, context: Context) {
        
    }
}


//UIViewController
class ViewController: UIViewController, RazorpayPaymentCompletionProtocol {
    @EnvironmentObject var cartVm:CartViewModel
    var razorpay: RazorpayCheckout!
    override func viewDidLoad(){
        super.viewDidLoad()
        razorpay = RazorpayCheckout.initWithKey("rzp_test_PROiD30HBjQzGT", andDelegate: self)
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.showPaymentForm()
        print("view appeared ...fkdsflsdf")
    }
    
    
    //working code
    
//    func showPaymentForm() {
//        let options: [String:Any] = [
//            "amount": "1000", //This is in currency subunits. 100 = 100 paise= INR 1.
//            "currency": "INR",//We support more that 92 international currencies.
//            "description": "purchase description",
//            //"order_id": "order_DBJOWzybf0sJbb",
////            "image": "https://url-to-image.jpg",
//            "name": "business or product name",
//            "profile": [
//                "contact": "9797979797",
//                "email": "foo@bar.com"
//            ],
//            "theme": [
//                "color": "#F37254"
//            ],
//            "key": "rzp_test_PROiD30HBjQzGT"
//        ]
//        print(options)
//        razorpay.open(options)
//    }
    
    
    
    func showPaymentForm() {
        let options: [String:Any] = [
            "amount": "\(100 * 100)", //This is in currency subunits. 100 = 100 paise= INR 1.
            "currency": "INR",//We support more that 92 international currencies.
            "description": " one and only app you need",
            "name": "Juicifer Products",
            "profile": [
                "contact": "9797979797",
                "email": "foo@bar.com"
            ],
            "theme": [
                "color": "#F37254"
            ],
            "key": "rzp_test_PROiD30HBjQzGT"
        ]
        print(options)
        razorpay.open(options)
    }
    

    func onPaymentError(_ code: Int32, description str: String) {
        print("error: ", code, str)
        self.presentAlert(withTitle: "Alert", message: str)
    }

    func onPaymentSuccess(_ payment_id: String) {
        print("success: ", payment_id)
        self.presentAlert(withTitle: "Success", message: "Payment Succeeded")
    }

    func presentAlert(withTitle title: String, message: String) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alertController.addAction(okAction)
        self.present(alertController, animated: true, completion: nil)
    }

}
