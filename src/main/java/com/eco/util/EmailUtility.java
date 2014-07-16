package com.eco.util;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.util.ArrayList;
import java.util.Collection;
import java.util.Date;
import java.util.List;
import java.util.Properties;
 
import javax.mail.Message;
import javax.mail.MessagingException;
import javax.mail.Multipart;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.AddressException;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeBodyPart;
import javax.mail.internet.MimeMessage;
import javax.mail.internet.MimeMultipart;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.ServletException;
import javax.servlet.http.Part;


 
/**
 * A utility class for sending e-mail message with attachment.
 *
 */
public class EmailUtility {
     
	 // sets SMTP server properties
	static Properties props ;
	
	public EmailUtility(){
		props = new Properties();
		props.put("mail.smtp.auth", "true");
		props.put("mail.smtp.starttls.enable", "true");
		props.put("mail.smtp.host", "smtp.gmail.com");
		props.put("mail.smtp.port", "587");
	}
    /**
     * Sends an e-mail message from a SMTP host with a list of attached files. 
     * @throws ServletException 
     * @throws IOException 
     * @throws IllegalStateException 
     * 
     */
	
    public String sendEmailWithAttachment(String userName, String mailTo, HttpServletRequest request)
                    throws AddressException, MessagingException, IllegalStateException, IOException, ServletException {
    	List<File> attachedFiles = saveUploadedFiles(request);
    	try{
   		 // creates a new session with an authenticator
			Session session = Session.getInstance(props, new GMailAuthenticator(CommonConstants.USER, CommonConstants.PASSWORD));
    
           // creates a new e-mail message
			Message message = new MimeMessage(session);
    
			message.setFrom(new InternetAddress(CommonConstants.USER));
			message.addRecipient(Message.RecipientType.TO,new InternetAddress(mailTo));
			message.setSubject("Voice Message Received");
			message.setSentDate(new Date());
    
			// creates message part
			MimeBodyPart messageBodyPart = new MimeBodyPart();
			messageBodyPart.setText("You received a voice message from " + userName);
	
			// creates multi-part
			Multipart multipart = new MimeMultipart();
			multipart.addBodyPart(messageBodyPart);
	
			// adds attachments
			if (attachedFiles != null && attachedFiles.size() > 0) {
				for (File aFile : attachedFiles) {
				   MimeBodyPart attachPart = new MimeBodyPart();
				   attachPart.attachFile(aFile);
				   multipart.addBodyPart(attachPart);
				}
			}
    
			// sets the multi-part as e-mail's content
			message.setContent(multipart);
    
			// sends the e-mail
			Transport.send(message);
    	}catch(Exception e){
    		e.printStackTrace();
    	}finally {
            deleteUploadFiles(attachedFiles);
    	}
    	return "sendEmail";
    }
    
    /**
     * Saves files uploaded from the client and return a list of these files
     * which will be attached to the e-mail message.
     */
    private List<File> saveUploadedFiles(HttpServletRequest request)
            throws IllegalStateException, IOException, ServletException {
        List<File> listFiles = new ArrayList<File>();
        byte[] buffer = new byte[4096];
        int bytesRead = -1;
        try{
        	  Collection<Part> multiparts = request.getParts();
              if (multiparts.size() > 0) {
                  for (Part part : request.getParts()) {
                      // creates a file to be saved
                      String fileName = extractFileName(part);
                      if (fileName == null || fileName.equals("")) {
                          // not attachment part, continue
                          continue;
                      }
                       
                      File saveFile = new File(fileName);
                      System.out.println("saveFile: " + saveFile.getAbsolutePath());
                      FileOutputStream outputStream = new FileOutputStream(saveFile);
                       
                      // saves uploaded file
                      InputStream inputStream = part.getInputStream();
                      while ((bytesRead = inputStream.read(buffer)) != -1) {
                          outputStream.write(buffer, 0, bytesRead);
                      }
                      outputStream.close();
                      inputStream.close();
                       
                      listFiles.add(saveFile);
                  }
              }
        }catch (Exception e) {
			e.printStackTrace();
		}
		
        return listFiles;
    }
	
    /**
     * Retrieves file name of a upload part from its HTTP header
     */
    private String extractFileName(Part part) {
        String contentDisp = part.getHeader("content-disposition").toString();
        String[] items = contentDisp.split(";");
        for (String s : items) {
            if (s.trim().startsWith("filename")) {
                return s.substring(s.indexOf("=") + 2, s.length() - 1);
            }
        }
        return null;
    }
    
    /**
     * Deletes all uploaded files, should be called after the e-mail was sent.
     */
    private void deleteUploadFiles(List<File> listFiles) {
        if (listFiles != null && listFiles.size() > 0) {
            for (File aFile : listFiles) {
                aFile.delete();
            }
        }
    }
}
