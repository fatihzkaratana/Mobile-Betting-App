<%@ page language="java" contentType="text/html;charset=UTF-8"%>
<%@ page import="java.io.*,java.sql.*,java.text.*,javax.sql.*,java.util.*,javax.naming.*,oracle.jdbc.*" %>
<%!    String checknull(String xvalue) {
        return (xvalue == null) ? "" : xvalue;
    }
    public HttpServletRequest request;

    String checknullzero(String xvalue) {
        return (xvalue == null) ? "0" : xvalue;
   }%>
<% 
    out.print("" + session.getAttribute("sub_id"));
%>