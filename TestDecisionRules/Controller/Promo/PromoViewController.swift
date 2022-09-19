//
//  PromoViewController.swift
//  TestDecisionRules
//
//  Created by efloresco on 09/09/22.
//

import UIKit

class PromoViewController: UIViewController {
    @IBOutlet weak var svPager: UIScrollView! {
        didSet {
            svPager.delegate = self
        }
    }
    @IBOutlet weak var pgSteps: UIPageControl!
    var lstSlide: [PromoView]?
    var lstPro = [Promo]()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        loadPromotions()
    }
    
    //MARK: - D E C I S I O N · R U L E S
    func loadPromotions() {
        let ws: ServiceManager = ServiceManager()
        ws.loadPromotions(WithDate: "18/9/22") { [weak self] resultado, error  in
            if resultado != nil{
                if let usr = resultado {
                    DispatchQueue.main.async {
                        var lst = [PromoView]()
                        self?.lstPro = [Promo]()
                        if let result = resultado {
                            for item in result {
                                
                                if let slide: PromoView = Bundle(for: PromoView.self).loadNibNamed("PromoView", owner: self, options: nil)?.first as? PromoView {
                                    slide.lblTitle.text = item.titulo
                                    slide.lblSubtitle.text = item.subtitulo
                                    slide.imgStep.setViewImage(stringUrlToImage: item.urlImage)
                                    slide.backgroundColor = .clear
                                    lst.append(slide)
                                    
                                }
                            }
                        }
                        self?.lstPro = resultado ?? [Promo]()
                        self?.configurationSteps(lst: lst)
                    }
                }
            }else{ self?.showSimpleAlert(WithMessage: "error") }
        }
    }
        
        //MARK: - F U N C T I O N S
        func showSimpleAlert(WithMessage msg: String) {
            let alert = UIAlertController(title: "DecisionRules", message: msg , preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Aceptar", style: .default, handler: nil))
            self.present(alert, animated: true)
        }


    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
extension PromoViewController : UIScrollViewDelegate {
    func configurationSteps(lst: [PromoView]) {
        lstSlide = lst
        setupSlideScrollView(slide: lstSlide ?? [PromoView]())
        pgSteps.numberOfPages = lstSlide?.count ?? 0
        pgSteps.currentPage = 0
    }
   
    func setupSlideScrollView(slide: [PromoView]) {
        let percent = CGFloat(0.70)
        let offset: CGFloat = CGFloat((1.0 - percent) / 2.0)
        svPager.contentSize = CGSize(width: Int(view.frame.size.width) * slide.count, height:  Int(self.view.frame.size.height * offset))
        svPager.isPagingEnabled = true
        svPager.showsHorizontalScrollIndicator = false
        svPager.showsVerticalScrollIndicator = false
        svPager.backgroundColor = .clear
        let rect = CGSize(width: Int(self.view.frame.size.width) - 4, height: Int(view.frame.size.height))
        if let lst = lstSlide {
            if lst.count > 0 {
                for i in 0 ..< lst.count {
                    if let vs = lstSlide?[i] {
                        vs.frame = CGRect(x: (self.view.frame.size.width - 4) * CGFloat(i), y: 0, width: rect.width, height: rect.height)
                        svPager?.addSubview(vs)
                    }
                }
            }
        }
    }
    @IBAction func acChangeAction(_ sender: UIPageControl) {
        let v1 = pgSteps.numberOfPages
        if pgSteps.currentPage == (v1 - 2){
            pgSteps.currentPage = Int(self.pgSteps.currentPage ) + 1
            svPager.setContentOffset(CGPoint(x: (Int(self.view.frame.size.width) * Int(self.pgSteps.currentPage)), y: 0), animated: true)
            
        }else{
            pgSteps.currentPage = Int(self.pgSteps.currentPage ) + 1
            svPager.setContentOffset(CGPoint(x: (Int(self.view.frame.size.width) * Int(self.pgSteps.currentPage)), y: 0), animated: true)
        }
    }
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let pageIndex = round(scrollView.contentOffset.x/view.frame.width)
        pgSteps.currentPage = Int(pageIndex)
        self.lstSlide?[Int(pageIndex)].imgStep.downloaded(from: URL.init(fileURLWithPath: lstPro[Int(pageIndex)].urlImage ?? ""))
       
    }
    func acChangeAction2() {
        let v1 = pgSteps.numberOfPages
        if pgSteps.currentPage == (v1 - 2){
            pgSteps.currentPage = Int(self.pgSteps.currentPage ) + 1
            svPager.setContentOffset(CGPoint(x: (Int(Int(self.view.frame.size.width)/*self.scrollMaster.frame.size.width
                                                    */) * Int(self.pgSteps.currentPage)), y: 0), animated: true)
            
        }else{
            pgSteps.currentPage = Int(self.pgSteps.currentPage ) + 1
            svPager.setContentOffset(CGPoint(x: (Int(self.view.frame.size.width/*self.scrollMaster.frame.size.width*/) * Int(self.pgSteps.currentPage)), y: 0), animated: true)
             
        }
    }
}

extension UIImageView {
    func downloaded(from url: URL, contentMode mode: ContentMode = .scaleAspectFit) {
        contentMode = mode
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard
                let httpURLResponse = response as? HTTPURLResponse, httpURLResponse.statusCode == 200,
                let mimeType = response?.mimeType, mimeType.hasPrefix("image"),
                let data = data, error == nil,
                let image = UIImage(data: data)
                else { return }
            DispatchQueue.main.async() { [weak self] in
                self?.image = image
            }
        }.resume()
    }
    func downloaded(from link: String, contentMode mode: ContentMode = .scaleAspectFit) {
        guard let url = URL(string: link) else { return }
        downloaded(from: url, contentMode: mode)
    }
}
