package com.example.dao;

import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.example.vo.ProductVO;

@Repository("productDao")
public class ProductDAOImpl implements ProductDAO{
	@Autowired
	SqlSession sqlSession;

	@Override
	public void selectProductOne(Map map) {
		this.sqlSession.selectList("Product.selectProductOne",map);
	}
/////////////////////////////////현주거/////////////////////////////////
	@Override
	public void selectAll(Map map) {
		this.sqlSession.selectList("Product.selectProductListAll",map);
	}

	@Override
	public void readAny(Map map) {
		this.sqlSession.selectList("Product.selectAnySP", map);
	}

	@Override
	public void readNew(Map map) {
		this.sqlSession.selectList("Product.selectNewSP", map);
	}
	@Override
	public void SearchManyPopularityProduct(Map map) {
		this.sqlSession.selectList("Product.SearchManyPopularityProduct",map);	
	}
	@Override
	public void SearchRecentlyProduct(Map map) {
		this.sqlSession.selectList("Product.SearchRecentlyProduct",map);
	}
	@Override
	public void selectProductGrape1(Map map) {
		this.sqlSession.selectList("Product.selectProductGrape1",map);
	}
	@Override
	public void selectProductGrape2(Map map) {
		this.sqlSession.selectList("Product.selectProductGrape2",map);
	}
	//////////////////////////////////////////////////////////////////////////////////
	//상품 소분류 목록
	@Override
	public void selectOneKind(Map map) {
		this.sqlSession.selectOne("Product.select_productListOne",map);
	}
	//상품 대분류 목록
	@Override
	public void selectOneKinds(Map map) {
		this.sqlSession.selectList("Product.select_productListOnes",map);
	}
	//상품 정보 불러오기
	@Override
	public void selectProduct(Map map) {
		this.sqlSession.selectList("Product.selectProductOne",map);
	}
	//상품 전체 목록
	@Override
	public void select_productListAll(Map map) {
		this.sqlSession.selectList("Product.select_productListAll",map);
	}
	
	//상품 전체 카운트
	@Override
	public void getTotalCount(Map map) {
		this.sqlSession.selectOne("Product.selectTotalCountSP", map);
	}
	//상품 대분류 카운트
	@Override
	public void getTypeCount(Map map) {
		this.sqlSession.selectOne("Product.selectTypeCountSP", map);
	}
	//상품 소분류 카운트
	@Override
	public void getKindCount(Map map) {
		this.sqlSession.selectOne("Product.selectKindCountSP", map);
	}
	
	
	
	//관리자 페이지 상품 등록
		@Override
		public void insertProduct(ProductVO productVo) {
			this.sqlSession.insert("Product.insertProduct", productVo);
		}
		//관리자 페이지 상품 삭제
		@Override
		public void deleteProduct(int productid) {
			this.sqlSession.delete("Product.deleteProduct", productid);
		}
		//관리자 페이지 정보 불러오기
		@Override
		public void infoProduct(Map map) {
			this.sqlSession.selectOne("Product.infoProduct", map);
		}
		//관리자 페이지 상품 수정
		@Override
		public void modifyProduct(ProductVO productVo) {
			this.sqlSession.update("Product.modifyProduct", productVo);
		}
		//관리자 페이지 상품 검색 정보 불러오기
		@Override
		public void productSelectAjax(Map map) {
			this.sqlSession.selectList("Product.productSelectAjax", map);
		}
		//관리자 페이지 상품 조건 검색 카운트
		@Override
		public void getSearchCount(Map map) {
			this.sqlSession.selectOne("Product.selectSearchCountSP", map);
		}
		
		@Override
		public void selectToday(Map map) {
			this.sqlSession.selectList("todayselect", map); // 오늘 본 상품
		}
		
		@Override
		   public void nameAll(Map map) {
		      this.sqlSession.selectList("Product.select_productNameAll",map);
		   }
}

