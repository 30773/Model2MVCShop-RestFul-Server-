package com.model2.mvc.web.product;

import java.io.File;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

import com.model2.mvc.common.Page;
import com.model2.mvc.common.Search;
import com.model2.mvc.service.domain.Product;
import com.model2.mvc.service.product.ProductService;

@Controller
@RequestMapping("/product/*")
public class ProductController {
	
	//field
	@Autowired
	@Qualifier("productServiceImpl")
	private ProductService productService;
	
	//constructor method
	public ProductController() {
		System.out.println(this.getClass());
	}
	
	@Value("#{commonProperties['pageUnit']}")
	int pageUnit;
	
	@Value("#{commonProperties['pageSize']}")
	int pageSize;
	
	@RequestMapping(value="addProduct", method=RequestMethod.GET)
	//("/addProductView.do")
	public String addProduct() throws Exception{
		
		System.out.println("/product/addProduct : GET ");
		
		return "redirect:/product/addProductView.jsp";
	}
	
	@RequestMapping(value="addProduct", method=RequestMethod.POST)
	//("/addProduct.do")
	public String addProduct(@ModelAttribute("product") Product product, @RequestParam("file")MultipartFile file) throws Exception{
		
		System.out.println("/product/addProduct : POST");

		//file upload:: addProduct
		File f= new File("C:\\workspace\\07.Model2MVCShop(URI,pattern)\\WebContent\\images\\uploadFiles"+file.getOriginalFilename());
		file.transferTo(f);
		product.setFileName(file.getOriginalFilename());
		
		productService.addProduct(product);

		System.out.println("(Controller)addProduct : "+product);

		return "forward:/product/addProduct.jsp";
	}
	
	@RequestMapping(value="listProduct")
	//("/listProduct.do")
	public String getProductList(@ModelAttribute("search") Search search, Model model,
						HttpServletRequest request)throws Exception {
		
		System.out.println("/product/listProduct : GET / POST");
		
		String menu = request.getParameter("menu");
		
		if(search.getCurrentPage() ==0 ){
			search.setCurrentPage(1);
		}
		search.setPageSize(pageSize);
		
		Map<String, Object> map= productService.getProductList(search);
		
		Page resultPage = new Page( search.getCurrentPage(), ((Integer)map.get("totalCount")).intValue(), pageUnit, pageSize);
		System.out.println(resultPage);
		
		// ¸ðµ¨°ú ºä ¿¬°á
		model.addAttribute("list", map.get("list"));
		model.addAttribute("resultPage", resultPage);
		model.addAttribute("search", search);
		
		return "forward:/product/listProduct.jsp?menu="+menu;
	}
	
	@RequestMapping(value="getProduct", method=RequestMethod.GET)
	//("/getProduct.do")
	public String getProduct(@RequestParam("prodNo") int prodNo, Model model) throws Exception {
		
		System.out.println("/product/getProduct : GET");
		
		Product product= productService.getProduct(prodNo);
		
		model.addAttribute("product", product);
		System.out.println("(Controller) getProduct: "+product);
		
		return "forward:/product/getProduct.jsp";
	}
	
	@RequestMapping(value="updateProduct", method=RequestMethod.GET)
	public String updateProduct(@RequestParam("prodNo") int prodNo,Model model) throws Exception {
		
		System.out.println("/product/updateProduct  : GET");
		
		Product	product = productService.getProduct(prodNo);
		
		model.addAttribute("product", product);
		
		return "forward:/product/updateProductView.jsp";
	}
	
	@RequestMapping(value="updateProduct", method=RequestMethod.POST)
	//("/updateProduct.do")
	public String updateProduct( @ModelAttribute("product") Product product,Model model, HttpSession session, @RequestParam("file")MultipartFile file)throws Exception{
		
		System.out.println("/product/updateProduct : POST");
		
		//file upload :: updateProduct
		File f= new File("C:\\workspace\\07.Model2MVCShop(URI,pattern)\\WebContent\\images\\uploadFiles"+file.getOriginalFilename());
		file.transferTo(f);
		product.setFileName(file.getOriginalFilename());

		productService.updateProduct(product);
		
		System.out.println("(Controller) updateProduct: "+product);
		
		
		
		return "redirect:/product/getProduct?prodNo="+product.getProdNo();
	}
}
