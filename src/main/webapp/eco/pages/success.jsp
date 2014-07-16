<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%>
<html lang="en">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<meta name="apple-mobile-web-app-capable" content="yes">
  <head>
    <meta charset="utf-8">
    <title>HTML5 Audio Editor</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta name="description" content="VoiceRecorder">
    <meta name="author" content="TZ">
     <link href="<%=path%>/bootstrap/css/bootstrap.css" rel="stylesheet">
    <style>
      body {
        padding-top: 60px; /* 60px to make the container go all the way to the bottom of the topbar */
      }
      .soundBite input {
        margin-right: 4px;
      }
    </style>
    <link href="<%=path%>/bootstrap/css/bootstrap-responsive.css" rel="stylesheet">

    <!-- Le fav and touch icons -->
    <link rel="shortcut icon" href="<%=path%>/bootstrap/ico/favicon.ico">
    <link rel="apple-touch-icon-precomposed" sizes="144x144" href="<%=path%>/bootstrap/ico/apple-touch-icon-144-precomposed.png">
    <link rel="apple-touch-icon-precomposed" sizes="114x114" href="<%=path%>/bootstrap/ico/apple-touch-icon-114-precomposed.png">
    <link rel="apple-touch-icon-precomposed" sizes="72x72" href="<%=path%>/bootstrap/ico/apple-touch-icon-72-precomposed.png">
    <link rel="apple-touch-icon-precomposed" href="<%=path%>/bootstrap/ico/apple-touch-icon-57-precomposed.png">
  </head>
  <body>
  <div class="recorder container">
      <p>**Make sure you are enabling Microphone Access</p>

      <h2>Record</h2>
      <p>
        <button class="btn btn-primary" onclick="startRecording(this);">Record</button>
        <button class="btn btn-warning" onclick="stopRecording(this);" disabled>Stop</button>
      </p>
    </div>
   </body>
   </html>