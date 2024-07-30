<%@page import="java.sql.Statement"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@ page import="com.oreilly.servlet.MultipartRequest" %>
<%@ page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy" %>
<%@ page import="java.util.*" %>


<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.Date"%>

<%@ page import="java.awt.Image"%>
<%@ page import="java.awt.Graphics2D" %>
<%@ page import="java.awt.image.renderable.ParameterBlock" %>
<%@ page import="java.awt.image.BufferedImage" %>

<%@ page import="javax.media.jai.JAI" %>
<%@ page import="javax.media.jai.RenderedOp" %>

<%@ page import="javax.imageio.ImageIO" %>
<%@ page import="java.io.*" %>

<%@ page import="java.net.URL, java.net.HttpURLConnection" %>
<%@ page import="java.io.PrintWriter" %>
<%@ page import="org.json.JSONObject, org.json.JSONArray" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="java.util.TimeZone" %>

<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="java.util.TimeZone" %>
<%@ page import="java.util.Date" %>



<%@ page language="java" contentType="text/html; charset=UTF-8" 
	pageEncoding="UTF-8"%>



<%
//디비 접속	
Class.forName("org.mariadb.jdbc.Driver");
//Class.forName("com.mysql.jdbc.Driver");
String url="jdbc:mariadb://localhost:3307/tia";
String user="root";
String password="1111";
%>