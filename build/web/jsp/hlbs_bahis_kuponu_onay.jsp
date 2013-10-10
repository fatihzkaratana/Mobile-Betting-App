<%@ page language="java" contentType="text/html;charset=UTF-8"%>
<%@ include file="include_dosya/Top.jsp" %>
<%@ include file="include_dosya/Connection.jsp" %>
<% xwep_name = "hlbs_bahis_kuponu_onay.jsp"; %>
<%@ include file="include_dosya/JspDefault.jsp" %>  
<%@ include file="include_dosya/Sayfa_UstUst.jsp" %>
<%
/*
 FUNCTION check_livecode_inselect (
   xsub_id    IN       VARCHAR2,
   xbeca_id   IN       NUMBER,
   xerrorno   OUT      VARCHAR2
)
   RETURN VARCHAR2
*/

if (!(checknullzero((String)session.getAttribute("beca_id")).equals("0"))) {
   try {	
         CallableStatement cs = conn.prepareCall("{?=call check_livecode_inselect(?,?,?)}");	

         cs.registerOutParameter(1, java.sql.Types.VARCHAR);    
         cs.registerOutParameter(4, java.sql.Types.VARCHAR);   			 
		 		 
         cs.setString(2, checknullzero((String)session.getAttribute("sub_id")));   	
         cs.setString(3, checknullzero((String)session.getAttribute("beca_id"))); 		 		 
         cs.execute();
         xReturn = cs.getString(1);
		 xError = checknull(cs.getString(4));
   
         cs.close();   	
         } catch (SQLException e) { }	
}	

/*
FUNCTION insupd_hlbs_betcardtweb (
   xcomputer_name      IN       VARCHAR2,
   xtcp_ip             IN       VARCHAR2,
   xbeca_session       IN       VARCHAR2,
   xsub_id             IN       VARCHAR2,
   xbeca_id            IN       VARCHAR2,
   xbeca_stake         IN       VARCHAR2,
   xbeca_combination   IN       VARCHAR2,
   xbeca_where         IN       VARCHAR2,
   xerror              OUT      VARCHAR2
)
   RETURN VARCHAR2
*/

if (!(checknullzero((String)session.getAttribute("beca_id")).equals("0"))  && xError.length() < 2) {
   try {	
         CallableStatement cs = conn.prepareCall("{?=call insupd_hlbs_betcardtweb(?,?,?,?,?,?,?,?,?)}");	

         cs.registerOutParameter(1,   java.sql.Types.VARCHAR);    
         cs.registerOutParameter(10,  java.sql.Types.VARCHAR);   			 
		 		 
         cs.setString(2, xHOST);   	
         cs.setString(3, xTCP_IP);  
         cs.setString(4, xSessionId);   			 
         cs.setString(5, checknullzero((String)session.getAttribute("sub_id")));   	
         cs.setString(6, checknullzero((String)session.getAttribute("beca_id"))); 		 		 
         cs.setString(7, checknullzero(request.getParameter("beca_stake"))); 		 
         cs.setString(8, checknull(request.getParameter("beca_combination"))); 		
         cs.setString(9, "W"); 		

         cs.execute();

         xReturn = cs.getString(1);
	 xError = checknull(cs.getString(10));
   
         cs.close();   	
         } catch (SQLException e) {
         }	
}	
%>	
<%
/*
FUNCTION create_hlbs_betcardmast_web (
   xcomputer_name   IN       VARCHAR2,
   xtcp_ip          IN       VARCHAR2,
   xbeca_session    IN       VARCHAR2,
   xsub_id          IN       VARCHAR2,
   xbeca_id         IN       VARCHAR2,
   xbeca_where      IN       VARCHAR2,   
   xerror           OUT      VARCHAR2
)
   RETURN VARCHAR2
 */
if (checknullzero((String)session.getAttribute("beca_id")).length() > 6 && xError.length() < 2) {
   try {	
         CallableStatement cs = conn.prepareCall("{?=call create_hlbs_betcardmast_web(?,?,?,?,?,?,?)}");	

         cs.registerOutParameter(1, java.sql.Types.VARCHAR);    
         cs.registerOutParameter(8, java.sql.Types.VARCHAR);   			 

         cs.setString(2, xHOST);   	
         cs.setString(3, xTCP_IP);  
         cs.setString(4, xSessionId);   			 
         cs.setString(5, checknullzero((String)session.getAttribute("sub_id")));   			 		 
         cs.setString(6, checknullzero((String)session.getAttribute("beca_id"))); 		 		 
         cs.setString(7, "W");   			 		 
		 
         cs.execute();  

         xReturn = cs.getString(1);
         xError = checknull(cs.getString(8));
		  
         cs.close();   	
         } catch (SQLException e) {
          // out.println("<P>" +       e.getErrorCode() + " \n <P>");
          // out.println("<P>" +       e.getMessage() + " \n <P>");
         }	
}	
%>	
<%		
if (xError.length() < 2) {
 String   xacceptbet_count = "0";
 try { 
   Statement stmtsql = conn.createStatement ();
   ResultSet rsetsql = stmtsql.executeQuery ("SELECT /*+ INDEX(hlbs_betcardt pri_key_hlbs_betcardt) */  ct.beca_id, ct.sub_id, to_char(ct.beca_stake,'9999990.00') beca_stake,  to_char(ct.beca_staketotal,'99999990.00') beca_staketotal,  to_char(ct.beca_returntotal,'99999990.00') beca_returntotal,  to_char(ct.beca_returnrate,'999990.00') beca_returnrate, ct.beca_combination, ct.beca_gameselect, ct.beca_acceptbet, ct.beca_status, ct.wem_code, ct.sub_id  FROM hlbs_betcardt ct  where ct.beca_id = "+checknullzero((String)session.getAttribute("beca_id"))) ;

   while (rsetsql.next()) {
 session.setAttribute("createbet","1") ;
 %>
	<table cellpadding="0" cellspacing="0" width="100%">		
		<tr>
			<td width="78%" style="background-color:#333333;">

					<table border="0" width="100%">
			          <tr>
			            <td width="25%" class="texttitle_input">Bahis Tutarı</td>
			            <td width="25%" class="texttitle">Bahis Oranı</td>
			            <td width="28%" class="texttitle">Kazanç</td>
			          </tr>
			          <tr>
			            <td> <input name="beca_stake" class="textdisplay" readonly  value="<%=checknull(rsetsql.getString("beca_staketotal"))%>"  type="text" style="width:75px;text-align:right;"/></td>
			            <td><input name="beca_rate" class="textdisplay" readonly value="<%=checknullzero(rsetsql.getString("beca_returnrate"))%>" type="text" style="width:75px;"/></td>
						<td><input name="beca_return" class="textdisplay" readonly value="<%=checknullzero(rsetsql.getString("beca_returntotal"))%>" type="text" style="width:75px;"/></td>
			          </tr>
					</table>
			</td>
			<td width="22%" style="background-color:#333333;" width="330px" height="8px">
						  <table border="0" width="100%">
			               <tr><td>	<a class="button" onclick="get_iptal();"><span>Iptal</span></a></td></tr>
						   <tr><td>	<a class="button" onclick="get_kabul();"><span>Yatir</span></a></td></tr>
						   </table>			
			</td>					
		</tr>
	</table> 
  <% 
   }
      rsetsql.close();
      rsetsql.close();						
		
    } catch (SQLException edd) {
    }	
}
if (xError.length() < 2) {	  
%>	
<DIV id="div_gameselect" style="padding-left:0;padding-top:0px;width:351px;overflow:auto; float:left;background-color:#000000;"> </DIV>
<%
 String xscriptex = "";
 if (!(checknullzero((String)session.getAttribute("beca_id")).equals("0"))) {
  try {
   stmt = conn.createStatement ();
   rset = stmt.executeQuery ("SELECT /*+  index(HLBS_betcardgamest   ind_hlbs_betcardgamest_beca_id)*/ bcga_id, beca_id, teg_id, tgr_id, bcde_rateno, teg_code, tgr_rateno, trim(to_char(tgr_rate,'990.00')) rate, cgtg_idname , teg_idname, tgr_charex, cgtg_id, to_char(teg_gamedate,'dd.mm hh24:mi') game_date , replace(tgr_charex,'''','`') tgr_charex FROM hlbs_betcardgamest WHERE beca_id = "+checknullzero((String)session.getAttribute("beca_id"))+"   AND bcga_active = 1   AND NVL (bcga_delete, 0) = 0   AND sub_id = "+checknullzero((String)session.getAttribute("sub_id"))+" order by bcga_id");   
    while (rset.next()) { %>
 <div style="display:block;">
 <table  width="100%" border="0" cellspacing="0" cellpadding="0"> <tr width="333px"><td class="coupon_unselected" width="100%">
 <table width="100%" border="0" cellspacing="0" cellpadding="0"><tr><td  style="width:75%"><%=checknull(rset.getString("teg_idname"))%></td> <td style="width:25%;" align="right"><%=checknull(rset.getString("game_date"))%></td></tr> </table>
 </td></tr>
 <tr width="100%"><td class="coupon_selected" width="100%">
 <table width="100%" border="0" cellspacing="0" cellpadding="0">
 <tr><td class="label"  width="80%"><%=checknull(rset.getString("tgr_charex"))%></td>
 <td class="odd" width="20%" align="right"  ><%=checknull(rset.getString("rate"))%></td></tr>
 </table></td> </tr></table></div>	
<%	
     }
	  rset.close();
      stmt.close();
    } catch (SQLException e) {}
  }
%> 
</div>	
<%} else {%><script>top.window.show_dialog('link:hlbs_hatahtml.jsp?wem_code=<%=xError%>', 'Kupon Kabul Edilmedi', '', '');get_iptal();</script><%}%>
<%@ include file="include_dosya/Connection_End.jsp" %>
<%@ include file="include_dosya/Top_End.jsp" %>