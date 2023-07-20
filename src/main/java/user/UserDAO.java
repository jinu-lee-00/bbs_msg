package user;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import bbs.Bbs;

public class UserDAO {
	
	private Connection conn;
	private PreparedStatement pstmt;
	private ResultSet rs;
	private PreparedStatement pstmt2;
	private ResultSet rs2;


// IF YOU USE MariaDB
	// public UserDAO() {
	// 	try {
	// 		String dbURL = "jdbc:mariadb://localhost/dlwlsdn38";
	// 		String dbID = "dlwlsdn38";
	// 		String dbPassword = "WRITE YOUR PASSWORD HERE";
	// 		Class.forName("org.mariadb.jdbc.Driver"); // 드라이버 찾기
	// 		conn = DriverManager.getConnection(dbURL, dbID, dbPassword);
	// 	} catch(Exception e) {
	// 		e.printStackTrace();
	// 	}
	// }

// IF YOU USE MySQL
	public UserDAO() {
		try {
			String dbURL = "jdbc:mysql://localhost:3306/BBS";
			String dbID = "root";
			String dbPassword = "WRITE YOUR PASSWORD HERE";
			Class.forName("com.mysql.jdbc.Driver"); // 드라이버 찾기
			conn = DriverManager.getConnection(dbURL, dbID, dbPassword);
		} catch(Exception e) {
			e.printStackTrace();
		}
	}
	
	public User getUser(String userID) {
		String SQL = "SELECT * FROM USER WHERE userID = ?";
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1, userID);
			rs = pstmt.executeQuery();
			while(rs.next()) {
				User user = new User(); //자바빈즈를 이용해 대응하는 값 넣어주기
				user.setUserID(rs.getString(1));
				user.setUserPassword(rs.getString(2));
				user.setUserName(rs.getString(3));
				user.setUserNickname(rs.getString(4));
				user.setUserGender(rs.getString(5));
				user.setUserEmail(rs.getString(6));
				user.setUserSmoke(rs.getString(7));
				user.setUserMarried(rs.getString(8));
				user.setUserEdu(rs.getString(9));
				user.setUserIncome(rs.getString(10));
				return user;
			}
		}catch(Exception e) {
			e.printStackTrace();
		}
		return null; // 데이터베이스 오류
	}
	
	
	public int login(String userID, String userPassword) {
		String SQL = "SELECT userPassword FROM USER WHERE userID = ?";
		try {
			pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1, userID);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				if(rs.getString(1).equals(userPassword)) {
					return 1; // 로그인 성공
				}
				else
					return 0; // 비밀번호 불일치
			}
			if (!rs.next() && userID == null) { // 아이디가 입력 안됨
				return -3;
			}
			else if(userPassword == null) { // 아이디 입력됐으나 비밀번호 입력 안됨
				return -4;
			}

			return -1; // 아이디가 없음
		} catch(Exception e) {
			e.printStackTrace();
		}
		return -2; // DB오류
	}
	
	public int isNicknameDuplicated(String userNickname) {
		String SQL = "SELECT COUNT(*) FROM USER WHERE userNickname=?";
		try {
			
		    pstmt2 = conn.prepareStatement(SQL);
		    pstmt2.setString(1, userNickname);
		    ResultSet rs2 = pstmt.executeQuery();
		    if(rs2.next()) {
		        int count = rs2.getInt(1);
		        if(count > 0)
		            return -1; 
		    }
	    } catch(Exception e) {
		e.printStackTrace();
	    }
		return 0;
		
	}
	


	
	public int join(User user) {
		String SQL = "INSERT INTO USER VALUES(?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
		try {
			if(user.getUserMarried().equals("기혼"))
				return -2;
			if(isNicknameDuplicated(user.getUserNickname()) == -1)
				return -3;
			pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1, user.getUserID());
			pstmt.setString(2, user.getUserPassword());
			pstmt.setString(3, user.getUserName());
			pstmt.setString(4, user.getUserNickname());
			pstmt.setString(5, user.getUserGender());
			pstmt.setString(6, user.getUserEmail());
			pstmt.setString(7, user.getUserSmoke());
			pstmt.setString(8, user.getUserMarried());
			pstmt.setString(9, user.getUserEdu());
			pstmt.setString(10, user.getUserIncome());
			
			return pstmt.executeUpdate();
		} catch(Exception e) {
			e.printStackTrace();
		}
		return -1; // ID나 닉네임이 이미 있는 경우
	}
}





