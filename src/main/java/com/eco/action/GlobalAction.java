package com.eco.action;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.util.ArrayList;
import java.util.Collection;
import java.util.List;
import java.util.Iterator;
import java.util.Map;
import java.util.Properties;
import java.util.Set;
import java.util.Map.Entry;

import javax.activation.*;

import com.opensymphony.xwork2.ActionSupport;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.ServletException;
import org.apache.struts2.ServletActionContext;
import com.eco.util.CommonConstants;
import com.eco.util.EmailUtility;

/**
* Sample global action for sending email
*/

public class GlobalAction extends ActionSupport{
	private static final long serialVersionUID = 1L;
	private String successMsg = null;
	private String warningMsg = null;
	
	@SuppressWarnings("unchecked")
	public String record() throws Exception{
		return "record";
	}
	@SuppressWarnings("unchecked")
	public String sendEmail() throws Exception{
		String returnMsg = "sendEmail";
		successMsg = null;
		warningMsg = null;
		String userName = null;
		String mailTo = null;
		String fileName = null;
		EmailUtility emailUtil = new EmailUtility();
	
		try{
			HttpServletRequest request = ServletActionContext.getRequest();
			
			Map<String, String[]> requestParamMap = request.getParameterMap();
			if(requestParamMap != null && requestParamMap.size() != 0){
				userName = ((requestParamMap.get(CommonConstants.USER_NAME)[0] != null && requestParamMap.get(CommonConstants.USER_NAME)[0].length() != 0) ? requestParamMap.get(CommonConstants.USER_NAME)[0] : null);
				mailTo = ((requestParamMap.get(CommonConstants.MAIL_TO)[0] != null && requestParamMap.get(CommonConstants.MAIL_TO)[0].length() != 0) ? requestParamMap.get(CommonConstants.MAIL_TO)[0] : null);
			}
			
			if(userName != null && mailTo != null){
				returnMsg = emailUtil.sendEmailWithAttachment(userName, mailTo, request);
			}
			 
		    if(userName == null || mailTo == null){
				warningMsg = CommonConstants.WARNING_MSG;
			}else{
				successMsg = CommonConstants.SUCCESS_MSG + mailTo;
			}
			
		} catch (Exception e) {
			successMsg = null;
			e.printStackTrace();
		} 
		return returnMsg;
	}
	
	public String getSuccessMsg() {
		return successMsg;
	}
	public void setSuccessMsg(String successMsg) {
		this.successMsg = successMsg;
	}
	public void setWarningMsg(String warningMsg) {
		this.warningMsg = warningMsg;
	}
	public String getWarningMsg() {
		return warningMsg;
	}
	
}
