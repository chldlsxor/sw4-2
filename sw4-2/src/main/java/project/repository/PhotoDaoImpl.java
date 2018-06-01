package project.repository;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import project.bean.PhotoDto;

@Repository("PhotoDao")
public class PhotoDaoImpl implements PhotoDao{
	
	@Autowired
	private SqlSession sqlSession;

	@Override
	public List<PhotoDto> getPhoto(int no) {
		// TODO Auto-generated method stub
		return sqlSession.selectList("getPhoto",no);
	}

	@Override
	public void writePhoto(PhotoDto photoDto) {
		// TODO Auto-generated method stub
		sqlSession.insert("writePhoto", photoDto);
	}
	
}
