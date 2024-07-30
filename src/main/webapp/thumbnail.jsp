<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%@ page import="java.awt.Image"%>
<%@ page import="java.awt.Graphics2D" %>
<%@ page import="java.awt.image.renderable.ParameterBlock" %>
<%@ page import="java.awt.image.BufferedImage" %>

<%@ page import="javax.media.jai.JAI" %>
<%@ page import="javax.media.jai.RenderedOp" %>

<%@ page import="javax.imageio.ImageIO" %>

<%@ page import="com.oreilly.servlet.MultipartRequest" %>
<%@ page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy" %>

<%@ page import="java.util.*" %>
<%@ page import="java.io.*" %>

<%
	//ServletContext context = request.getServletContext();
	//String imagePath=context.getRealPath("image");


//webapp 폴더에 존재하는 upload 폴더
	String uploadPath = "C:\\jsp\\project01\\src\\main\\webapp\\upload"; 
	int size = 1*1024*1024 ; //1메가

	String file1_rename = ""; //원본파일 리네임
	String file1_thumb = ""; //썸네일 네임

//// 파일 첨부 ////
	MultipartRequest multi = new MultipartRequest(request,uploadPath,size,"utf-8",new DefaultFileRenamePolicy());

	Enumeration files=multi.getFileNames();

	String file = (String)files.nextElement();
	file1_rename = multi.getFilesystemName(file); //파일명 중복여부를 따진 후 리네임 부여


//// 썸네일 ////
	String oPath = uploadPath+"/"+file1_rename; // 원본 경로
	
	File oFile = new File(oPath); //원본파일을 새로운 변수에 담는다 
	int index = oPath.lastIndexOf("."); //확장자 앞 . 설정
	String ext = oPath.substring(index + 1); // 파일명 뒤로 자르기 (확장자)

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

%>

첨부 파일명 : <%=file1_rename%><br>
썸네일 파일명 : <%=file1_thumb%>
