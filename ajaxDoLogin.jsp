﻿<%@ page language="java" pageEncoding="utf-8" contentType="text/html;charset=utf-8" %>
<%@ page trimDirectiveWhitespaces="true" %>

<%@page import="java.net.InetAddress" %>
<%@page import="org.json.simple.JSONObject" %>
<%@page import="org.json.simple.parser.JSONParser" %>
<%@page import="org.json.simple.parser.ParseException" %>
<%@page import="org.json.simple.JSONArray" %>
<%@page import="org.apache.commons.io.IOUtils" %>
<%@page import="java.util.*" %>

<%@include file="00_constants.jsp"%>
<%@include file="00_utility.jsp"%>
<%@include file="00_trustAllCerts.jsp"%>

<%
request.setCharacterEncoding("utf-8");
response.setContentType("text/html;charset=utf-8");
response.setHeader("Pragma","no-cache"); 
response.setHeader("Cache-Control","no-cache"); 
response.setDateHeader("Expires", 0); 

out.clear();	//注意，一定要有out.clear();，要不然client端無法解析XML，會認為XML格式有問題

JSONObject	obj=new JSONObject();

/*********************開始做事吧*********************/

String uid	= request.getParameter("uid");
String upassword	= request.getParameter("upassword");

if (uid==null || uid.length()<1 || upassword==null || upassword.length()<1){
	obj.put("resultCode", gcResultCodeParametersNotEnough);
	obj.put("resultText", gcResultTextParametersNotEnough);
	out.print(obj);
	out.flush();
	return;
}

int	i = 0;
java.lang.Boolean	bOK = false;
String				sResultCode	= gcResultCodeParametersValidationError;
String				sResultText	= gcResultTextParametersValidationError;

String				sciApiUrl	= gcSCIServerURL + "api/users/login";
String				sData		= "{\"username\":\"" + gcSCIUserName + "\", \"password\":\"" + gcSCIPassword + "\"}";
String				sResponse	= "";
String				ss	= "";

for (i=0;i<gcUsers.length;i++){
	if (uid.equals(gcUsers[i][0]) && upassword.equals(gcUsers[i][1])){
		session.setAttribute("uid", uid);	//將登入用戶資料存入 session 中
		bOK = true;
	}
}

if (bOK){	//登入 SCI API，取得 token
	try
	{
		HttpsURLConnection.setDefaultHostnameVerifier(this.new NullHostNameVerifier());
		SSLContext sc = SSLContext.getInstance("TLS");
		sc.init(null, trustAllCerts, new SecureRandom());
		HttpsURLConnection.setDefaultSSLSocketFactory(sc.getSocketFactory());
		URL u;
		u = new URL(sciApiUrl);
		HttpURLConnection uc = (HttpURLConnection)u.openConnection();
		uc.setRequestProperty ("Content-Type", "application/json");
		uc.setRequestProperty("contentType", "utf-8");
		uc.setRequestMethod("POST");
		//uc.setRequestProperty("Content-Type", "application/x-www-form-urlencoded"); 
		uc.setDoOutput(true);
		uc.setDoInput(true);
	
		byte[] postData = sData.getBytes("UTF-8");	//避免中文亂碼問題
		OutputStream os = uc.getOutputStream();
		os.write(postData);
		os.close();
	
		InputStream in = uc.getInputStream();
		BufferedReader r = new BufferedReader(new InputStreamReader(in));
		StringBuffer buf = new StringBuffer();
		String line;
		while ((line = r.readLine())!=null) {
			buf.append(line);
		}
		in.close();
		sResponse = buf.toString();	//取得Line回應值
		
	}catch (IOException e){ 
		sResponse = e.toString();
		writeLog("error", "Exception when send message to SCI: " + e.toString());
	}
	
	if (notEmpty(sResponse) && !sResponse.equals("{}")){
		ss = getJsonValue(sResponse, "id");
		if (notEmpty(ss)){
			session.setAttribute("token", ss);	//將登入用戶資料存入 session 中
			writeLog("info", "Successfully login to SCI, token= " + ss);
			sResultCode	= gcResultCodeSuccess;
			sResultText	= gcResultTextSuccess;
		}else{
			writeLog("error", "Failed to login SCI, response= " + sResponse);
			sResultCode	= gcResultCodeUnknownError;
			sResultText	= gcResultTextUnknownError;
		}
	}else{
		writeLog("error", "Failed to login to SCI: " + sResponse);
		sResultCode	= gcResultCodeUnknownError;
		sResultText	= sResponse;
	}
}	//if (bOK){	//登入 SCI API，取得 token


obj.put("resultCode", sResultCode);
obj.put("resultText", sResultText);
out.print(obj);
out.flush();
%>