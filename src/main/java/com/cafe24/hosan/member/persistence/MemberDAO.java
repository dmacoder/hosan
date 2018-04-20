package com.cafe24.hosan.member.persistence;

import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.cafe24.hosan.member.domain.MemberAuthMailVO;
import com.cafe24.hosan.member.domain.MemberVO;
import com.cafe24.hosan.member.dto.LoginDTO;
import com.cafe24.hosan.member.dto.MemberDTO;
import com.cafe24.hosan.util.SearchMemberCriteria;


public interface MemberDAO {

	public int registMemberNotNullCol(MemberVO vo) throws Exception;
	
	public int hasId(String userId) throws Exception;
	
	public MemberVO login(LoginDTO dto) throws Exception;

	public int isValidAuthKey(String user_id, String password, String authkey);
	
	public int mergeAuthKey(MemberAuthMailVO vo);
	
	public int updateIsRegister(String is_regist, String auth_key, String user_id, String password);

	public String getSaltById(String user_id);

	public int confirmIdPassword(LoginDTO dto);

	public void keepLogin(Integer member_srl, String sessionKey, Date next);

	public MemberVO checkSessionKey(String value);
	
	public void uploadPicture(MemberVO vo) throws Exception;

	public int updatePassword(Map<String, Object> paramMap);

	public int deleteMember(String user_id);

	public int updatePasswordWithoutPrevPassword(String user_id, String newPassword);

	public String getAsteriskIdByNameAndEmail(String searchName, String searchEmail);

	public int hasIdByNameAndEmail(String search_name, String email_address);

	public int isValidAuthKeyWithoutPassword(String user_id, String auth_key);

	public void updateIsRegisterWithoutPassword(String string, String auth_key, String user_id);

	public MemberVO getUserInfoByEmail(String email_address);

	public int hasEmail(String email_address);

	public void updateEmail(Map<String, Object> paramMap);

	public MemberVO getUserInfoById(String user_id);

	public int updateMyInfo(MemberVO userInfo);
	
	public int getMemberSrlById(String user_id);

	public List<MemberDTO> getSearchMemberList(SearchMemberCriteria scri, HashMap<String, Object> map);

	public int getTotalMemberCount(SearchMemberCriteria scri);
	
}
