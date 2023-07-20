package msg;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

public class MsgDAO {
	
	private Connection conn;
	private ResultSet rs;
	
//	public MsgDAO() {
//		try {
//			String dbURL = "jdbc:mariadb://localhost/dlwlsdn38";
//			String dbID = "dlwlsdn38";
//			String dbPassword = "WRITE PASSWORD HERE";
//			Class.forName("org.mariadb.jdbc.Driver"); // 드라이버 찾기
//			conn = DriverManager.getConnection(dbURL, dbID, dbPassword);
//		} catch(Exception e) {
//			e.printStackTrace();
//		}
//	}
	
	public MsgDAO() {
		try {
			String dbURL = "jdbc:mysql://localhost:3306/BBS";
			String dbID = "root";
			String dbPassword = "6530";
			Class.forName("com.mysql.jdbc.Driver"); // 드라이버 찾기
			conn = DriverManager.getConnection(dbURL, dbID, dbPassword);
		} catch(Exception e) {
			e.printStackTrace();
		}
	}
	
	public String getDate() {
		String SQL = "SELECT NOW()";
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				return rs.getString(1);
			}
		}catch(Exception e) {
			e.printStackTrace();
		}
		return ""; // 데이터베이스 오류
	}
	
	
	public int getNext() {
		String SQL = "SELECT msgID FROM MSG ORDER BY msgID DESC";
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				return rs.getInt(1) + 1;
			}
			return 1; // 첫 번째 게시물인 경우
		}catch(Exception e) {
			e.printStackTrace();
		}
		return -1; // 데이터베이스 오류
	}
	
	public int write(String msgTitle, String fromUserID, String toUserID, String msgContent) {
		String SQL = "INSERT INTO MSG VALUE (?, ?, ?, ?, ?, ?)";
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1, getNext());
			pstmt.setString(2, msgTitle);
			pstmt.setString(3, fromUserID);
			pstmt.setString(4, toUserID);
			pstmt.setString(5, getDate());
			pstmt.setString(6, msgContent);
			return pstmt.executeUpdate();
		}catch(Exception e) {
			e.printStackTrace();
		}
		return -1; // 데이터베이스 오류
	}
	
	public ArrayList<Msg> getList(int pageNumber){
		String SQL = "SELECT * FROM MSG WHERE msgID < ? ORDER BY msgID DESC LIMIT 10";
		ArrayList<Msg> list = new ArrayList<Msg>();
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			/*getNext():마지막작성된 글의 번호 +1 에서 page당 10개씩 들어가니까 
	         뒷페이지로 넘어간 게시물들을 빼준다.
		 	그 뺀 값을 ?에 넣어서 현재 페이지의 게시글만 보이게 한다.*/
			pstmt.setInt(1, getNext() - (pageNumber - 1) * 10);
			rs= pstmt.executeQuery();
			 //SELECT로 받아온 값이 있을때까지 Msg에 ResultSet값 넣어주기
			while(rs.next()) {
				Msg msg = new Msg(); //자바빈즈를 이용해 대응하는 값 넣어주기
				msg.setMsgID(rs.getInt(1));
				msg.setMsgTitle(rs.getString(2));
				msg.setFromUserID(rs.getString(3));
				msg.setToUserID(rs.getString(4));
				msg.setMsgDate(rs.getString(5));
				msg.setMsgContent(rs.getString(6));
				list.add(msg);
			}
		}catch(Exception e) {
			e.printStackTrace();
		}
		return list;
	}
	
	public boolean nextPage(int pageNumber) {
		String SQL = "SELECT * FROM MSG WHERE msgID < ?";
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1, getNext() - (pageNumber - 1) * 10);
			rs = pstmt.executeQuery();
			while(rs.next()) {
				return true;
			}
		}catch(Exception e) {
			e.printStackTrace();
		}
		return false; // 데이터베이스 오류
	}
	
	public Msg getMsg(int msgID) {
		String SQL = "SELECT * FROM MSG WHERE msgID = ?";
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1, msgID);
			rs = pstmt.executeQuery();
			while(rs.next()) {
				Msg msg = new Msg(); //자바빈즈를 이용해 대응하는 값 넣어주기
				msg.setMsgID(rs.getInt(1));
				msg.setMsgTitle(rs.getString(2));
				msg.setFromUserID(rs.getString(3));
				msg.setToUserID(rs.getString(4));
				msg.setMsgDate(rs.getString(5));
				msg.setMsgContent(rs.getString(6));
				return msg;
			}
		}catch(Exception e) {
			e.printStackTrace();
		}
		return null; // 데이터베이스 오류
	}
	

}
