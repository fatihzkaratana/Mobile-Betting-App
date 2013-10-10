<%@ page language="java" contentType="text/html;charset=UTF-8"%>
<%@ include file="include_dosya/Top.jsp"%>
<% xwep_name = "hlbs_fiyat_kuponu.jsp"; %>
<%@ include file="include_dosya/Connection.jsp"%>
<%@ include file="include_dosya/JspDefault.jsp"%>
<%@ include file="include_dosya/Sayfa_UstUstHtml.jsp" %>
<%@ include file="include_dosya/Center_AllPageTop.jsp" %>
<script type="text/javascript" src="Scripts/hlbs_coupons13.js"></script>
<link rel="stylesheet" type="text/css" href="css/bahiskuponu.css" />
<%@ include file="include_dosya/Statistic_Pages.jsp"%>
<script>
$(document).ready(function() {

   $('input[safari]:checkbox').checkbox({cls:'jquery-safari-checkbox'});	   
   $('input[safari]:checkbox').click(function(){ var xitem = "div[ccode='"+$(this).attr("ulke")+"']";if ($(this).attr('checked')) $(xitem).hide('slow'); else $(xitem).show('slow');});
   $('input[kafari]:checkbox').checkbox({cls:'jquery-safari-checkbox'});	   
   $('input[kafari]:checkbox').click(function(){
      var xcgtg_id = $(this).attr("cgtg_id");
	  if ($(this).attr('checked')) $("div[id^='cgt_"+xcgtg_id+"_"+"']").hide(); else get_bettype(xcgtg_id);
	});      
	
if($.browser.msie    && parseInt($.browser.version) == 6) {
	setTimeout("top.window.change_betcoupon('B');",2000);
	setTimeout("top.window.reload_betclass();",3000);
} else {
	setTimeout("top.window.change_betcoupon('B');",200);
	setTimeout("top.window.reload_betclass();",500);
}

}) 
</script>

<body id="bodybody">
  <table class="pagetitle" align="center" border="0" cellpadding="1" cellspacing="0" width="100%">
    <tr>
        <td width="1%" align="left"> <img  onclick="top.window.SH_frmTopMenu('O');" src="images/nicoball_title.png" style="cursor:pointer" title="Full Ekran Aç/Kapat" alt="" border="0" ></td>
        <td width="100%" align="left">&nbsp;<%=checknull(request.getParameter("pagetitle"))%></td>
      <td width="70px" align="right">
        <a class="button" onclick="$('#div_ulkeler').slideToggle('slow');">
          <span>Ulke</span></a>
      </td>
      <td width="70px" align="right">
        <a class="button" onclick="$('#div_tarihler').slideToggle('slow');">
          <span>Tarih</span></a>
      </td>
      <td width="70px" align="right">
        <a class="button" onclick="$('#div_fiyatlar').slideToggle('slow');">
          <span>Fiyat</span></a>
      </td>	  
      <td width="70px" align="right">
        <a class="button" onclick="$('#div_bahistip').slideToggle('slow');">
          <span>B.Tip</span></a>
      </td>
      <td width="90px" align="right">
        <a class="button" onclick="hide_all();">
          <span>Temizle</span></a>   
      </td>
      <td width="100px" align="right">
        <a class="button" onclick="show_all();">
          <span>Hepsi</span></a>
      </td>	  
    </tr>
  </table>

  <div id="div_fiyatlar" class="divkriter">
    <table border="0" cellpadding="2" cellspacing="2" width="100%">
      <tr>
        <td width="90%">  
    <table border="0" cellpadding="2" cellspacing="2" width="100%">
      <tr align="center" class="combotitle">
        <td width="100%"></td>	  
		<td width="100px" align="center">
		<a class="button" onclick="show_price(1.00,1.20);">
                  <span>1.00&nbsp;/&nbsp;1.20</span></a>
		</td>
		<td width="100px" align="center">
		<a class="button"  onclick="show_price(1.20,1.40);">
                  <span>1.20&nbsp;/&nbsp;1.40</span></a>
		</td>
		<td width="100px" align="center">
		<a class="button"  onclick="show_price(1.40,1.60);">
                  <span>1.40&nbsp;/&nbsp;1.60</span></a>
		</td>
		<td width="100px" align="center">
		<a class="button"  onclick="show_price(1.60,1.80);">
                  <span>1.60&nbsp;/&nbsp;1.80</span></a>
		</td>		
		 </tr>
        </table>
        </td>
      </tr>
    </table>	  

  </div>
  <div id="div_tarihler" class="divkriter">
    <table border="0" cellpadding="2" cellspacing="2" width="100%">
      <tr>
        <td width="90%">  
    <table border="0" cellpadding="2" cellspacing="2" width="100%">
      <tr align="center" class="combotitle">
        <td width="100%"></td>	  
		<td width="80px" align="center">
		<a class="button" onclick="show_time(60);">
                  <span>1&nbsp;Saat</span></a>
		</td>
		<td width="80px" align="center">
		<a class="button"  onclick="show_time(120);">
                  <span>2&nbsp;Saat</span></a>
		</td>
		<td width="80px" align="center">
		<a class="button"  onclick="show_time(180);">
                  <span>3&nbsp;Saat</span></a>
		</td>
		<td width="80px" align="center">
		<a class="button"  onclick="show_time(360);">
                  <span>6&nbsp;Saat</span></a>
		</td>		
		<td width="80px" align="center">
		<a class="button"  onclick="show_day(0);">
                  <span>Bugun</span></a>
		</td>
		<td width="80px" align="center">
		<a class="button" onclick="show_day(1);">
                  <span>Yarin</span></a>
		</td>
		 </tr>
        </table>
        </td>
      </tr>
    </table>	
  </div>

  <div id="div_ulkeler" class="divkriter">
    <table border="0" cellpadding="2" cellspacing="2" width="100%">
      <tr>
        <td width="90%">
          <table border="0" cellpadding="2" cellspacing="2" width="100%">
            <tr class="combotitle">
              <td width="3%">&nbsp;</td>
              <%
  String SelectSQL;  
  try {
  int xadet = 0;
  int xulke_adet = 0;
  int xulke_satir = 0;
  int wwidth = Integer.parseInt(checknullzero(request.getParameter("wwidth")));
  String xTable = "";
  String xCol_Degis = "";
   
   if (xtemp_letter.equals("a") || xtemp_letter.equals("A")) {
     SelectSQL = "SELECT count(1) ulke_adet, trunc(count(1)/4) + decode (mod(count(1) , 4 ),0,0,1) ulke_satir  FROM (SELECT cou_code, NVL(cou_name,cou_code ) cou_name, count(1) adet FROM v_temp_coupon_www_a  WHERE dil_code = 'TR'  AND teg_gamedatew BETWEEN SYSDATE AND SYSDATE+7 AND teg_gamedate  BETWEEN SYSDATE AND SYSDATE+30 AND cat_id = "+checknullzero((String)request.getParameter("cat_id"))+" AND cgt_formtype = 'DEFAULT'  AND cgt_webtype = 'DEFAULT'  and substr(nvl(tgr_teg_code,'1'),1,1) != '0' and lea_id != 4721 group by cou_code, cou_name)";
	 } else {
     SelectSQL = "SELECT count(1) ulke_adet, trunc(count(1)/4) + decode (mod(count(1) , 4 ),0,0,1) ulke_satir  FROM (SELECT cou_code, NVL(cou_name,cou_code ) cou_name, count(1) adet FROM v_temp_coupon_www_b  WHERE dil_code = 'TR'  AND teg_gamedatew BETWEEN SYSDATE AND SYSDATE+7 AND teg_gamedate  BETWEEN SYSDATE AND SYSDATE+30 AND cat_id = "+checknullzero((String)request.getParameter("cat_id"))+" AND cgt_formtype = 'DEFAULT'  AND cgt_webtype = 'DEFAULT'  and substr(nvl(tgr_teg_code,'1'),1,1) != '0' and lea_id != 4721 group by cou_code, cou_name)";
	 }   

  stmt = conn.createStatement ();
  ResultSet rsetx = stmt.executeQuery (SelectSQL);
        while (rsetx.next()) { xulke_adet = rsetx.getInt("ulke_adet");  xulke_satir = rsetx.getInt("ulke_satir"); }  rsetx.close();

for (int i=1;i<=xulke_satir;i++) { 

   xTable = xTable + "<tr class=\"combotitle\"><td width=\"3%\"></td>";
   xTable = xTable + "<td align=\"left\" width=\"16%\" height=\"20px\" valign=\"top\">xxulke"+i+"x</td>";

   if ((i+1*(xulke_satir)) > xulke_adet  ) xCol_Degis = ""; else  xCol_Degis = "xxulke"+(i+1*(xulke_satir))+"x";
   xTable = xTable + "<td align=\"left\" width=\"16%\" height=\"20px\" valign=\"top\">"+xCol_Degis+"</td>";

   if ((i+2*(xulke_satir)) > xulke_adet  ) xCol_Degis = ""; else  xCol_Degis = "xxulke"+(i+2*(xulke_satir))+"x";
   xTable = xTable + "<td align=\"left\" width=\"16%\" height=\"20px\" valign=\"top\">"+xCol_Degis+"</td>";  
   
   if ((i+3*(xulke_satir)) > xulke_adet  ) xCol_Degis = ""; else  xCol_Degis = "xxulke"+(i+3*(xulke_satir))+"x";
   xTable = xTable + "<td align=\"left\" width=\"16%\" height=\"20px\" valign=\"top\">"+xCol_Degis+"</td>";      

   xTable = xTable + "</tr>";
}		
		
  String xReplace;
  String xReplaceWith;		
  
   if (xtemp_letter.equals("a") || xtemp_letter.equals("A")) {
     SelectSQL = "SELECT   cou_code, cou_name, COUNT (teg_id) adet FROM (SELECT cou_code, get_hlbs_country_name (cou_code, 'TR') cou_name,  teg_id, team_homename, team_awayname  FROM viewdil_hlbs_fiyat_kupona  WHERE dil_code = 'TR'  AND cat_id = "+checknullzero((String)request.getParameter("cat_id"))+"  AND teg_gamedate  BETWEEN SYSDATE AND SYSDATE+30  AND SUBSTR (NVL (tgr_teg_code, '1'), 1, 1) != '0') GROUP BY cou_code, cou_name ORDER BY cou_name";
	 } else {
     SelectSQL = "SELECT   cou_code, cou_name, COUNT (teg_id) adet FROM (SELECT cou_code, get_hlbs_country_name (cou_code, 'TR') cou_name,  teg_id, team_homename, team_awayname  FROM viewdil_hlbs_fiyat_kuponb  WHERE dil_code = 'TR'  AND cat_id = "+checknullzero((String)request.getParameter("cat_id"))+"  AND teg_gamedate  BETWEEN SYSDATE AND SYSDATE+30  AND SUBSTR (NVL (tgr_teg_code, '1'), 1, 1) != '0') GROUP BY cou_code, cou_name ORDER BY cou_name";
	 }     
  
  rset = stmt.executeQuery (SelectSQL);
      while (rset.next()) {
      xadet = xadet + 1;
	  xReplace = "xxulke"+xadet+"x";
	  xReplaceWith = "<input name=\"cb_ulke\" ulke=\""+rset.getString("cou_code")+"\" type=\"checkbox\" safari=1 id=\"cb_"+rset.getString("cou_code")+"\" checked>&nbsp;"+ checknull(rset.getString("cou_name"))+"<span class=\"titleyellow\">("+rset.getString("adet")+")</span>";
	  
 	  xTable = replaceSTR(xTable, xReplace, xReplaceWith);
      }
    rset.close();
    stmt.close();
    out.println(xTable);

   } catch (SQLException e) { }
%>
            </tr>
          </table>
        </td>
      </tr>
    </table>
</div>

  <div id="div_bahistip" class="divkriter">
    <table border="0" cellpadding="2" cellspacing="2" width="100%">
      <tr>
        <td width="90%">
<%
  try {
  int xadet = 0;
  String xTable = "";
  String xCol_Degis = "";
  String xReplace;
  String xReplaceWith;	
			  
xTable = "<table border=\"0\" cellpadding=\"2\" cellspacing=\"2\" width=\"100%\">";
xTable = xTable + "<tr class=\"combotitle\"><td width=\"3%\"></td>";
xTable = xTable + "<td align=\"left\" width=\"25%\" height=\"20px\" valign=\"top\">xxbahis1</td>";
xTable = xTable + "<td align=\"left\" width=\"25%\" height=\"20px\" valign=\"top\">xxbahis2</td>";
xTable = xTable + "<td align=\"left\" width=\"25%\" height=\"20px\" valign=\"top\">xxbahis3</td></tr>";
xTable = xTable + "<tr class=\"combotitle\"><td width=\"3%\"></td>";
xTable = xTable + "<td align=\"left\" width=\"25%\" height=\"20px\" valign=\"top\">xxbahis4</td>";
xTable = xTable + "<td align=\"left\" width=\"25%\" height=\"20px\" valign=\"top\">xxbahis5</td>";
xTable = xTable + "<td align=\"left\" width=\"25%\" height=\"20px\" valign=\"top\">xxbahis6</td></tr>";
xTable = xTable + "<tr class=\"combotitle\"><td width=\"3%\"></td>";
xTable = xTable + "<td align=\"left\" width=\"25%\" height=\"20px\" valign=\"top\">xxbahis7</td>";
xTable = xTable + "<td align=\"left\" width=\"25%\" height=\"20px\" valign=\"top\">xxbahis8</td>";
xTable = xTable + "<td align=\"left\" width=\"25%\" height=\"20px\" valign=\"top\">xxbahis9</td></tr></table>";			  
   
  stmt = conn.createStatement ();
  rset = stmt.executeQuery ("SELECT cgtg_id, cgtg_name  FROM viewdil_hlbs_catgamegrpweb  WHERE dil_code = 'TR'  AND cat_id = "+checknullzero((String)request.getParameter("cat_id"))+"");  //+checknullzero((String)request.getParameter("cat_id"))+"");
      while (rset.next()) {
      xadet = xadet + 1;
	  xReplace = "xxbahis"+xadet;
	  xReplaceWith = "<input name=\"cgtg_cgtg\" cgtg_id=\""+rset.getString("cgtg_id")+"\" type=\"checkbox\" kafari=1 id=\"cgtg_"+rset.getString("cgtg_id")+"\" unchecked>&nbsp;"+ checknull(rset.getString("cgtg_name"));
	  
 	  xTable = replaceSTR(xTable, xReplace, xReplaceWith);
      }
    rset.close();
    stmt.close();
    for (int i=1;i<=9;i++) { 	
	xTable = replaceSTR(xTable, "xxbahis"+i, "");
    }
    out.println(xTable);

   } catch (SQLException e) {
       //    out.println("<P>" +       e.getErrorCode() + " \n <P>");
       //    out.println("<P>" +       e.getMessage() + " \n <P>");	   
   }
%>
        </td>
      </tr>
    </table>
</div>


<%@ include file="hlbs_acilnot.jsp"%>


<div id="puantablosu"  align="center"  style="position: absolute; z-index:1000; width:100%;display: none;">	</div>   
 
  
  
<script>
function show_bets(){  
<%   
xgecici = "0";
String xxWhere = "";
String xxLeague = "00";
String xxcou_code = checknull(request.getParameter("cou_code"));
String xxlea_id = checknull(request.getParameter("lea_id"));
String xxcat_id = checknull(request.getParameter("cat_id"));
String xtime = checknull(request.getParameter("xtime"));
String leaque_id = "";
int xxLeagueCount = 0;

 try {
   Statement stmtsql = conn.createStatement ();
   if (xtemp_letter.equals("a") || xtemp_letter.equals("A")) {
     SelectSQL = "select * FROM viewdil_hlbs_fiyat_kupona WHERE dil_code = 'TR' and cat_id = "+checknullzero((String)request.getParameter("cat_id"))+" AND teg_gamedate   BETWEEN SYSDATE AND SYSDATE+30 and substr(nvl(tgr_teg_code,'1'),1,1) != '0' ";
	 } else {
     SelectSQL = "select * FROM viewdil_hlbs_fiyat_kuponb WHERE dil_code = 'TR' and cat_id = "+checknullzero((String)request.getParameter("cat_id"))+" AND teg_gamedate   BETWEEN SYSDATE AND SYSDATE+30 and substr(nvl(tgr_teg_code,'1'),1,1) != '0' ";
	 }
     ResultSet rsetsql = stmtsql.executeQuery (SelectSQL) ;
   while (rsetsql.next()) {     
    xgecici = checknullzero(rsetsql.getString("lea_id"))+checknullzero(rsetsql.getString("leay_id"))+checknullzero(rsetsql.getString("leag_id"));

   if (!(xgecici.equals(xxLeague))) {
    if (!(xxLeague.equals("00"))) {
	out.println("l_s('"+leaque_id+"');t_w('"+xxLeagueCount+"','"+leaque_id+"');"); 
	
	}
	xxLeagueCount = xxLeagueCount + 1;
    out.println("league_title('"+checknullzero(rsetsql.getString("cat_id"))+"','"+checknullzero(rsetsql.getString("cou_code"))+"','"+checknullzero(rsetsql.getString("lea_id"))+"','"+checknullzero(rsetsql.getString("leay_id"))+"','"+checknullzero(rsetsql.getString("leag_id"))+"','"+checknull(rsetsql.getString("leaque_id"))+"','"+checknull(rsetsql.getString("leagueyear_name"))+"','"+xxLeagueCount+"','"+checknull(rsetsql.getString("lll_sta_01"))+"','"+checknull(rsetsql.getString("lll_sta_02"))+"','"+checknull(rsetsql.getString("lll_sta_03"))+"','"+checknull(rsetsql.getString("lll_sta_04"))+"','"+checknull(rsetsql.getString("lll_sta_05"))+"','"+checknull(rsetsql.getString("lll_sta_06"))+"','"+checknull(rsetsql.getString("lll_sta_07"))+"','"+checknull(rsetsql.getString("lll_sta_08"))+"','"+checknull(rsetsql.getString("lll_sta_09"))+"','"+checknull(rsetsql.getString("lll_sta_10"))+"','"+checknull(rsetsql.getString("lll_sta_11"))+"','"+checknull(rsetsql.getString("lll_sta_12"))+"','"+checknull(rsetsql.getString("lll_sta_13"))+"','"+checknull(rsetsql.getString("lll_sta_14"))+"','"+checknull(rsetsql.getString("lll_sta_15"))+"');l_u('0');");
   }  
   out.println("l_o('"+checknull(rsetsql.getString("leaque_id"))+"','"  
                    +nullspace(rsetsql.getString("tgr_teg_code"))+"','"   
                    +checknull(rsetsql.getString("teg_minplay"))+"','"
                    +checknull(rsetsql.getString("team_idhome"))+"','"
                    +checknull(rsetsql.getString("team_idaway"))+"','"					  					  
                    +checknull(rsetsql.getString("teg_gamedates"))+"','"
                    +checknull(rsetsql.getString("teg_gametime"))+"','"					  
					+checknull(rsetsql.getString("team_homename"))+"','"
					+checknull(rsetsql.getString("team_awayname"))+"','"
					+checknullzero(rsetsql.getString("tgr_raten1"))+"','"
					+checknullzero(rsetsql.getString("tgr_raten2"))+"','"
					+checknullzero(rsetsql.getString("tgr_raten3"))+"','" 
					+checknullzero(rsetsql.getString("teg_betcount"))+"','" 
					+checknullzero(rsetsql.getString("minmin_rate"))+"','"
					+checknullzero(rsetsql.getString("lastmin"))+"','" 
					+checknullzero(rsetsql.getString("lastday"))+"','" 					
					+checknull(rsetsql.getString("teg_id"))+"','"
					+checknull(rsetsql.getString("tgr_id"))+"','"
					+checknull(rsetsql.getString("cgt_id"))+"');");
              
   xxLeague = checknullzero(rsetsql.getString("lea_id"))+checknullzero(rsetsql.getString("leay_id"))+checknullzero(rsetsql.getString("leag_id"));
   leaque_id = checknull(rsetsql.getString("leaque_id"));
   } 
	
    if (!(xxLeague.equals("00"))) {
	   out.println("l_s('"+leaque_id+"');t_w('"+xxLeagueCount+"','"+leaque_id+"');");
	   xgecici = "1";
	}
		
      rsetsql.close();
      rsetsql.close();						

    } catch (SQLException edd) {   }	   
%>
  }
show_bets();
</script>
  <%@ include file="include_dosya/Center_AllPage.jsp"%>
</body>
</html>
<%@ include file="include_dosya/Connection_End.jsp"%>
<%@ include file="include_dosya/Top_End.jsp" %>
