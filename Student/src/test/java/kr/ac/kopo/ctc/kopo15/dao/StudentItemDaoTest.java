package kr.ac.kopo.ctc.kopo15.dao;

import static org.junit.Assert.assertNotNull;
import static org.junit.Assert.assertTrue;
import static org.junit.jupiter.api.Assertions.assertEquals;

import java.util.ArrayList;
import java.util.List;

import org.junit.jupiter.api.Test;

import kr.ac.kopo.ctc.kopo15.domain.StudentItem;

public class StudentItemDaoTest {
//
//	@Test
//	void test() {
//		StudentItemDao studentItemDao = new StudentItemDaoImpl();
//		StudentItem studentItem = studentItemDao.selectOne(1);
//
//		assertEquals(studentItem.getName(), "아무개");
		
		
	//}
//		@Test
//		void test_createtable() {
//			StudentItemDao studentItemDao = new StudentItemDaoImpl();
//			assertTrue(studentItemDao.createTable());
//		}
//		@Test
//		void test_droptable() {
//			StudentItemDao studentItemDao = new StudentItemDaoImpl();
//			assertTrue(studentItemDao.dropTable());
//		}
//		@Test
//		void test_insert() {
//			StudentItemDao studentItemDao = new StudentItemDaoImpl();
//			assertTrue(studentItemDao.insertTable());
//		}
//		@Test
//		void test_selectall() {
//			StudentItemDao studentItemDao = new StudentItemDaoImpl();
//			assertNotNull(studentItemDao.selectAll());  //객채 A가 null이 아님을 확인한다.
//			List<StudentItem> stu_arr = studentItemDao.selectAll();
//			assertEquals(stu_arr.size(),9);//객체 A와 B가 같은 값을 가지는지 확인한다.
//		}
		@Test
		void test_selectone() {
			StudentItemDao studentItemDao = new StudentItemDaoImpl();
			StudentItem studentItem = studentItemDao.selectOne(209901);
			assertEquals(studentItem.getId(),209901);
			assertEquals(studentItem.getName(),"나연");
			assertEquals(studentItem.getKor(),95);
			assertEquals(studentItem.getEng(),100);
			assertEquals(studentItem.getMat(),95);
						
	}

}



