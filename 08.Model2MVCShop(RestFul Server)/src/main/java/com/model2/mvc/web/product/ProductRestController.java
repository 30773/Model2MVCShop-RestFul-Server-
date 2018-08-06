package com.model2.mvc.web.product;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RestController;

import com.model2.mvc.service.domain.Product;
import com.model2.mvc.service.product.ProductService;


//==> 회원관리 RestController
@RestController
@RequestMapping("/product/*")
public class ProductRestController {
	
	///Field
	@Autowired
	@Qualifier("productServiceImpl")
	private ProductService productService;
	//setter Method 구현 않음
		
	public ProductRestController(){
		System.out.println("productRestController- getClass() : "+this.getClass());
	}
	
	@Value("#{commonProperties['pageUnit']}")
	int pageUnit;

	@Value("#{commonProperties['pageSize']}")
	int pageSize;
	
	
	@RequestMapping( value="json/addProduct", method=RequestMethod.POST )
	public Product addProduct(@RequestBody Product product) throws Exception{
		
		System.out.println("json/addProduct");
		
		productService.addProduct(product);
		System.out.println("2??????????????????????????");
		return product;
	}
	
	@RequestMapping( value="json/getProduct/{prodNo}", method=RequestMethod.GET )
	public Product getProduct(@PathVariable int prodNo) throws Exception{
		
		System.out.println("/json/getProduct: GET");
		
		//business logic
		return productService.getProduct(prodNo);
	}
	
	
	@RequestMapping("json/updateProduct")
	public Product updateProduct(@RequestBody Product product) throws Exception {

		System.out.println("/updateProduct");
		System.out.println("1??????????????????????????");

		productService.updateProduct(product);
		System.out.println("2??????????????????????????");
		return product;
	}
	
	
	
	
}