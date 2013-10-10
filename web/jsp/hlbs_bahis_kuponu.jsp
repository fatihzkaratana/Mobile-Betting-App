<%@page language="java" contentType="text/html;charset=UTF-8" %>
<%@include file="include_dosya/Top.jsp" %>
<% xwep_name  = "hlbs_bahis_kuponu.jsp";%>
<%@include file="include_dosya/Connection.jsp" %>
<%@include file="include_dosya/JspDefault.jsp" %>
<%

String	xxtvinfo = null;
String	xxtvsetting1 = null;
String	xxtvsetting2 = null;
String	xxtvsetting3 =  null;
String	xxtvsetting4 = null;
String	xxtvlink = null;

    /*
    FUNCTION GET_SUB_BALANCE_INFO (
    XCOMPUTER_NAME      IN       VARCHAR2,
    XTCP_IP             IN       VARCHAR2,
    XSUB_ID             IN       VARCHAR2,
    XDOT_CODE           IN       VARCHAR2,
    XSUB_BALANCE       OUT      NUMBER,
    XSUB_BETBALANCE    OUT      NUMBER,
    XSUB_MINSTAKE      OUT      NUMBER,
    XSUB_MAXSTAKE      OUT      NUMBER,
    XERROR             OUT      VARCHAR2
    )
    RETURN NUMBER
     */
    String xsub_balance = "0";
    String xsub_betbalance = "0";
    String xsub_minstake = "1";
    String xsub_maxstake = "0";
    if (checknullzero((String)session.getAttribute("sub_id")).length() == 8) {
   try {	
         CallableStatement cs = conn.prepareCall("{?=call get_sub_balance_info(?,?,?,?,?,?,?,?,?)}");

            cs.registerOutParameter(1, java.sql.Types.VARCHAR);
            cs.registerOutParameter(6, java.sql.Types.VARCHAR);
            cs.registerOutParameter(7, java.sql.Types.VARCHAR);
            cs.registerOutParameter(8, java.sql.Types.VARCHAR);
            cs.registerOutParameter(9, java.sql.Types.VARCHAR);
            cs.registerOutParameter(10, java.sql.Types.VARCHAR);

            cs.setString(2, xHOST);
            cs.setString(3, xTCP_IP);
            cs.setString(4, checknullzero((String) session.getAttribute("sub_id")));
            cs.setString(5, checknull((String) session.getAttribute("dot_code")));
            cs.execute();

            xsub_balance = checknullzero(cs.getString(6));
            xsub_betbalance = checknullzero(cs.getString(7));
            xsub_minstake = checknullzero(cs.getString(8));
            xsub_maxstake = checknullzero(cs.getString(9));
            cs.close();

        } catch (Exception e) {  //out.println("<P>" +       e.getMessage() + " \n <P>");
        }
    }
    else

    {
        xsub_balance = "0";
        xsub_betbalance = "0";
        xsub_minstake = "1";
        xsub_maxstake = "0";
    }
%>

<%@include file="include_dosya/Sayfa_UstUstHtml.jsp" %>
<script type="text/javascript" src="FlashPlayer/umsplayer.js" charset="utf-8"></script> 
<link rel="stylesheet" type="text/css" href="css/bahiskuponu.css">
<script type="text/javascript" src="Scripts/hlbs_betcoupons02.js"></script>
<script type="text/javascript">

    var xsub_minstake =  parseFloat(<%=checknullzero(xsub_minstake)%>);
    var xsub_maxstake =  parseFloat(<%=checknullzero(xsub_maxstake)%>);
    function reload_betclass(){
        var total_rate = 1;
        var total_mac  = 0;
        $("tr[id^='rate']").each(function(index) {
            var xid = $(this).attr('id');
            var xrate = $(this).attr('rate');
            top.window.obj_addclass(xid,'selected');
            total_mac = total_mac + 1;
            total_rate = parseFloat(total_rate) * parseFloat(xrate);
        });
        try {
            setvalues(total_mac,parseFloat(total_rate).toFixed(2),1)
            recal_return();
        } catch(err) { }
    }

    var img1 = "images/NicoTV_header_green.gif";
    var img2 = "images/NicoTV_header_red.gif";
    var TVcno = "";
    var betcoupon = "B";

    $(document).ready(function() {
     
	$("#beca_combination").msDropDown();
        $('#beca_stake').blur(function() {
            $(this).attr("value", parseFloat($(this).attr("value")).toFixed(2));
            recal_return();
        });

	$(window).bind('resize', function() { setTimeout("resize_scroll();", 200); });

        document.getElementById('imgname2').src = img1;
        setTimeout("coupon_reload();",300);
	setTimeout("top.window.remove_select();",700);
        setTimeout("reload_betclass();",1000);
        chngflash('imgname2');

    });

    function change_betcoupon(xbc)  {
	if ( xbc != betcoupon) {
            if (xbc == 'H') {
                $('#div_betcoupon').slideUp();
                $('#div_betcouponak').slideDown();
                close_betcoupons();
                hd_newcoupon();
            } else {
                $('#div_betcouponak').slideUp();
                $('#div_betcoupon').slideDown();
            }
            betcoupon = xbc;
	}
    }

    function resize_scroll()  {
      try {
         if ($('#div_gameselect')) {
            var p = $("#div_gameselect");
            var position = p.position();
            if (position.top) $('#div_gameselect').css({ "height": $(window).height()-position.top});
        }
      } catch(err) { }
    }

    function resize_scrollhd()  {
      try {
         if ($('#hdlastbets')) {
            var p = $("#hdlastbets");
            var position = p.position();
            if (position.top) $('#hdlastbets').css({ "height": $(window).height()-position.top});
        }
      } catch(err) { }
    }

    function opentv(tvno)  {
	channel_clickflash(tvno);
    }

    function chng(c_img)  {
	if (document[c_img].src.indexOf(img1) != -1) document[c_img].src = img2; else document[c_img].src = img1;
        $('#ifrtvtd').html('<img src="images/NicoTV.gif"  alt="" border="0">');
        $('#nicotv').toggle();
        resize_scroll();
        resize_scrollhd();
    }

    function channel_click(cno)  {
        runtv(cno);
        TVcno = cno;
    }
    function channel_clickflash(cno)  {
        runtv(cno);
        TVcno = cno;
    }

    function runtv(cno)  {
        try{
       $.ajaxSetup({async: true});
       $.getScript('hlbs_tvgoster.jsp?tvno='+cno+'&rnd='+Random_Number());
       //get_test('hlbs_tvgoster.jsp?tvno='+cno+'&rnd='+Random_Number());
       $.ajaxSetup({async: false});
    } catch(err) { }
    }


    function chngflash(c_img)  {
	if (document[c_img].src.indexOf(img1) != -1) {
            document[c_img].src = img2;
            $('#nicotv').show();
            $('#nicoTVekran').show();
            $('#nicoTVTV').show()
        } else {
            document[c_img].src = img1;
            $('#nicotv').hide();
            $('#nicoTVekran').hide();
            $('#nicoTVTV').hide()
        }

        resize_scroll();
        resize_scrollhd();
    }



    var hdlastrow = 0;
    var hdseq = 0;
    function  setratesel(xhorsedog,hdracetitle,hdraceid,hdracetype,hdraceno, horsedogno,hdracenoname,hdracenorate) {

        var oldhra_id =  parseInt($('#hdraceid').val());
        if (oldhra_id != parseInt(hdraceid)) {close_betcoupons(); hd_newcoupon();$('#hdraceid').val(hdraceid);}

        var obj = input_varyoket('name','hdrun_',horsedogno,1);
        if (obj)  { hd_delsel(obj,horsedogno);return(0);}
        if (hdlastrow > 3 && xhorsedog == 'D') { alert('Bir kuponda en fazla 4 adet TAZI secebilirsiniz.'); return(0);}
        if (hdlastrow > 3 && xhorsedog == 'H') { alert('Bir kuponda en fazla 4 adet AT secebilirsiniz.'); return(0);}

        $('#hdracetitle').html(hdracetitle);
        $('#hdraceid').val(hdraceid);
        $('#hdracetype').val(hdracetype);
        
        hdlastrow = hdlastrow + 1;
        hdseq =  hdseq + 1;
        if (hdlastrow == 1) {
            $('#hdcoupon').show();
            $('#hdracetitle').show();
            $('#betinfohd').hide();
        }

      $('#hdraceselect tr:last').after('<TR valign="middle" class="hdcoupon_selected"><TD width="10%" align="center"><INPUT  name="hdrun_'+hdseq+'" id="hdrun_'+hdseq+'"  value="'+horsedogno+'"  type="hidden" ><INPUT  name="hdraceno_'+hdseq+'" id="hdraceno_'+hdseq+'"  value="'+hdraceno+'"  type="hidden" ><INPUT  name="hdrate_'+hdseq+'" id="hdrate_'+hdseq+'"  value="'+hdracenorate+'"  type="hidden" ><IMG src="imagesjokey/'+xhorsedog+horsedogno+'.png" alt="" border="0"></TD><TD width="55%" align="left">'+hdracenoname+'</TD><TD class="odd" width="20%" align="right">'+hdracenorate+'</TD><TD class="odd" width="5%" onClick="hd_delsel(this,'+horsedogno+');" width="22px" align="right"><IMG src="images/kupon_close1.png" height="14" width="14" onMouseMove="this.src=\'images/kupon_close2.png\';" onMouseOut="this.src=\'images/kupon_close1.png\';" alt=""></TD></TR>');
       create_combobox();
       resize_scrollhd();
       return(1);
    }

    function betinfohd_show(){
      try{
          $('#betinfohd').show();
       } catch(err) { }
    }
    function close_betcoupons(){
      try{
         $('#hdlastbets').html('');
         betinfohd_show();
       } catch(err) { }
    }
    
    function  hd_newcoupon() {
        $('#hdcoupon').hide();
        betinfohd_show();

        hdlastrow = 0;
        hdseq = 0;

        $('#hdracetitle').html('');
        $('#hdraceid').val('0');
        $("#hdraceselect tr:gt(0)").remove();
        for (i=1;i<21;i++) top.window.ratecss(i,0);
        resize_scrollhd();
    }

    function  hd_delsel(obj,horsedogno) {
        $(obj).parent().remove();
        top.window.ratecss(horsedogno,0);
        hdlastrow =   hdlastrow  - 1;
        if (hdlastrow == 0) {
             hd_newcoupon();
        } else {create_combobox();}
      resize_scrollhd();
    }



    function create_combobox(){
        var ycombo_opt = "";
        var xbettype = $('#hdracetype').val();

        if  (xbettype.indexOf('T.C') > 0 || xbettype.indexOf('(1.2.3.)') > 0 ) xbettype = '3';
        if  (xbettype.indexOf('F.C') > 0 || xbettype.indexOf('(1.2.)') > 0 ) xbettype = '2';
        if  (xbettype.indexOf('SNG') > 0 || xbettype.indexOf('(1.)') > 0 ) xbettype = '1';

        if (hdlastrow > 2  && xbettype > "2") ycombo_opt = ycombo_opt+'<option value="TC"  info="'+coupon_count("TC",hdlastrow)+'">(1.2.3.)</option>';
        if (hdlastrow > 2  && xbettype > "2") ycombo_opt = ycombo_opt+'<option value="TCAO"  info="'+coupon_count("TCAO",hdlastrow)+'">(1.2.3.) - Karisik</option>';
        if (hdlastrow > 1  && xbettype > "1") ycombo_opt = ycombo_opt+'<option value="FC"    info="'+coupon_count("FC",hdlastrow)+'">(1.2.)</option>';
        if (hdlastrow > 1  && xbettype > "1") ycombo_opt = ycombo_opt+'<option value="FCAO"  info="'+coupon_count("FCAO",hdlastrow)+'">(1.2.) - Karisik</option>';
        if (hdlastrow > 2  && xbettype > "2") ycombo_opt = ycombo_opt+'<option value="FCTC"  info="'+coupon_count("FCTC",hdlastrow)+'">(1.2.) - (1.2.3)</option>';

        ycombo_opt = ycombo_opt+'<option value="SNG"   info="'+coupon_count("SNG",hdlastrow)+'" >(1.)</option>';
        ycombo_opt = ycombo_opt+'<option value="SNGEW" info="'+coupon_count("SNGEW",hdlastrow)+'">(1.) ve Plase</option>';
        if (hdlastrow == 2 && xbettype > "1") ycombo_opt = ycombo_opt+'<option value="SNGFC"  info="'+coupon_count("SNGFC",hdlastrow)+'">(1.) ve (1.2.)</option>';

        $('#hd_bettype').html(ycombo_opt);
        $('#hd_bettype').msDropDown();
        $('#hd_beca_stake').val($("#hd_bettype option:selected").attr("info").replace('[','').replace(']','')+'.00');
    }

    function coupon_count(xbtype,xcount) {
        var xinfo = "";
        if (xbtype == 'SNG' || xbtype == 'SNGFP' || xbtype == 'SNGGP') xinfo = (xcount ) ;
        if (xbtype == 'SNGEW') xinfo = (xcount * 2);
        if (xbtype == 'SNGFC' && xcount == 2)  xinfo = (4) ;
        if (xbtype == 'SNGFCTC' && xcount == 3) xinfo = (15) ;
        if (xbtype == 'FC' && xcount == 2)  xinfo = (1) ;
        if (xbtype == 'FCAO' && xcount == 2) xinfo = (2) ;
        if ((xbtype == 'FC' || xbtype == 'FCAO') && xcount == 3) xinfo = (6) ;
        if ((xbtype == 'FC' || xbtype == 'FCAO') && xcount == 4) xinfo = (12 );
        if ((xbtype == 'FC' || xbtype == 'FCAO') && xcount == 5) xinfo = (20) ;
        if (xbtype == 'FCTC' && xcount == 3)  xinfo = (7) ;
        if (xbtype == 'FCTC' && xcount == 4)  xinfo = (36) ;
        if (xbtype == 'FCTC' && xcount == 5)  xinfo = (80) ;
        if (xbtype == 'TC' && xcount == 3)  xinfo = (1) ;
        if (xbtype == 'TCAO' && xcount == 3)  xinfo = (6) ;
        if ((xbtype == 'TC' || xbtype == 'TCAO') && xcount == 4) xinfo = (24) ;
        if ((xbtype == 'TC' || xbtype == 'TCAO') && xcount == 5) xinfo = (60) ;
 
        return ('['+xinfo+']');
    }


function  get_hdonay(obj_gizle,obj_bekle,zaman) {
    var xhtml = ajax_getpost('GET','hlbs_bahis_kuponu_kabulak.jsp','#frm_couponak',false);
    $('#hdlastbets').html(xhtml);
}
function bet_click(xtime, xobjname, teg_id, tgr_id, rateno, rate) {
   setTimeout( function() {
                 top.window.frames["frmCenter"].bet_click(xobjname, teg_id, tgr_id, rateno, rate);
               } ,parseInt(xtime) );
}

function   replace_bonustext(yselcount,ybonusrate,ybonustotal) {
   $('#beca_bonusrate').val(ybonusrate);
   $('#beca_bonustotal').val(ybonustotal);
   if (parseFloat(ybonusrate) > 0.05 && parseInt(yselcount) > 2)  { $('#betbonus').slideDown('slow'); } else { $('#betbonus').slideUp('slow'); }

}

</script>

</HEAD>
<BODY style="background-color: #000000">



    <DIV id="CMenu" class="divcoupon">
        <DIV class="applemenu" style="width: 352px">
            <DIV class="silverheader" style="height: 32px; width: 352px;">
                <TABLE style="width: 326px;" cellpadding="0" cellspacing="0">
                    <TR>
                        <TD style="width:352px; "><IMG onClick="chngflash('imgname2')" id="imgname2" name="imgname2" alt="" width="51px" height="32px" src="images/NicoTV_header_red.gif" class="style2">
                        </TD>
                    </TR>
                </TABLE>
            </DIV>
            <DIV id="nicotv" style="display: none">
                <TABLE style="width: 352px" cellpadding="0" cellspacing="0">
                    <TR>
                        <TD id="ifrtvtd">
                            <div id="nicoTVekran" style="height: 290px;width: 352px;background-image: url('images/NicoTV.gif');"><div id="nicoTVTV"></div></div>
                        </TD>
                    </TR>
                </TABLE>
            </DIV>
        </DIV>
        <DIV id="div_betcoupon" class="silverheader" style="width: 352px; height:100%;background-color:#1B1B1B;">
            <TABLE cellpadding="0" cellspacing="0" width="100%">
                <TR>
                    <TD class="TVHeader_NORound" width="40%">	&nbsp;BAHİS KUPONU
                    </TD>
                    <TD class="TVHeader_NORound" align="right" width="60%">
                        <IMG style="cursor:pointer;" src="images/nico_ball_pink_20x20.png" width="20" height="20" title="Otomatik Kupon Yap (1 dakikada 1)" alt="Otomatik Kupon Yap (1 dakikada 1)" border="0" onclick="$.getScript('hlbs_create_autocoupon.jsp?rnd='+ Random_Number());">&nbsp;
                        <IMG style="cursor:pointer;" src="images/nico_ball_light_20x20.png" width="20" height="20" title="Son Oynadığım Kuponum" alt="Son Oynadığım Kuponum" border="0" onclick="top.window.show_dialog('link:hlbs_bahis_kupon_sonuncu.jsp','Son Oynadığım Kuponum','3000','3000');">&nbsp;
                        <IMG style="cursor:pointer;" src="images/nico_ball_cyan_20x20.png" width="20" height="20" title="Son Oynadığım Maçlar" alt="Son Oynadığım Maçlar" border="0" onclick="top.window.show_dialog('link:hlbs_bahis_kupon_maclar.jsp','Son Oynadığım Maçlar','3000','3000');">&nbsp;
                        <IMG style="cursor:pointer;" src="images/nico_ball_green_20x20.png" width="20" height="20" title="En Çok Oynanan Seçenekler" alt="En Çok Oynanan Seçenekler" border="0" onclick="top.window.show_dialog('link:hlbs_encok_oynanan_top25.jsp','En Çok Oynanan Seçenekler','5000','5000');">&nbsp;
                        <IMG style="cursor:pointer;" src="images/nico_ball_red_20x20.png" width="20" height="20" title="Yeni Kupon" alt="Yeni Kupon" onclick="del_values('','','',1);$('#betinfo').show();$('#betstake').hide();$('#betinfoex').show();$('#div_gameselect').html('');top.window.remove_select();" border="0">&nbsp;
                    </TD>
                </TR>
            </TABLE>
            <DIV id="betinfo" style="display:block">
                <TABLE cellpadding="2" cellspacing="2" width="100%">
                    <TR>
                        <TD align="center" class="coupon_selected" width="100%">&nbsp;<BR>Bahis Kuponunuz Boş<BR>&nbsp;
                        </TD>
                    </TR>
                            <%if (checknullzero((String)session.getAttribute("sub_id")).length() == 8 && checknullzero((String)session.getAttribute("sub_id")).startsWith("1")) { %>
                                <TR><TD align="center" class="coupon_selected" width="100%">
                                  <span style="font-size:9pt;color:red;">Müşterilerimizin Dikkatine</span><br>
                                 <span style="font-size:7pt;">1 Aralık 2010 tarihinden itibaren, Kuzey Kıbrıs Türk Cumhuriyeti Hükümeti, K.K.T.C. sınırları içerisinde bahis oynayan müşterilerin bahis ofislerinden veya internet sitelerinden yaptıkları kuponların kazanması durumunda vergiye tabi tutacaktır. <p>10 Aralık 2010 Cuma tarihinden itibaren, Bakanlar Kurulu kararı ile Şans Oyunları Hizmet Vergisi Yasasının ilgili maddesi gereğince kazanan bahislerde toplam ödeme tutarından %5 oranında gelir vergisi stopaj kesintisi yapılacaktır.  Hesabınıza giriş yaptıktan sonra hesap hareketlerinden kazandığınız her kupon tutarının altında kesilen vergi tutarını görebilirsiniz. <p>Bu yasaya bütün K.K.T.C. bahis firmaları uymakla yükümlüdür.</span>
                                </TD></TR>
                            <%}%>
                </TABLE>   
            </DIV>
            <DIV id="betstake" style="display:none;width: 352px;">
                <FORM id="frm_betcouton" name="frm_betcouton" method="post">
                    <INPUT type="hidden" value="1" id="kupon_win_open" name="kupon_win_open">
                    <INPUT type="hidden" value="0" id="beca_gameselect" name="beca_gameselect">
                    <INPUT type="hidden" value="1" id="teg_minplay" name="teg_minplay">
                    <INPUT type="hidden" value="1" id="beca_acceptbet" name="beca_acceptbet">
                    <DIV id="betsystem" style="display:block">
                        <TABLE align="center" cellpadding="0" cellspacing="0" width="352px" style="background-color:#333333;border-top: 6px solid #333333;">
                            <TR align="center">
                                <TD width="95px" class="texttitle">Sistemli Kupon
                                </TD>
                                <TD width="255px" align="center">
                                    <DIV id="bbbb_combination" align="center">
                                        <SELECT style="width:245px;" id="beca_combination" name="beca_combination">
                                            <option  value="" info=""></option>
                                        </SELECT>
                                    </DIV>
                                </TD>
                            </TR>
                        </TABLE>
                    </DIV>
                    <TABLE cellpadding="0" cellspacing="0" width="100%">
                        <TR>
                            <TD style="background-color:#333333;">
                                <TABLE border="0" width="100%">
                                    <TR>
                                        <TD width="25%" class="texttitle_input" style="text-align:center">Bahis Tutarı
                                        </TD>
                                        <TD width="25%" class="texttitle" style="text-align:center">Bahis Oranı
                                        </TD>
                                        <TD width="28%" class="texttitle" style="text-align:center">Kazanç
                                        </TD>
                                        <TD width="22%" class="texttitle">
                                        </TD>
                                    </TR>
                                    <TR>
                                        <TD>
                                            <INPUT name="beca_stake" id="beca_stake"  value="1.00"  type="text" style="width:75px;text-align:right;"/>
                                        </TD>
                                        <TD>
                                            <INPUT name="beca_rate"   id="beca_rate"   class="textdisplay" readonly  value="1.00" type="text" style="width:75px;"/>
                                        </TD>
                                        <TD>
                                            <INPUT name="beca_return" id="beca_return" class="textdisplay" readonly  value="1.00" type="text" style="width:75px;"/>
                                        </TD>
                                        <TD width="70px" align="center">
                                            <DIV id="btn_bekle">
                                            </DIV>
                                            <DIV id="btn_gizle"><A class="button" onClick="get_onay('btn_gizle','btn_bekle',5000);"><SPAN>Onayla</SPAN></A>
                                            </DIV>
                                        </TD>
                                    </TR>
                                </TABLE>
                                <DIV id="betbonus" style="display:none" style="background-color:#333333;">
                                    <TABLE border="0" width="100%">
                                        <TR>
                                            <TD width="25%" class="texttitle" style="text-align:center">	Bonus Oranı
                                            </TD>
                                            <TD width="25%" class="texttitle" style="text-align:center">	Toplam Oran
                                            </TD>
                                            <TD width="28%" class="texttitle" style="text-align:center">	Yeni Kazanç
                                            </TD>
                                            <TD width="22%" class="texttitle">
                                            </TD>
                                        </TR>
                                        <TR>
                                            <TD>
                                                <INPUT id="beca_bonusrate" name="beca_bonusrate" class="textdisplay" readonly  type="text" style="width:75px;"/>
                                            </TD>
                                            <TD>
                                                <INPUT id="beca_bonustotal" name="beca_bonustotal" class="textdisplay" readonly value="" type="text" style="width:75px;"/>
                                            </TD>
                                            <TD>
                                                <INPUT id="beca_bonusreturn" name="beca_bonusreturn" class="textdisplay" readonly value="" type="text" style="width:75px;"/>
                                            </TD>
                                            <TD width="70px" align="center"><A class="button" onClick="parent.window.show_dialog('link:help/info_rate_bonus.jsp', 'Bonus Fiyat Bilgisi', '', '');"><SPAN>Bilgi</SPAN></A>
                                            </TD>
                                        </TR>
                                    </TABLE>
                                </DIV>
                            </TD>
                            <TD style="background-color:#333333;" width="330px" height="8px">	&nbsp;
                            </TD>
                        </TR>
                    </TABLE>
                    <DIV id="div_gameselect" style="padding-left:0;padding-top:0px;width:351px;overflow:auto; float:left;background-color:#000000;">
                    </DIV>
                </FORM>
            </DIV>
            <DIV id="betinfoex" style="display:block">
                <CENTER>
                    <TABLE style="cursor:pointer;width:350px;height:205px" cellpadding="0" cellspacing="0">
                        <TR style="height:7px">
                            <TD colspan="2"><IMG src="images/spacer.gif" width="170" height="7" alt="" border="0"></TD>
                        </TR>
                        <TR style="height:68px">
                            <TD onclick="parent.window.hlbs_center('hlbs_index.jsp?index=10','A');"><IMG src="images/ads_futbol_small.jpg" alt="" border="0"></TD>
                            <TD onclick="parent.window.hlbs_center('hlbs_index.jsp?index=9','A');"><IMG src="images/ads_live_small.jpg"  alt="" border="0"></TD>
                        </TR>
                        <TR style="height:68px">
                            <TD onclick="parent.window.hlbs_center('hlbs_index.jsp?index=11','A');"><IMG src="images/ads_sanal_small.jpg"  alt="" border="0"></TD>
                            <TD onclick="parent.window.hlbs_center('hlbs_index.jsp?index=12','A');"><IMG src="images/ads_global_small.jpg" alt="" border="0"></TD>
                        </TR>
                        <TR style="height:68px">
                            <TD onclick="parent.window.hlbs_center('hlbs_kazi_kazan.jsp','K');"><IMG src="images/ads_kazikazan_small.jpg"  alt="" border="0"></TD>
                            <TD onclick="parent.window.hlbs_center('Slot/hlbs_slot777.jsp','K');"><IMG src="images/ads_slot_small.jpg"  alt="" border="0"></TD>
                        </TR>
                    </TABLE>
                </CENTER>
            </DIV>
        </DIV>
        <DIV id="div_betcouponak" class="silverheader" style="display:none;width: 352px; height:100%;background-color:#1B1B1B;">
            <TABLE cellpadding="0" cellspacing="0" width="100%">
                    <TR>
                        <TD class="TVHeader_NORound" width="60%">	&nbsp;AT/TAZI BAHİS KUPONU
                        </TD>
                        <TD class="TVHeader_NORound" align="right" width="40%"><IMG src="images/nico_ball_red_20x20.png" width="20" height="20" title="Yeni Kupon" alt="Yeni Kupon" onClick="hd_newcoupon();" border="0">&nbsp;
                        </TD>
                    </TR>
            </TABLE>
            <DIV id="betinfohd" style="display:block">
                <TABLE cellpadding="2" cellspacing="2" width="100%">
                    <TR>
                        <TD class="coupon_selected"  align="center" width="100%">&nbsp;<BR>At/Tazı Bahis Kuponunuz Boş<BR>&nbsp;
                        </TD>
                    </TR>
                            <%if (checknullzero((String)session.getAttribute("sub_id")).length() == 8 && checknullzero((String)session.getAttribute("sub_id")).startsWith("1")) { %>
                                <TR><TD align="center" class="coupon_selected" width="100%">
                                  <span style="font-size:9pt;color:red;">Müşterilerimizin Dikkatine</span><br>
                                 <span style="font-size:7pt;">1 Aralık 2010 tarihinden itibaren, Kuzey Kıbrıs Türk Cumhuriyeti Hükümeti, K.K.T.C. sınırları içerisinde bahis oynayan müşterilerin bahis ofislerinden veya internet sitelerinden yaptıkları kuponların kazanması durumunda vergiye tabi tutacaktır. <p>10 Aralık 2010 Cuma tarihinden itibaren, Bakanlar Kurulu kararı ile Şans Oyunları Hizmet Vergisi Yasasının ilgili maddesi gereğince kazanan bahislerde toplam ödeme tutarından %5 oranında gelir vergisi stopaj kesintisi yapılacaktır.  Hesabınıza giriş yaptıktan sonra hesap hareketlerinden kazandığınız her kupon tutarının altında kesilen vergi tutarını görebilirsiniz. <p>Bu yasaya bütün K.K.T.C. bahis firmaları uymakla yükümlüdür.</span>
                                </TD></TR>
                            <%}%>
                </TABLE>
            </DIV>
            <DIV id="hdcoupon" style="display:none;width: 350px;">
              
                <DIV id="hdrows">
                    <INPUT  name="hdracetype"    id="hdracetype"  value="0"  type="hidden" >
                    <FORM name="frm_couponak" id="frm_couponak"  onsubmit="return false;">
                    <TABLE border="0" width="100%">
                        <TR>
                            <TD width="50%" class="texttitle_input">	Bahis Tipi
                            </TD>
                            <TD width="25%" class="texttitle">	Bahis Tutarı
                            </TD>
                            <TD width="25%" class="texttitle">
                            </TD>
                        </TR>
                        <TR>
                            <TD>
                                <select id="hd_bettype" name="hd_bettype" onchange="coupon_count(1);" style="width:165px;">
                                </select>
                            </TD>
                            <TD>
                                <INPUT  name="hd_beca_stake" id="hd_beca_stake"  value="1.00"  type="text" style="height:18px;width:65px;text-align:right;vertical-align: middle;"/>
                                <INPUT  name="hdraceid"      id="hdraceid"    value="0"  type="hidden" >
                             </TD>
                            <TD width="70px" align="center">
                                <DIV id="btn_bekle">
                                </DIV>
                                <DIV id="btn_gizle"><A class="button" onClick="get_hdonay('btn_gizle','btn_bekle',5000);"><SPAN>Onayla</SPAN></A>
                                </DIV>
                            </TD>
                        </TR>
                    </TABLE>
                    <DIV style="padding-left:0;padding-top:0px;width:351px;overflow:auto; float:left;background-color:#000000;">
                    <TABLE  id="hdraceselect" class="hdcoupon_table"  border="0" cellpadding="0" cellspacing="0" width="100%">
                        <TR valign="middle" class="hdcoupon_gametype">
                            <TD colspan="4" id="hdracetitle"  class="hdcoupon_gametype" width="100%" valign="middle"> </TD>
                        </TR>
                    </TABLE>
                    </DIV>
                    <TABLE cellpadding="2" cellspacing="2" width="100%">
                        <TR>
                            <TD class="coupon_warning" style="width:100%;">	At ve Tazılarda Bahis Yap tuşundan sonra ONAY EKRANI yoktur.<BR>Lütfen oynadıklarınızı kontrol edip KUPONU ONAYLAYINIZ.
                            </TD>
                        </TR>
                    </TABLE>
                   </FORM>
                   
                </DIV>

            </DIV>

             <DIV  id="hdlastbets" class="coupon_warning" style="padding-left:0;padding-top:0px;width:351px;overflow:auto; float:left;background-color:#000000;">
            </DIV>
        </DIV>
    </DIV>

    <script  type="text/javascript">

        $("#hd_bettype").msDropDown();

    </script>

</BODY>
</HTML>
<%@include file="include_dosya/Connection_End.jsp" %>
<%@include file="include_dosya/Top_End.jsp" %>