/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package model;

import com.sun.mail.smtp.SMTPMessage;
import java.net.PasswordAuthentication;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.Properties;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.mail.Message;
import javax.mail.MessagingException;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;

/**
 *
 * @author nmohamed
 */
public class SendMail {
    public static void SendMail(Mensaje m) {
        Properties props = new Properties();
//        props.put("mail.smtp.auth", "true");
//        props.put("mail.smtp.starttls.enable", "true");
//        props.put("mail.smtp.host", "smtp.gmail.com");
//        props.put("mail.smtp.port", "587");
//        props.put("mail.user", "nmohamed@eduwebgroup.com");
//        props.put("mail.password", "kokowawa1");
        String host = "smtp.gmail.com";
        props.put("mail.smtp.starttls.enable", "true");
        props.put("mail.smtp.host", host);
        props.put("mail.smtp.user", "info.ca.pan2018");
        props.put("mail.smtp.password", "Kokowawa1");
        props.put("mail.smtp.port", "587");
        props.put("mail.smtp.auth", "true");
//     
        Session session = Session.getDefaultInstance(props);
        for(String dest : m.getDestinatarios()){
            try {
                MimeMessage message = new MimeMessage(session);
                message.setFrom(new InternetAddress("info.ca.pan2018"));
                // put here if reciepient is not empty, incase the parent doe snot have an email on renweb

                message.setRecipients(Message.RecipientType.TO, InternetAddress.parse(dest));//dest
                message.setSubject(m.getAsunto());
                message.setContent(m.getTexto()+"<p> Este mensaje ha sido enviado por un sistema automático <br>"
                        + "Por favor no respondas directamente a este email.</p>", "text/html; charset=utf-8");
            //    message.setText(m.getBody());


    //            Transport.send(message);

             Transport transport = session.getTransport("smtp");
                transport.connect(host, "info.ca.pan2018", "Kokowawa1");
                transport.sendMessage(message, message.getAllRecipients());
                transport.close();
               System.out.println("Sent message successfully....");
              //  Class.forName("org.postgresql.Driver");
              //  Connection cn = DriverManager.getConnection("jdbc:postgresql://192.168.1.3:5432/Maintenance_jobs?user=eduweb&password=Madrid2016");
            //ActivityLog.log(m.getJob_id(),m.getRw_event_id(),m.getRecipient(),m.getBody(), cn);
//            Statement st = cn.createStatement();
            //st.executeUpdate("update jobs set lastrun = now() where id ="+m.getJob_id());

            }catch (MessagingException e) {
                throw new RuntimeException(e);
            }
        }
    }
}
