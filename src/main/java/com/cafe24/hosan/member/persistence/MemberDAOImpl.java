package com.cafe24.hosan.member.persistence;

import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import com.cafe24.hosan.member.domain.MemberAuthMailVO;
import com.cafe24.hosan.member.domain.MemberVO;
import com.cafe24.hosan.member.dto.LoginDTO;
import com.cafe24.hosan.member.dto.MemberDTO;
import com.cafe24.hosan.util.SHA256;
import com.cafe24.hosan.util.SearchMemberCriteria;

@Repository
public class MemberDAOImpl implements MemberDAO{
	@Inject
	private SqlSession sqlSession;
	private static String namespace = "com.cafe24.hosan.mapper.MemberMapper";
	@Override
	public int registMemberNotNullCol(MemberVO vo) {
		
		//sqlSession.selectList
		//sqlSession.update
		//sqlSession.delete
		int affected = sqlSession.insert(namespace + ".insert", vo);		

		return affected;
	}

	
	@Override
	public int hasId(String userId) {
		
		//System.out.println("맵퍼호출"+namespace+".hasId" + userId);
		int hasId = sqlSession.selectOne(namespace+".hasId", userId);
		return hasId;
	}
	
	@Override
	public int hasIdByNameAndEmail(String search_name, String email_address) {
		Map<String, Object> paramMap = new HashMap<String, Object>();
		paramMap.put("user_name", search_name);
		paramMap.put("email_address", email_address);
		int hasId = sqlSession.selectOne(namespace+".hasIdByNameAndEmail", paramMap);
		return hasId;
	}
	
	
	@Override
	public MemberVO login(LoginDTO dto) throws Exception {
		return sqlSession.selectOne(namespace + ".login", dto);
	}


	@Override
	public int isValidAuthKey(String user_id, String password, String auth_key) {
		
		 Map<String, Object> paramMap = new HashMap<String, Object>();

		    paramMap.put("user_id", user_id);
		    paramMap.put("password", password);
		    
		    paramMap.put("auth_key", auth_key);
		    
		int isValidKey = sqlSession.selectOne(namespace+".isValidAuthKey", paramMap);

		return isValidKey;
	}


	@Override
	public int updateIsRegister(String is_register, String auth_key, String user_id, String password) {
		 Map<String, Object> paramMap = new HashMap<String, Object>();

		 paramMap.put("is_register", is_register);
		 
		    paramMap.put("user_id", user_id);
		    paramMap.put("password", password);
		    
		    paramMap.put("auth_key", auth_key);
		
		int affected = sqlSession.update(namespace+".updateIsRegister", paramMap);
		
		return affected;
	}


	@Override
	public int mergeAuthKey(MemberAuthMailVO vo) {
		int affected = sqlSession.update(namespace+".mergeAuthKey", vo);
		return affected;
	}


	@Override
	public String getSaltById(String user_id) {
		
		//MemberDAO dao = sqlSession.getMapper(MemberDAO.class);
		//return dao.getSaltById(user_id);
		
		return sqlSession.selectOne(namespace+".getSaltById", user_id);
		
		
	}


	@Override
	public int confirmIdPassword(LoginDTO dto) {
		

		//MemberDAO dao = sqlSession.getMapper(MemberDAO.class);
		//return dao.confirmIdPassword(dto);
		
		System.out.println("아이디 : " + dto.getUser_id());
		System.out.println("비번 : " + dto.getPassword());
		return sqlSession.selectOne(namespace+".confirmIdPassword", dto);
		
	}

	@Override
	public void keepLogin(Integer member_srl, String sessionKey, Date next) {
		Map<String, Object> paramMap = new HashMap<String, Object>();
		paramMap.put("member_srl", member_srl);
		paramMap.put("sessionKey", sessionKey);
		paramMap.put("next", next);

		sqlSession.update(namespace + ".keepLogin", paramMap);
	}
	
	@Override
	public MemberVO checkSessionKey(String value) {
		return sqlSession.selectOne(namespace + ".checkSessionKey", value);
	}
	
	@Override
	public void uploadPicture(MemberVO vo) throws Exception {
		sqlSession.insert(namespace + ".uploadPicture", vo);
	}


	@Override
	public int updatePassword(Map<String, Object> paramMap) {
		return sqlSession.update(namespace+".updatePassword", paramMap);
	}


	@Override
	public int deleteMember(String user_id) {
		return sqlSession.delete(namespace+".deleteMember", user_id);		
		
	}


	@Override
	public int updatePasswordWithoutPrevPassword(String user_id, String newPassword) {
		Map<String, Object> paramMap = new HashMap<String, Object>();
		// 새로운 솔트 생성
		String salt = SHA256.generateSalt();
		newPassword = SHA256.encrypt(newPassword, salt);
		paramMap.put("user_id", user_id);
		paramMap.put("newPassword", newPassword);
		paramMap.put("salt", salt);
		
		return sqlSession.update(namespace+".updatePasswordWithoutPrevPassword", paramMap);
	}


	//아이디 찾기 이름,이메일로 아이디 검색후 asterisk로 힌트 주기
	@Override
	public String getAsteriskIdByNameAndEmail(String searchName, String searchEmail) {
		Map<String, Object> paramMap = new HashMap<String, Object>();
		paramMap.put("user_name", searchName);
		paramMap.put("email_address", searchEmail);
		
		return sqlSession.selectOne(namespace+".getAsteriskIdByNameAndEmail", paramMap);
	}


	@Override
	public int isValidAuthKeyWithoutPassword(String user_id, String auth_key) {
		Map<String, Object> paramMap = new HashMap<String, Object>();
		paramMap.put("user_id", user_id);
		paramMap.put("auth_key", auth_key);
		
		return sqlSession.selectOne(namespace+".isValidAuthKeyWithoutPassword", paramMap);
	}


	@Override
	public void updateIsRegisterWithoutPassword(String string, String auth_key, String user_id) {
		// TODO Auto-generated method stub
		
	}


	@Override
	public MemberVO getUserInfoByEmail(String email_address) {
		
		return sqlSession.selectOne(namespace+".getUserInfoByEmail", email_address);
	}


	@Override
	public int hasEmail(String email_address) {
		int hasEmail = sqlSession.selectOne(namespace+".hasEmail", email_address);
		return hasEmail;
	}


	@Override
	public void updateEmail(Map<String, Object> paramMap) {
		sqlSession.update(namespace+".updateEmail", paramMap);
		
	}


	@Override
	public MemberVO getUserInfoById(String user_id) {
		return sqlSession.selectOne(namespace+".getUserInfoById", user_id);
	}


	@Override
	public int updateMyInfo(MemberVO userInfo) {
		return sqlSession.update(namespace+".updateMyInfo", userInfo);
	}


	@Override
	public int getMemberSrlById(String user_id) {
		// TODO Auto-generated method stub
		return sqlSession.selectOne(namespace+".getMemberSrlById", user_id);
	}


	@Override
	public List<MemberDTO> getSearchMemberList(SearchMemberCriteria scri, HashMap<String, Object> map) {
		// TODO Auto-generated method stub
		return sqlSession.selectList(namespace+".getSearchMemberList", scri);
	}


	@Override
	public int getTotalMemberCount(SearchMemberCriteria scri) {
		// TODO Auto-generated method stub
		return sqlSession.selectOne(namespace+".getTotalMemberCount", scri);
	}





}
