<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%@ page import="com.oreilly.servlet.MultipartRequest" %>
<%@ page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy" %>
<%@ page import="java.util.*" %>
<%

	//파일 업로드
	
	//String uploadPath=request.getRealPath("/upload");
	String uploadPath="C:\\jsp\\test02\\src\\main\\webapp\\upload";
		//저장경로 지정
		//저장경로 에서는 \\로 폴더사이 표현
	
	//try-catch 구문 안에 있어 구문이 끝나고 메모리에서 사라지기 때문에 상단에 전역변수 사용
	int size = 10*1024*1024;
	String name="";
	String subject="";
	String filename1="";
	String filename2="";
	String origfilename1="";
	String origfilename2="";
	
	//예외처리 해야만 하는 구문이 있을 때 사용
	try{
		MultipartRequest multi=new MultipartRequest(request,uploadPath,size,"UTF-8",new DefaultFileRenamePolicy());
													//,저장경로,파일 사이즈(크기),깨짐방지, 3가지만 수정해서 사용한다
		name=multi.getParameter("name");
		subject=multi.getParameter("subject");
		
		Enumeration files=multi.getFileNames();
		
		String file1 =(String)files.nextElement();
		filename1=multi.getFilesystemName(file1);
		origfilename1= multi.getOriginalFileName(file1);
		
		String file2 =(String)files.nextElement();
		filename2=multi.getFilesystemName(file2);
		origfilename2=multi.getOriginalFileName(file2);
	}catch(Exception e){
		e.printStackTrace();
	}
%>
<html>
<body>

<form name="filecheck" action="fileCheck.jsp" method="post">
	<input type="hidden" name="name" value="<%=name%>">
	<input type="hidden" name="subject" value="<%=subject%>">
	<input type="hidden" name="filename1" value="<%=filename1%>"> <!-- 다운로드시 파일명 -->
	<input type="hidden" name="filename2" value="<%=filename2%>">
	<input type="hidden" name="origfilename1" value="<%=origfilename1%>"> <!-- 실제 파일명 -->
	<input type="hidden" name="origfilename2" value="<%=origfilename2%>">
</form>
<a href="#" onclick="javascript:filecheck.submit()">업로드 확인 및 다운로드 페이지 이동</a>

</body>
</html>