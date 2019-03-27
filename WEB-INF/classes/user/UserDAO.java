package user;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

import util.DatabaseUtil;

public class UserDAO {
	public int join(String userID, String userPassword, String userGrade, String userDepart, String userName, String userEmail, String userPhone, String person ) {
	      String SQL="INSERT INTO user (userID, userPassword, userGrade, userDepart, userName, userEmail, userPhone, person) VALUES (?,?,?,?,?,?,?,?)";
	      Connection conn=null;
	      PreparedStatement pstmt=null;
	      ResultSet rs=null;
	      try {
	         conn=DatabaseUtil.getConnection();//DB 접근; 안정적으로 접근하기 위해 따로 모듈화를 해주었다.
	         pstmt=conn.prepareStatement(SQL);
	         pstmt.setString(1, userID);//sql문 안에 있는 ?(물음표)에 사용자가 입력한 값을 set시킨다.
	         pstmt.setString(2, userPassword);
	         pstmt.setString(3, userGrade);
	         pstmt.setString(4, userDepart);
	         pstmt.setString(5, userName);
	         pstmt.setString(6, userEmail);
	         pstmt.setString(7, userPhone);
	         pstmt.setString(8, person);
	         return pstmt.executeUpdate();
	      } catch(Exception e){
	         e.printStackTrace();
	      } finally { //종료를 한 후에는 접근한 자원을 해제해 주어야 한다.
	         try {if(conn!=null) conn.close();} catch(Exception e) {e.printStackTrace();}
	         try {if(pstmt!=null) pstmt.close();} catch(Exception e) {e.printStackTrace();}
	         try {if(rs!=null) rs.close();} catch(Exception e) {e.printStackTrace();}
	      }
	      return -1;//회원가입 실패
	   }
	public boolean getAdminChecked(String userID) { 
		String SQL="SELECT adminChecked FROM user WHERE userID=?";
		Connection conn=null;
		PreparedStatement pstmt=null;
		ResultSet rs=null;
		try {
			conn=DatabaseUtil.getConnection();
			pstmt=conn.prepareStatement(SQL);
			pstmt.setString(1, userID);
			rs=pstmt.executeQuery();
			if(rs.next()) {
				return rs.getBoolean(1);
			}
		} catch(Exception e){
			e.printStackTrace();
		} finally { 
			try {if(conn!=null) conn.close();} catch(Exception e) {e.printStackTrace();}
			try {if(pstmt!=null) pstmt.close();} catch(Exception e) {e.printStackTrace();}
			try {if(rs!=null) rs.close();} catch(Exception e) {e.printStackTrace();}
		}
		return false;
	}
	
	public UserDTO getUser(String userID) {
		UserDTO user = new UserDTO();
		String SQL="SELECT * FROM user WHERE userID=?";
		Connection conn=null;
		PreparedStatement pstmt=null;
		ResultSet rs=null;
		try {
			conn=DatabaseUtil.getConnection();//DB �젒洹�; �븞�젙�쟻�쑝濡� �젒洹쇳븯湲� �쐞�빐 �뵲濡� 紐⑤뱢�솕瑜� �빐二쇱뿀�떎.
			pstmt=conn.prepareStatement(SQL);
			pstmt.setString(1, userID);
			rs = pstmt. executeQuery();
			if(rs.next()) {
				user.setUserID(userID);
				user.setUserPassword(rs.getString("userPassword"));
				user.setUserGrade(rs.getString("userGrade"));
				user.setUserDepart(rs.getString("userDepart"));
				user.setUserName(rs.getString("userName"));
				user.setAdminChecked(rs.getBoolean("adminChecked"));
				user.setUserEmail(rs.getString("userEmail"));
				user.setUserPhone(rs.getString("userPhone"));
				user.setPerson(rs.getString("person"));
			}
		} catch(Exception e){
			e.printStackTrace();
		} finally { //醫낅즺瑜� �븳 �썑�뿉�뒗 �젒洹쇳븳 �옄�썝�쓣 �빐�젣�빐 二쇱뼱�빞 �븳�떎.
			try {if(conn!=null) conn.close();} catch(Exception e) {e.printStackTrace();}
			try {if(pstmt!=null) pstmt.close();} catch(Exception e) {e.printStackTrace();}
			try {if(rs!=null) rs.close();} catch(Exception e) {e.printStackTrace();}
		}
		return user;//�쉶�썝媛��엯 �떎�뙣
	}
	
	
	public int login(String userID, String userPassword) {
		String SQL="SELECT userPassword FROM user WHERE userID=?";//�궗�슜�옄濡쒕��꽣 �엯�젰諛쏆� id�쓽 鍮꾨�踰덊샇瑜� 遺덈윭�� �궗�슜�븯寃좊떎.
		Connection conn=null;
		PreparedStatement pstmt=null;//�듅�젙�븳 sql臾몄옣�쓣 �꽦怨듭쟻�쑝濡� �닔�뻾�븷 �닔 �엳�룄濡�
		ResultSet rs=null;//�듅�젙�븳 sql臾몄옣�쓣 �떎�뻾�븳 �썑�쓽 寃곌낵瑜� 媛�吏�怨� 泥섎━瑜� �빐二쇨퀬�옄 �븷 �븣
		try {
			conn=DatabaseUtil.getConnection();//DB �젒洹�; �븞�젙�쟻�쑝濡� �젒洹쇳븯湲� �쐞�빐 �뵲濡� 紐⑤뱢�솕瑜� �빐二쇱뿀�떎.
			pstmt=conn.prepareStatement(SQL);
			pstmt.setString(1, userID);//sql臾� �븞�뿉 �엳�뒗 ?(臾쇱쓬�몴)�뿉 �궗�슜�옄媛� �엯�젰�븳 媛믪쓣 set�떆�궓�떎.
			rs=pstmt.executeQuery();
			if(rs.next()) {
				if(rs.getString(1).equals(userPassword)) {//�궗�슜�옄媛� �엯�젰�븳 �븘�씠�뵒�쓽 鍮꾨�踰덊샇媛� �엯�젰�븳 鍮꾨�踰덊샇�� �씪移섑븯�뒗吏�
					return 1;//濡쒓렇�씤 �꽦怨�
				}
				else {
					return 0;//鍮꾨�踰덊샇 ��由�
				}
			}
			return -1;//�븘�씠�뵒 �뾾�쓬
		} catch(Exception e){
			e.printStackTrace();
		} finally { //醫낅즺瑜� �븳 �썑�뿉�뒗 �젒洹쇳븳 �옄�썝�쓣 �빐�젣�빐 二쇱뼱�빞 �븳�떎.
			try {if(conn!=null) conn.close();} catch(Exception e) {e.printStackTrace();}
			try {if(pstmt!=null) pstmt.close();} catch(Exception e) {e.printStackTrace();}
			try {if(rs!=null) rs.close();} catch(Exception e) {e.printStackTrace();}
		}
		return -2;//�뜲�씠�꽣踰좎씠�뒪 �삤瑜�
	}
	
	public int update(String userID, String userPassword, String userGrade, String userDepart, String userName, String userEmail, String userPhone, String person ) {
		String SQL="UPDATE user SET userPassword=?, userDepart=?, userName=?, userGrade=?, userEmail=?, userPhone=?, person=? WHERE userID=?";
		Connection conn=null;
		PreparedStatement pstmt=null;
		ResultSet rs=null;
		try {
			conn=DatabaseUtil.getConnection();//DB �젒洹�; �븞�젙�쟻�쑝濡� �젒洹쇳븯湲� �쐞�빐 �뵲濡� 紐⑤뱢�솕瑜� �빐二쇱뿀�떎.
			pstmt=conn.prepareStatement(SQL);
			pstmt.setString(1, userPassword);
			pstmt.setString(2, userDepart);
			pstmt.setString(3, userName);
			pstmt.setString(4, userGrade);
			pstmt.setString(5, userEmail);
			pstmt.setString(6, userPhone);
			pstmt.setString(7, person);
			pstmt.setString(8, userID);
			return pstmt.executeUpdate();
		} catch(Exception e){
			e.printStackTrace();
		} finally { //醫낅즺瑜� �븳 �썑�뿉�뒗 �젒洹쇳븳 �옄�썝�쓣 �빐�젣�빐 二쇱뼱�빞 �븳�떎.
			try {if(conn!=null) conn.close();} catch(Exception e) {e.printStackTrace();}
			try {if(pstmt!=null) pstmt.close();} catch(Exception e) {e.printStackTrace();}
			try {if(rs!=null) rs.close();} catch(Exception e) {e.printStackTrace();}
		}
		return -1;//�쉶�썝媛��엯 �떎�뙣
	}
	
	public ArrayList<UserDTO> getListAdmin(String search, int pageNumber) {
		ArrayList<UserDTO> userList = null;
		Connection conn=null;
		PreparedStatement pstmt=null;
		ResultSet rs=null;
		String SQL="";
		
		
		try {
			SQL="SELECT * FROM user WHERE adminChecked=false AND CONCAT(userID) LIKE ? ORDER BY userName ASC LIMIT " + pageNumber*5 + ", " + 5;
			conn=DatabaseUtil.getConnection();//DB �젒洹�; �븞�젙�쟻�쑝濡� �젒洹쇳븯湲� �쐞�빐 �뵲濡� 紐⑤뱢�솕瑜� �빐二쇱뿀�떎.
			pstmt=conn.prepareStatement(SQL);
			pstmt.setString(1, "%" + search + "%");
			rs = pstmt. executeQuery();
			userList = new ArrayList<UserDTO>();
			while(rs.next()) {
				UserDTO user = new UserDTO();
				user.setUserID(rs.getString("userID"));
				user.setUserName(rs.getString("userName"));
				userList.add(user);
			}
		} catch(Exception e){
			e.printStackTrace();
		} finally { //醫낅즺瑜� �븳 �썑�뿉�뒗 �젒洹쇳븳 �옄�썝�쓣 �빐�젣�빐 二쇱뼱�빞 �븳�떎.
			try {if(conn!=null) conn.close();} catch(Exception e) {e.printStackTrace();}
			try {if(pstmt!=null) pstmt.close();} catch(Exception e) {e.printStackTrace();}
			try {if(rs!=null) rs.close();} catch(Exception e) {e.printStackTrace();}
		}
		return userList;//�쉶�썝媛��엯 �떎�뙣
	}

	public boolean setAdminChecked(String userID) { 
		String SQL="UPDATE user SET adminChecked =true WHERE userID=?";
		Connection conn=null;
		PreparedStatement pstmt=null;
		ResultSet rs=null;
		try {
			conn=DatabaseUtil.getConnection();
			pstmt=conn.prepareStatement(SQL);
			pstmt.setString(1, userID);
			pstmt.executeUpdate();
			return true;
		} catch(Exception e){
			e.printStackTrace();
		} finally { 
			try {if(conn!=null) conn.close();} catch(Exception e) {e.printStackTrace();}
			try {if(pstmt!=null) pstmt.close();} catch(Exception e) {e.printStackTrace();}
			try {if(rs!=null) rs.close();} catch(Exception e) {e.printStackTrace();}
		}
		return false;
	} 

	public int setGraduTrue(String userID) { 
		String SQL="UPDATE user SET gradu =true WHERE userID=?";
		Connection conn=null;
		PreparedStatement pstmt=null;
		ResultSet rs=null;
		try {
			conn=DatabaseUtil.getConnection();
			pstmt=conn.prepareStatement(SQL);
			pstmt.setString(1, userID);
			return pstmt.executeUpdate();
		} catch(Exception e){
			e.printStackTrace();
		} finally { 
			try {if(conn!=null) conn.close();} catch(Exception e) {e.printStackTrace();}
			try {if(pstmt!=null) pstmt.close();} catch(Exception e) {e.printStackTrace();}
			try {if(rs!=null) rs.close();} catch(Exception e) {e.printStackTrace();}
		}
		return -1;
	} 
	public int setGraduFalse(String userID) { 
		String SQL="UPDATE user SET gradu =false WHERE userID=?";
		Connection conn=null;
		PreparedStatement pstmt=null;
		ResultSet rs=null;
		try {
			conn=DatabaseUtil.getConnection();
			pstmt=conn.prepareStatement(SQL);
			pstmt.setString(1, userID);
			return pstmt.executeUpdate();
		} catch(Exception e){
			e.printStackTrace();
		} finally { 
			try {if(conn!=null) conn.close();} catch(Exception e) {e.printStackTrace();}
			try {if(pstmt!=null) pstmt.close();} catch(Exception e) {e.printStackTrace();}
			try {if(rs!=null) rs.close();} catch(Exception e) {e.printStackTrace();}
		}
		return -1;
	} 
	public ArrayList<UserDTO> getListUser(String search, int pageNumber, String userGrade, String userDepart, String graduSatisfy) {//관리자 학생관리------------------
	      ArrayList<UserDTO> userList = null;
	      Connection conn=null;
	      PreparedStatement pstmt=null;
	      ResultSet rs=null;
	      try {
	    	  if(graduSatisfy.equals("전체")) {
	    		 String SQL="SELECT * FROM user WHERE CONCAT(userID) LIKE ? AND userGrade LIKE ? AND userDepart LIKE ? AND adminChecked=false ORDER BY userName ASC LIMIT " + pageNumber*5 + ", " + 5;
	 	         conn=DatabaseUtil.getConnection();//DB �젒洹�; �븞�젙�쟻�쑝濡� �젒洹쇳븯湲� �쐞�빐 �뵲濡� 紐⑤뱢�솕瑜� �빐二쇱뿀�떎.
	 	         pstmt=conn.prepareStatement(SQL);
		         pstmt.setString(1, "%" + search + "%");
	    	  }else if(graduSatisfy.equals("충족")) {
		    		 String SQL="SELECT * FROM user WHERE CONCAT(userID) LIKE ? AND userGrade LIKE ? AND userDepart LIKE ? AND adminChecked=false AND gradu=true ORDER BY userName ASC LIMIT " + pageNumber*5 + ", " + 5;
		 	         conn=DatabaseUtil.getConnection();//DB �젒洹�; �븞�젙�쟻�쑝濡� �젒洹쇳븯湲� �쐞�빐 �뵲濡� 紐⑤뱢�솕瑜� �빐二쇱뿀�떎.
		 	         pstmt=conn.prepareStatement(SQL);
			         pstmt.setString(1, "%" + search + "%");
	    	  }else if(graduSatisfy.equals("미충족")) {
		    		 String SQL="SELECT * FROM user WHERE CONCAT(userID) LIKE ? AND userGrade LIKE ? AND userDepart LIKE ? AND adminChecked=false AND gradu=false ORDER BY userName ASC LIMIT " + pageNumber*5 + ", " + 5;
		 	         conn=DatabaseUtil.getConnection();//DB �젒洹�; �븞�젙�쟻�쑝濡� �젒洹쇳븯湲� �쐞�빐 �뵲濡� 紐⑤뱢�솕瑜� �빐二쇱뿀�떎.
		 	         pstmt=conn.prepareStatement(SQL);
			         pstmt.setString(1, "%" + search + "%");
	    	  }
	    	  
	         
	         if(userGrade.equals("전체")) {
	            pstmt.setString(2, "%");
	         }
	         else{pstmt.setString(2, userGrade);}
	         
	         if(userDepart.equals("전체")) {
	            pstmt.setString(3, "%");
	         }else {pstmt.setString(3, userDepart);}
	         
	         rs = pstmt. executeQuery();
	         
	         userList = new ArrayList<UserDTO>();
	         while(rs.next()) {
	            UserDTO user = new UserDTO();
	            user.setUserID(rs.getString("userID"));
	            user.setUserName(rs.getString("userName"));
	            user.setUserGrade(rs.getString("userGrade"));
	            user.setUserDepart(rs.getString("userDepart"));
	            user.setGradu(rs.getBoolean("gradu"));
	            user.setUserPassword(rs.getString("userPassword"));
	            userList.add(user);
	         }
	      } catch(Exception e){
	         e.printStackTrace();
	      } finally { //醫낅즺瑜� �븳 �썑�뿉�뒗 �젒洹쇳븳 �옄�썝�쓣 �빐�젣�빐 二쇱뼱�빞 �븳�떎.
	         try {if(conn!=null) conn.close();} catch(Exception e) {e.printStackTrace();}
	         try {if(pstmt!=null) pstmt.close();} catch(Exception e) {e.printStackTrace();}
	         try {if(rs!=null) rs.close();} catch(Exception e) {e.printStackTrace();}
	      }
	      return userList;//�쉶�썝媛��엯 �떎�뙣
	   }
	

	public int delUser(String userID) {
		Connection conn=null;
		PreparedStatement pstmt=null;
		ResultSet rs=null;
		String SQL="DELETE FROM user WHERE userID=?";
		try {
			conn=DatabaseUtil.getConnection();
			pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1, userID);
			return pstmt.executeUpdate();
		}catch(Exception e) {
			e.printStackTrace();
		} finally {
			try {if(conn!=null) conn.close();} catch(Exception e) {e.printStackTrace();}
			try {if(pstmt!=null) pstmt.close();} catch(Exception e) {e.printStackTrace();}
			try {if(rs!=null) rs.close();} catch(Exception e) {e.printStackTrace();}
		}
		return -1;
	}
}
