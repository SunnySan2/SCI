<%@ page language="java" pageEncoding="utf-8" contentType="text/html;charset=utf-8" %>
<%!

//Database連線參數
public static final String	gcDataSourceNameCMSIOT						= "jdbc/cmsiot";

//登入帳號
public static final String[][]	gcUsers								= {{"Sunny", "Sunny"}
																		, {"frank", "2222"}
																		, {"APC", "APC123"}
																	  };

//SCI API server URL
public static final String gcSCIServerURL							= "https://172.20.1.16/";
public static final String gcSCIUserName							= "user04";
public static final String gcSCIPassword							= "1qaz@WSX";

/*****************************************************************************/

//ResultCode及ResultText定義
public static final String	gcResultCodeSuccess						= "00000";
public static final String	gcResultTextSuccess						= "Success";
public static final String	gcResultCodeParametersNotEnough			= "00004";
public static final String	gcResultTextParametersNotEnough			= "Parameter not enough!";
public static final String	gcResultCodeParametersValidationError	= "00005";
public static final String	gcResultTextParametersValidationError	= "Parameter is incorrect!";
public static final String	gcResultCodeNoDataFound					= "00006";
public static final String	gcResultTextNoDataFound					= "No data found!";
public static final String	gcResultCodeNoLoginInfoFound			= "00007";
public static final String	gcResultTextNoLoginInfoFound			= "Unable to find your login account, might be session timeout, please login again!";
public static final String	gcResultCodeNoPriviledge				= "00008";
public static final String	gcResultTextNoPriviledge				= "You are not authorized to process this job!";
public static final String	gcResultCodeWrongIdOrPassword			= "00009";
public static final String	gcResultTextWrongIdOrPassword			= "Incorrect login ID or password, please re-login!";
public static final String	gcResultCodeDBTimeout					= "99001";
public static final String	gcResultTextDBTimeout					= "Database connection failed.";
public static final String	gcResultCodeDBOKButMailBodyFail			= "99002";
public static final String	gcResultTextDBOKButMailBodyFail			= "成功將資料寫入資料庫，但無法產生通知郵件內容!";
public static final String	gcResultCodeDBOKButUserMailFail			= "99003";
public static final String	gcResultTextDBOKButUserMailFail			= "成功將資料寫入資料庫，無法取得下個簽核人員的Email!";
public static final String	gcResultCodeDBOKButMailSendFail			= "99004";
public static final String	gcResultTextDBOKButMailSendFail			= "成功將資料寫入資料庫，但寄送通知信件失敗!";
public static final String	gcResultCodeMailSendFail				= "99005";
public static final String	gcResultTextMailSendFail				= "寄送通知信件失敗!";
public static final String	gcResultCodeUnknownError				= "99999";
public static final String	gcResultTextUnknownError				= "Unknown error!";

//日期格式
public static final String	gcDateFormatDateDashTime				= "yyyyMMdd-HHmmss";
public static final String	gcDateFormatDateTime					= "yyyyMMddHHmmss";
public static final String	gcDateFormatSlashYMDTime				= "yyyy/MM/dd HH:mm:ss";
public static final String	gcDateFormatYMD							= "yyyyMMdd";
public static final String	gcDateFormatSlashYMD					= "yyyy/MM/dd";
public static final String	gcDateFormatdashYMD						= "yyyy-MM-dd";

%>
