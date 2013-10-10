<%@ page language="java" contentType="text/html;charset=UTF-8"%>
<%@ page import="java.io.*,java.sql.*,java.text.*,javax.sql.*,java.util.*,javax.naming.*,oracle.jdbc.*" %>
<%!    String checknull(String xvalue) {
        return (xvalue == null) ? "" : xvalue;
    }

    String checknullzero(String xvalue) {
        return (xvalue == null) ? "0" : xvalue;
   }%><% try {
            Context initCtx = new InitialContext();
            Context envCtx = (Context) initCtx.lookup("java:comp/env");
            DataSource ds = (DataSource) envCtx.lookup("jdbc/nicobet");
            Connection conn = ds.getConnection();
           
            try {
                   CallableStatement cs = conn.prepareCall("{?=call mobil_login(?,?,?,?,?,?,?)}");
                   cs.registerOutParameter(1, java.sql.Types.VARCHAR);
                   cs.registerOutParameter(7, java.sql.Types.VARCHAR);
                   cs.registerOutParameter(8, java.sql.Types.VARCHAR);
                   cs.setString(2, "TR");
                   cs.setString(3, checknull((String) request.getRemoteAddr()));
                   cs.setString(4, checknullzero((String) session.getId()));
                   cs.setString(5, checknullzero(request.getParameter("username")));
                   cs.setString(6, checknullzero(request.getParameter("password")));
                   cs.execute();
                   out.println(checknull(cs.getString(1)));

                   if (!(checknullzero(cs.getString(7)).equals("0"))) {
                       session.setAttribute("sub_id", checknullzero(cs.getString(7)));
                       // session.getAttribute("sub_id");
                   } else {
                       session.setAttribute("sub_id", "0");
                   }
                   cs.close();
                } catch (Exception ee) {}

          conn.close();
            

          } catch (NamingException e) {
               out.println(e.toString());
           } catch (SQLException e) {  
               out.println(e.toString());}
   %>