<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!-- 섬네일 이미지를 만들기 위한 JAI클래스, 그래픽 관련 클래스들 -->
<%@page import="java.awt.Graphics2D"%>
<%@page import="java.awt.image.renderable.ParameterBlock"%>
<%@page import="java.awt.image.BufferedImage"%>
<%@page import="javax.media.jai.JAI"%>
<%@page import="javax.media.jai.RenderedOp"%>
<%@page import="javax.imageio.ImageIO"%>

<!-- 이미지 업로드 관련 클래스들 -->
<%@page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy"%>
<%@page import="com.oreilly.servlet.MultipartRequest"%>
<%@page import="java.io.File"%>
<%@page import="java.util.Enumeration"%>

<%
	String imagePath = application.getRealPath("image"); //실제로 업로드 될 폴더의 경로 설정
	int size = 1 * 1024 * 1024; //업로드 사이즈 제한
	String filename = "";

	try {
		//이미지 업로드
		MultipartRequest multi = new MultipartRequest(request, imagePath, size, "utf-8", new DefaultFileRenamePolicy());

		//업로드 된 이미지 이름 얻어옴!
		Enumeration files = multi.getFileNames();
		String file = (String) files.nextElement();
		filename = multi.getFilesystemName(file);

	} catch (Exception e) {
		e.printStackTrace();
	}

	// 이 클래스에 변환할 이미지를 담는다.(이미지는 ParameterBlock을 통해서만 담을수 있다.)
	ParameterBlock pb = new ParameterBlock();
	pb.add(imagePath + "/" + filename);
	
	RenderedOp rOp = JAI.create("fileload", pb);

	//불러온 이미지를 BuffedImage에 담는다.
	BufferedImage bi = rOp.getAsBufferedImage();
	//thumb라는 이미지 버퍼를 생성, 버퍼의 사이즈는 100*100으로 설정.
	BufferedImage thumb = new BufferedImage(100, 100, BufferedImage.TYPE_INT_RGB);

	//버퍼사이즈 100*100으로 맞춰 그리자~
	Graphics2D g = thumb.createGraphics();
	g.drawImage(bi, 0, 0, 100, 100, null);

	/*출력할 위치와 파일이름을 설정하고 섬네일 이미지를 생성한다. 저장하는 타입을 jpg로 설정.*/
	File file = new File(imagePath + "/sm_" + filename);
	ImageIO.write(thumb, "jpg", file);
%>


<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>Insert title here</title>
		<meta name="viewport" content="width=device-width, initial-scale=1.0">
		<link href="css/bootstrap.min.css" rel="stylesheet">
		<link href="css/bootstrap-responsive.min.css" rel="stylesheet">
		<link href="css/base.css" rel="stylesheet">
		<script src="js/jquery-1.8.2.min.js"></script>
		<script src="js/bootstrap.min.js"></script>
	</head>

	<body>
	-원본 이미지-
	<br>
	<img src="image/<%=filename%>">
	<p>
		-섬네일 이미지<br> <img src="image/sm_<%=filename%>">
</body>
</html>
<script>
</script>