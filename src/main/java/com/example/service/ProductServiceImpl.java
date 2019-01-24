package com.example.service;

import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.example.dao.ProductDAO;
import com.example.vo.ProductVO;

@Service("ProductService")
public class ProductServiceImpl implements ProductService{
	@Autowired
	ProductDAO productDao;

	public void selectAll(Map map) {
		productDao.selectAll(map);
	}
	@Override
	public void selectProductAny(Map map) {
		this.productDao.readAny(map);
	}

	@Override
	public void selectProductNew(Map map) {
		this.productDao.readNew(map);
	}

	@Override
	public void SearchManyPopularityProduct(Map map) {
		this.productDao.SearchManyPopularityProduct(map);
	}

	@Override
	public void SearchRecentlyProduct(Map map) {
		this.productDao.SearchRecentlyProduct(map);
	}

	@Override
	public void selectProductGrape1(Map map) {
		this.productDao.selectProductGrape1(map);
	}

	@Override
	public void selectProductGrape2(Map map) {
		this.productDao.selectProductGrape2(map);
	}
	////////////////////////////////////////////////////////

	//상품 소분류 목록
		@Override
		public void selectOneKind(Map map) {
			productDao.selectOneKind(map);
		}
		//상품 대분류 목록
		@Override
		public void selectOneKinds(Map map) {
			productDao.selectOneKinds(map);
		}
		//상품 정보 불러오기
		@Override
		public void selectProduct(Map map) {
			productDao.selectProduct(map);
		}
		//상품 전체 목록
		@Override
		public void select_productListAll(Map map) {
			productDao.select_productListAll(map);
		}
		
		//상품 전체 카운트
		@Override
		public void getTotalCount(Map map) {
			this.productDao.getTotalCount(map);
		}
		//상품 대분류 카운트
		@Override
		public void getTypeCount(Map map) {
			this.productDao.getTypeCount(map);
		}
		//상품 소분류 카운트
		@Override
		public void getKindCount(Map map) {
			this.productDao.getKindCount(map);
		}
		
		//관리자 페이지 상품 등록
		@Override
		public void insertProduct(ProductVO productVo) {
			this.productDao.insertProduct(productVo);
		}
		//관리자 페이지 상품 삭제
		@Override
		public void deleteProduct(int productid) {
			this.productDao.deleteProduct(productid);
		}
		//관리자 페이지 상품 정보 불러오기
		@Override
		public void infoProduct(Map map) {
			this.productDao.infoProduct(map);
		}
		//관리자 페이지 상품 수정
		@Override
		public void modifyProduct(ProductVO productVo) {
			this.productDao.modifyProduct(productVo);
		}
		//관리자 페이지 상품 검색 정보 불러오기
		@Override
		public void productSelectAjax(Map map) {
			this.productDao.productSelectAjax(map);
		}
		//관리자 페이지 상품 조건 검색 카운트
		@Override
		public void getSearchCount(Map map) {
			this.productDao.getSearchCount(map);
		}
	
		
		@Override
		public void selectToday(Map map) {
			this.productDao.selectToday(map);
		}
		
		@Override
		   public void nameAll(Map map) {
		      productDao.nameAll(map);
		   }
}
