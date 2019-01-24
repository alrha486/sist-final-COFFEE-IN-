package com.example.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.ModelAndView;

import com.example.service.CartService;
import com.example.service.FileUploadService;
import com.example.service.ProductService;
import com.example.vo.ProductVO;
import com.example.vo.cartDetailVO;

@Controller
public class ProductController {
	@Autowired
	ProductService productService;
	@Autowired
	CartService cartService;
	@Autowired
	FileUploadService fileUploadService;

	@Resource(name = "uploadPath")
	private String uploadPath;  //File upload 경로
	
	
	@RequestMapping(value="/productList", method=RequestMethod.GET)
	public String productList() { // 상품리스트로 이동
		return "productList";
	} 	
	
	
	@RequestMapping(value="/product/purchase/{idx}",method=RequestMethod.GET) // 선택상품 구매(Cart에서)
	@ResponseBody
	public ModelAndView purchase(@PathVariable String idx) { // 선택상품 구매(매개변수는 cartidx)
		ModelAndView mav = new ModelAndView(); // 저장 객체
		mav.addObject("productids", idx);
		mav.setViewName("purchase");
		return mav;
	}
	
	@RequestMapping(value="/product/purchase1/{productInfo}",method=RequestMethod.GET) // 선택상품 구매(상품리스트에서)
	@ResponseBody
	public ModelAndView purchase1(@PathVariable String productInfo) { // 선택상품 구매		
		ModelAndView mav = new ModelAndView(); // 저장 객체
		mav.addObject("productInfo", productInfo);
		mav.setViewName("purchase1");
		return mav;
	}

	
/////////////////////////////////////////밑에서 부터 현주꺼 ////////////////////////////////////////////
	@RequestMapping(value = "/productListAll", method = RequestMethod.GET)
	@ResponseBody
	public Map producttList1() { 
		Map<String, Object> map = new HashMap<String, Object>();
		this.productService.selectAll(map); 
		List<ProductVO> list = (List<ProductVO>)map.get("results");
		Map<String, Object> data = new HashMap<String, Object>();
		data.put("code", Boolean.TRUE);
		data.put("data", list);
		return data;
	}
	
	@RequestMapping(value="/productLists/{p_type}",method=RequestMethod.GET) // 선택상품 검색(대분류)
	@ResponseBody
	public Map listtype(@PathVariable String p_type) { // 선택상품 검색
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("p_type", p_type);
		this.productService.selectOneKinds(map);
		List<ProductVO> list = (List<ProductVO>)map.get("results");
		Map<String, Object> data = new HashMap<String, Object>();
		data.put("code", Boolean.TRUE);
		data.put("data", list);
		return data;
	}
	
	@RequestMapping(value="/productList/{kind_idx}",method=RequestMethod.POST) // 선택상품 검색(소분류)
	@ResponseBody
	public Map listkind(@PathVariable int kind_idx) { // 선택상품 검색
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("kind_idx", kind_idx);
		this.productService.selectOneKind(map);
		
		List<ProductVO> list = (List<ProductVO>)map.get("results");
		Map<String, Object> data = new HashMap<String, Object>();
		data.put("code", Boolean.TRUE);
		data.put("data", list);
		return data;
	}
	
	///////////준오형꺼 검색///
	@RequestMapping(value = "/search/{productName}" , method = RequestMethod.GET)
	@ResponseBody
	public ModelAndView Anysearch(@PathVariable String productName) {
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("productName", productName);
		this.productService.selectProductAny(map);
		List<ProductVO> list = (List<ProductVO>)map.get("result");
		
		ModelAndView mav = new ModelAndView();
		mav.addObject("data", list);
		mav.setViewName("searchproduct");
		
		return mav;
	}
	
	@RequestMapping(value ="/search/{innerName}", method = RequestMethod.POST)
	@ResponseBody
	public Map innerSearch(@PathVariable String innerName) {
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("productName", innerName);
		this.productService.selectProductAny(map);
		List<ProductVO> list = (List<ProductVO>)map.get("result");
		
		Map<String, Object> result = new HashMap<String, Object>();
		result.put("code", Boolean.TRUE);
		result.put("data", list);
		
		return result;
	}
	
	@RequestMapping(value = "/", method = RequestMethod.GET)
	public String home(Model model) {
		Map<String, Object> map = new HashMap<String, Object>();	
		this.productService.selectProductNew(map);
		List<ProductVO> list = (List<ProductVO>)map.get("newresult");
		String str = "";
		
		for(int i = 0 ; i < list.size() ; i++) {
			ProductVO p = list.get(i);
		
				str += "<div class='single-album'>";
				str += "<img src='static/img/product/" + p.getProductname() + ".jpg'>";
				str += "<div class='album-info'>";
				str += "<a href='/coffee/view/" + p.getProductid() + "'>";
				str += "<h5>" + p.getProductname() + "</h5>";
				str += "</a>";
				str += "<p> Ice Coffee </p>";
				str += "</div>";
				str += "</div>";
		}
		
		model.addAttribute("list", str);
		return "index";
	}
	
	
	
	@RequestMapping(value = "/productInfoSelect1/{productid}", method = RequestMethod.GET) // 상품 ID로 하나의 상품 조회
	@ResponseBody
	public Map productInfoSelect1(@PathVariable int productid) { 
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("productid", productid);
		this.productService.selectProduct(map);
		List<cartDetailVO> list = (List<cartDetailVO>)map.get("results");
		Map<String, Object> data = new HashMap<String, Object>();
		data.put("data", list);
		return data;
	}
	
	@RequestMapping(value = "/SearchManyPopularityProduct", method = RequestMethod.GET) // 상품 ID로 하나의 상품 조회
	@ResponseBody
	public Map SearchManyPopularityProduct() { 
		Map<String, Object> map = new HashMap<String, Object>();
		this.productService.SearchManyPopularityProduct(map); // 장바구니 전체조회
		List<ProductVO> list = (List<ProductVO>)map.get("results");
		Map<String, Object> data = new HashMap<String, Object>();
		data.put("data", list);
		return data;
	}
	
	@RequestMapping(value = "/SearchRecentlyProduct", method = RequestMethod.GET) // 상품 ID로 하나의 상품 조회
	@ResponseBody
	public Map SearchRecentlyProduct() { 
		Map<String, Object> map = new HashMap<String, Object>();
		this.productService.SearchRecentlyProduct(map); // 장바구니 전체조회
		List<ProductVO> list = (List<ProductVO>)map.get("results");
		Map<String, Object> data = new HashMap<String, Object>();
		data.put("data", list);
		return data;
	}
	
	
	@RequestMapping(value = "/selectProductGrape1", method = RequestMethod.GET) // 상품그래프(오늘)
	@ResponseBody
	public Map selectProductGrape1() { 
		Map<String, Object> map = new HashMap<String, Object>();
		this.productService.selectProductGrape1(map); 
		List<ProductVO> list = (List<ProductVO>)map.get("results");
		Map<String, Object> data = new HashMap<String, Object>();
		data.put("data", list);
		return data;
	}
	
	@RequestMapping(value = "/selectProductGrape2/{selldate}", method = RequestMethod.GET) // 상품그래프(이번주)
	@ResponseBody
	public Map selectProductGrape2(@PathVariable String selldate) { 
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("selldate", selldate);
		this.productService.selectProductGrape2(map); 
		List<ProductVO> list = (List<ProductVO>)map.get("results");
		Map<String, Object> data = new HashMap<String, Object>();
		data.put("data", list);
		return data;
	}
//////////////////////////////////////////////////////////////////////////////////////////////////////////////
	//링크 타고 올 때 상품 목록
	@RequestMapping(value="/productList/{type}", method=RequestMethod.GET)
	public String productList(Model model, @PathVariable String type) { // 상품리스트로 이동
		model.addAttribute("type", type);
		return "productList";
	}
	
	//상품 대분류 목록
	@RequestMapping(value="/productLists/{p_type}/{page}", method=RequestMethod.GET) // 선택상품 검색(대분류)
	@ResponseBody
	public Map listtype(@PathVariable String p_type, @PathVariable int page) { // 선택상품 검색
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("p_type", p_type);
		this.productService.getTypeCount(map);
		int totalCount = (Integer) map.get("result");
		int pageSize = 10;
		int startPage = 1;
		int totalPage = (totalCount % pageSize == 0) ? totalCount / pageSize : totalCount / pageSize + 1;
		int kind_idx=0;
		
		// 1페이지 -> 1+15-1=15 // 2페이지 -> 16+15-1=30
		int start = (page - 1) * pageSize + 1;
		int end = start + pageSize - 1;
		
		map.put("start", start);
		map.put("end", end);
		this.productService.selectOneKinds(map);
		
		List<ProductVO> list = (List<ProductVO>)map.get("results");
		Map<String, Object> data = new HashMap<String, Object>();
		data.put("code", Boolean.TRUE);
		data.put("startPage", startPage);
		data.put("totalPage", totalPage);
		data.put("pageSize", pageSize);
		data.put("page", page);
		data.put("type", p_type);
		data.put("kind", kind_idx);
		data.put("data", list);
		return data;
	}
	
	//상품 소분류 목록
	@RequestMapping(value="/productList/{kind_idx}/{page}", method=RequestMethod.GET) // 선택상품 검색(소분류)
	@ResponseBody
	public Map listkind(@PathVariable int kind_idx, @PathVariable int page) { // 선택상품 검색
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("kind_idx", kind_idx);
		this.productService.getKindCount(map);
		int totalCount = (Integer) map.get("result");
		int pageSize = 10;
		int startPage = 1;
		int totalPage = (totalCount % pageSize == 0) ? totalCount / pageSize : totalCount / pageSize + 1;
		
		// 1페이지 -> 1+15-1=15 // 2페이지 -> 16+15-1=30
		int start = (page - 1) * pageSize + 1;
		int end = start + pageSize - 1;
		
		map.put("start", start);
		map.put("end", end);
		this.productService.selectOneKind(map);
		
		List<ProductVO> list = (List<ProductVO>)map.get("results");
		Map<String, Object> data = new HashMap<String, Object>();
		data.put("code", Boolean.TRUE);
		data.put("startPage", startPage);
		data.put("totalPage", totalPage);
		data.put("pageSize", pageSize);
		data.put("page", page);
		data.put("kind", kind_idx);
		data.put("data", list);
		return data;
	}
	
	//상품 클릭 시 상세페이지 이동
	@RequestMapping(value = "/view/{productid}", method = RequestMethod.GET)
	@ResponseBody 
	public ModelAndView view(@PathVariable int productid) {
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("productid", productid);
		this.productService.selectProduct(map);
		List<ProductVO> list = (List<ProductVO>)map.get("results");
		ProductVO product= list.get(0);
		
		ModelAndView mav = new ModelAndView();
		mav.addObject("product", product);
		mav.setViewName("view");
		return mav;
	}
/////////////////////관리자//////////////////////////////////
	//관리자 페이지 상품관리 페이지
		@RequestMapping(value="/manager/product", method=RequestMethod.GET)
		public String manager_home() { 
			return "product_management";
		}
		//관리자 페이지 상품등록 페이지
		@RequestMapping(value="/admin/productInsert", method=RequestMethod.GET)
		public String product_insert() { 
			return "productInsert";
		}
		//관리자 페이지 상품 등록
		@RequestMapping(value="/admin/productInsert", method=RequestMethod.POST)
		@ResponseBody
		public Map create(MultipartHttpServletRequest request) {
			ProductVO productVo = new ProductVO();
			productVo.setKind_idx(Integer.parseInt(request.getParameter("kind_idx")));
			productVo.setProductname(request.getParameter("productname"));
			productVo.setProductex(request.getParameter("productex"));
			productVo.setPrice(Integer.parseInt(request.getParameter("price")));
			productVo.setStock(Integer.parseInt(request.getParameter("stock")));
			//이미지 파일 올리는 부분. 
			MultipartFile mFile = request.getFile("productimage");
			String uri = this.fileUploadService.restore1(mFile, uploadPath);
			System.out.println(uploadPath);

			
			//uri에는 바뀐 파일 이름이 저장됨.
			productVo.setProductimg(uri);
			
			Map<String, Object> result = new HashMap<String, Object>();
			this.productService.insertProduct(productVo);
			result.put("code", Boolean.TRUE);
			return result;
		}
		//관리자 페이지 상품수정 페이지 이동
		@RequestMapping(value = "/modifyProductOne/{productid}", method = RequestMethod.GET)
		public String modify(Model model, @PathVariable String productid) {
			model.addAttribute("productid", productid);
			return "productModify";
		}
		
		//관리자 페이지 상품 전체 목록
		@RequestMapping(value="/productListSS/{page}", method=RequestMethod.GET)
		@ResponseBody
		public Map list(@PathVariable int page) {
			Map<String, Object> map= new HashMap<String, Object>();
			this.productService.getTotalCount(map);
			int totalCount = (Integer) map.get("result");
			int pageSize = 10;
			int startPage = 1;
			int totalPage = (totalCount % pageSize == 0) ? totalCount / pageSize : totalCount / pageSize + 1;
			// 1페이지 -> 1+10-1=10 // 2페이지 -> 11+10-1=20
			int start = (page - 1) * pageSize + 1;
			int end = start + pageSize - 1;
			map.put("start", start);
			map.put("end", end);
			this.productService.select_productListAll(map);
			List<ProductVO> list = (List<ProductVO>)map.get("results");
			
			Map<String, Object> map1 = new HashMap<String, Object>();
			map1.put("code", Boolean.TRUE);
			map1.put("totalCount", totalCount);
			map1.put("pageSize", pageSize);
			map1.put("startPage", startPage);
			map1.put("totalPage", totalPage);
			map1.put("page", page);
			map1.put("data", list);
			return map1;
		}
		
		//검색결과 출력-상품명
		@RequestMapping(value="/productSelectSS/{p_type}/{p_name}/{page}", method=RequestMethod.GET)
		@ResponseBody
		public Map productSelect(@PathVariable String p_type, @PathVariable String p_name, @PathVariable int page) {
			Map<String, Object> map = new HashMap<String, Object>();
			map.put("p_type", p_type);
			map.put("p_name", p_name);
			this.productService.getSearchCount(map);
			int totalCount = (Integer) map.get("result");
			int pageSize = 10;
			int startPage = 1;
			int totalPage = (totalCount % pageSize == 0) ? totalCount / pageSize : totalCount / pageSize + 1;
			// 1페이지 -> 1+10-1=10 // 2페이지 -> 11+10-1=20
			int start = (page - 1) * pageSize + 1;
			int end = start + pageSize - 1;
			map.put("start", start);
			map.put("end", end);
			
			this.productService.productSelectAjax(map);
			List<ProductVO> list = (List<ProductVO>)map.get("results");
			
			Map<String, Object> map1 = new HashMap<String, Object>();
			map1.put("code", Boolean.TRUE);
			map1.put("totalCount", totalCount);
			map1.put("pageSize", pageSize);
			map1.put("startPage", startPage);
			map1.put("totalPage", totalPage);
			map1.put("page", page);
			map1.put("data", list);
			return map1;
		} 
		
		//관리자 페이지 상품 삭제
		@RequestMapping(value = "/productDelete/{productid}", method = RequestMethod.DELETE)
		@ResponseBody
		public Map productDelete(@PathVariable int productid) {
			this.productService.deleteProduct(productid);
			Map<String, Object> map = new HashMap<String, Object>();
			map.put("code", "success");
			return map;
		}
		
		// 관리자 페이지 상품 수정페이지 정보 받아오기
		@RequestMapping(value="/infoProduct/{productid}", method = RequestMethod.GET)
		@ResponseBody
		public Map read(@PathVariable int productid) {
			Map<String, Object> map = new HashMap<String, Object>();
			map.put("productid", productid);
			this.productService.infoProduct(map);
			List<ProductVO> list = (List<ProductVO>)map.get("result");
			ProductVO productVo = list.get(0);
			Map<String, Object> map1 = new HashMap<String, Object>();
			map1.put("code", "success");
			map1.put("data", productVo);
			return map1;
		} 
		
		//관리자 페이지 상품 수정
		@RequestMapping(value="/modifyProduct/{productid}", method = RequestMethod.PUT)
		@ResponseBody
		public Map update(@PathVariable int productid ,@RequestBody ProductVO productVo) {
			productVo.setProductid(productid);
			this.productService.modifyProduct(productVo);
			Map<String, Object> map = new HashMap<String, Object>();
			map.put("code", Boolean.TRUE);
			return map;
		}	
		
		
		//상품 이름 전체 목록(검색 자동 완성)
		   @RequestMapping(value = "/productNameAll", method = RequestMethod.GET)
		   @ResponseBody
		   public Map productName() {
		      Map<String, Object> map = new HashMap<String, Object>();
		      this.productService.nameAll(map);
		      List<ProductVO> list = (List<ProductVO>)map.get("resultsName");
		      Map<String, Object> data = new HashMap<String, Object>();
		      data.put("code", Boolean.TRUE);
		      data.put("data", list);
		      return data;
		   }
		   
}

