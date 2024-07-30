<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%@ include file="/include/header.jsp" %>

<%
String uploadPath="C:\\jsp\\project01\\src\\main\\webapp\\upload";
int size = 10*1024*1024;

request.setCharacterEncoding("utf-8");

MultipartRequest multi = new MultipartRequest(request,uploadPath,size,"UTF-8",new DefaultFileRenamePolicy());
	//MultipartRequest에서 내장객체는 uploadPath,size,"UTF-8" 세가지를 조정한다

String code = multi.getParameter("code");
String gongji = multi.getParameter("gongji");
String subject = multi.getParameter("subject");
String comment = multi.getParameter("comment");
	// multi에 request내장객체가 있기때문에 여기서는 하지 않아도 된다.

subject = subject.replaceAll("'", "''" ); 
comment = comment.replaceAll("'", "''" );
	//좌측의 값을 우측의 값으로 치환
	// 작은따옴표를 인식하면 에러가 나기 때문에 필요하다

Enumeration files = multi.getFileNames();

//첨부파일1
//첨부파일1 존재한다면,
String file1 = (String)files.nextElement(); 
String file1_name = multi.getOriginalFileName(file1); //사용자가 올린 파일명
String file1_rename = multi.getFilesystemName(file1); //중복된 파일명을 새로운 파일명으로 변경 파일명+1의 형식으로 변환한다

//첨부파일1 없다면
if(file1_name == null){
	file1_name = ""; 
	file1_rename = ""; 
	//null 값이 아닌 비어있는 값으로 대체
	//위에서 전역변수로 두 번 선언했기 때문에 두 번 함
}

//오늘 날짜
Date today = new Date();
SimpleDateFormat cal = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
String signdate = cal.format(today);


////썸네일 ////

String file1_thumb = ""; //썸네일 파일명

if(!file1_rename.equals("")){ //첨부가 있다면
String oPath = uploadPath+"/"+file1_rename; // 원본 경로
File oFile = new File(oPath);

int index = oPath.lastIndexOf(".");
String ext = oPath.substring(index + 1); // 파일 확장자

file1_thumb = "thumb_" + oFile.getName(); //썸네일 파일명

String tPath = oFile.getParent() + File.separator + file1_thumb; // 썸네일 저장 경로 및 파일명
File tFile = new File(tPath);

double ratio = 2; // 이미지 축소 비율

try {
	BufferedImage oImage = ImageIO.read(oFile); // 원본이미지
	int tWidth = (int) (oImage.getWidth() / ratio); // 생성할 썸네일이미지의 너비
	int tHeight = (int) (oImage.getHeight() / ratio); // 생성할 썸네일이미지의 높이

	BufferedImage tImage = new BufferedImage(tWidth, tHeight, BufferedImage.TYPE_3BYTE_BGR); // 썸네일이미지
	Graphics2D graphic = tImage.createGraphics();
	Image image = oImage.getScaledInstance(tWidth, tHeight, Image.SCALE_SMOOTH);
	graphic.drawImage(image, 0, 0, tWidth, tHeight, null);
	graphic.dispose(); // 리소스를 모두 해제

	ImageIO.write(tImage, ext, tFile); //썸네일 저장
} catch (IOException e) {
	e.printStackTrace();

}

}


//디비 입력
String sql = "INSERT INTO "+code+" (id, name, subject, comment, signdate, ref, gongji, file1, file1_o, file1_s)";
	//DB의 칼럼명들과 1:1매칭 시켜주기 위함
sql = sql + " VALUES ('"+session_id+"', '"+session_name+"', '"+subject+"', '"+comment+"', '"+signdate+"', 0, '"+gongji+"','"+file1_rename+"','"+file1_name+"','"+file1_thumb+"')";
	//sql이라는 변수에 정보를 담아서 한번에 DB로 전송한다.
	//insert into (칼럼구분) value (값)을 두 줄로 쓴 것
	
Connection conn=DriverManager.getConnection(url, user, password); 
Statement stmt=conn.createStatement();
stmt.executeUpdate(sql);
	//인서트 친구
			
stmt.close();
conn.close();
	//열었으면 닫자
	
response.sendRedirect("list.jsp?code="+code);
	//인서트 완료 후 페이지 이동(여기선 게시판 목록으로 이동한다.)
%>