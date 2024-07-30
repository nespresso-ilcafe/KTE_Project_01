<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%@ include file="/include/header.jsp" %>

<%
String uploadPath="C:\\jsp\\project01\\src\\main\\webapp\\upload";
int size = 10*1024*1024;

request.setCharacterEncoding("utf-8");

MultipartRequest multi=new MultipartRequest(request,uploadPath,size,"UTF-8",new DefaultFileRenamePolicy());

String code = multi.getParameter("code");
String uid = multi.getParameter("uid");
String page_now = multi.getParameter("page_now");
String gongji = multi.getParameter("gongji");
String subject = multi.getParameter("subject");
String comment = multi.getParameter("comment");

//이스케이프 처리
subject = subject.replaceAll("'", "''" ); //좌측의 값을 우측의 값으로 치환
comment = comment.replaceAll("'", "''" );

//오늘 날짜
Date today = new Date();
SimpleDateFormat cal = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
String signdate = cal.format(today);

//첨부파일1
Enumeration files=multi.getFileNames();

String file1=(String)files.nextElement(); //첨부파일1 존재한다면
String file1_name=multi.getOriginalFileName(file1); //사용자가 올린 파일명
String file1_rename=multi.getFilesystemName(file1); //중복된 파일명을 새로운 파일명으로 변경

if(file1_name == null){ //첨부파일1 없다면
	file1_name = ""; //null 값이 아닌 비어있는 값으로 대체
	file1_rename = ""; //null 값이 아닌 비어있는 값으로 대체
}

///////////////////////////// 썸네일 //////////////////////////////////////////
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
String sql;
if(file1_name != null && file1_name != ""){ //첨부파일 존재
	sql = "update "+code+" set subject='"+subject+"',comment='"+comment+"',gongji='"+gongji+"',file1='"+file1_rename+"',file1_o='"+file1_name+"', file1_s='"+file1_thumb+"' where uid="+uid;
}else{
	sql = "update "+code+" set subject='"+subject+"',comment='"+comment+"',gongji='"+gongji+"' where uid="+uid;
}

Connection conn=DriverManager.getConnection(url, user, password); 
Statement stmt=conn.createStatement();
stmt.executeUpdate(sql);

stmt.close();
conn.close();

response.sendRedirect("list.jsp?code="+code);
%>