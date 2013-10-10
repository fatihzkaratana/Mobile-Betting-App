<%@page import="org.apache.jasper.tagplugins.jstl.core.Catch"%>
<%@ page import="org.omg.CORBA.SystemException" %>
<%@ page import="sun.text.normalizer.UTF16" %>
<%@ page language="java" contentType="text/html;charset=UTF-8" %>
<%@ page import="java.io.*,java.sql.*,java.text.*,javax.sql.*,java.util.*,javax.naming.*,oracle.jdbc.*" %>
<%! 
    public String tpl = "";
    public Integer count = 0;
    public Integer size = 0;
    public String gtid = "";
    public Integer mid;
    public HttpServletRequest request;
    
    String checknull(String xvalue) {
        return (xvalue == null) ? "" : xvalue;
    }

    String checknullzero(String xvalue) {
        return (xvalue == null) ? "0" : xvalue;
   }
    
   public String formatDate(String date, String option){
       //String[] myDate = "";
       String myTime = "";
       String myReturn = "";
       String[] tokens = date.split(" ");
       String[] myDate = tokens[0].split("-");
       String day = myDate[2];
       String month = myDate[1];
       String[] time = tokens[1].split(":");
       String hour = time[0];
       String min = time[1];
       myTime = hour + ":" + min;
       if ( option == "date" ) myReturn = "" + day + "/" + "" + month;
       else if ( option == "time" ) myReturn = myTime;
       return myReturn;
   }
   
    public String getQuery(Integer model, Integer id, Integer mid){
        String query        = "";
        String selectClause = "";
        String fromClause   = "TEMP_COUPON_WWW_MA";
        String whereClause  = "";
        switch (model){
            case 1:
                //create category query
                selectClause = "DISTINCT CAT_IDNAME as \"CATNAME\", CAT_ID as \"CATID\", COUNT(cat_id) as \"lig\"";
                //fromClause  = "";
                whereClause = "DIL_CODE='TR'" + " " + 
                              "GROUP BY CAT_ID, CAT_IDNAME" + " " +
                              "ORDER BY CAT_ID";
                break;
            case 2:
                //create league query
                selectClause = "DISTINCT LEAGUEYEAR_NAME as \"LEAGUENAME\", COU_NAME as \"COUNTRYNAME\", LEA_ID as \"LEAGUEID\", COUNT(LEA_ID) as \"match\" ";
                //fromClause  = "";
                whereClause = "CAT_ID=" + id + " AND DIL_CODE='TR'" + " " +
                              "GROUP BY LEA_ID,LEAGUEYEAR_NAME,COU_NAME" + " " +
                              "ORDER BY LEA_ID ASC";
               break;
            case 3:
                //create match query
                selectClause = "COUNT (TGR_CGTG_NAME) AS \"gt\", TEG_TITLE AS \"matchName\", TEG_ID as \"matchId\", TEG_GAMEDATE AS \"matchDate\"" + " " ;
                fromClause  = "(SELECT DISTINCT dTable.TGR_CGTG_NAME, COUNT (dTable.TEG_ID) as gt, dTable.TEG_ID, mTable.TEG_TITLE, mTable.TEG_GAMEDATE" + " " +
                              "FROM TEMP_COUPON_WWW_DA dTable, TEMP_COUPON_WWW_MA mTable" + " ";
                whereClause = "mTable.LEA_ID=" + id + " AND mTable.team_idhome is not null and mTable.team_idaway is not null and  dTable.DIL_CODE='TR' AND mTable.DIL_CODE='TR' AND mTable.TEG_ID=dTable.TEG_ID" + " " +
                              "GROUP BY dTable.TGR_CGTG_NAME, mTable.TEG_TITLE, dTable.TEG_ID, mTable.TEG_GAMEDATE" + " " +
                              "ORDER BY mTable.TEG_TITLE ASC)" + " " +
                              "GROUP BY TEG_TITLE, TEG_ID, TEG_GAMEDATE" + " " +
                              "ORDER BY TEG_GAMEDATE";
                break;
            case 4:
                //create gametype query      
                selectClause = "TGR_CGTG_NAME as \"gtName\", TEG_ID as \"matchId\", TGR_CGTG_ID as \"gtId\", TGR_CGTG_ORDERBY";
                fromClause  = "(SELECT dTable.TEG_ID, dTable.TGR_CGTG_ID, dTable.TGR_CGTG_NAME, dTable.TGR_CGTG_ORDERBY"+ " " +
                              "FROM TEMP_COUPON_WWW_DA dTable";
                whereClause = "dTable.DIL_CODE='TR' AND dTable.TEG_ID="+ id + " " +
                              "ORDER BY dTable.TGR_CGTG_ORDERBY)" + " " +
                              "GROUP BY TGR_CGTG_ID, TGR_CGTG_NAME, TGR_CGTG_ID, TGR_CGTG_ORDERBY, TEG_ID" + " " +
                              "ORDER BY TGR_CGTG_ORDERBY ASC";
               break;
            case 5:
                //create bet query
                selectClause = "DISTINCT dTable.TEG_ID AS \"matchId\"," + " " +
                                "mTable.TEG_TITLE AS \"matchName\"," + " " +
                                "dTable.TGR_CGTG_ID AS \"gtId\"," + " " +
                                "dTable.TGR_CGTG_NAME AS \"gtName\"," + " " +
                                "dTable.TGR_CHAREX1NAME AS \"betName1\"," + " " +
                                "dTable.TGR_CHAREX2NAME AS \"betName2\"," + " " +
                                "dTable.TGR_CHAREX3NAME AS \"betName3\"," + " " + 
                                "dTable.TGR_RATEN1 AS \"betRate1\"," + " " +
                                "dTable.TGR_RATEN2 AS \"betRate2\"," + " " +
                                "dTable.TGR_RATEN3 AS \"betRate3\"" + " ";
                fromClause  = "TEMP_COUPON_WWW_DA dTable, TEMP_COUPON_WWW_MA mTable";
                whereClause = "dTable.DIL_CODE='TR' AND dTable.TEG_ID=" + id + " " +//"dTable.DIL_CODE='TR' AND dTable.TEG_ID=" + mid + " AND dTable.TGR_CGTG_ID=" + id + " " +
                              "AND dTable.TEG_ID=mTable.TEG_ID" + " " +
                              "ORDER BY dTable.TGR_CHAREX1NAME";
                break;
        }
        query = "SELECT " + selectClause + " " +
                "FROM " + fromClause + " " +
                "WHERE " + whereClause;
        return query;
    }
    
    public String getJSONFormat(Integer model, Statement stsql, String sql){
        String selectQuery = "SELECT COUNT(*) as \"s\" FROM("+ sql +")";
    	switch (model){
            case 1:
                //category json file
                try{
                    ResultSet rs = stsql.executeQuery(selectQuery);
                    while ( rs.next() ){
                        size = Integer.parseInt(rs.getString("s"));
                    }
                }catch (SQLException e){}
                try{
                    tpl = "";
                    count = 0;
                    ResultSet rsetC = stsql.executeQuery(sql);
                    while (rsetC.next()){
                        tpl +=  "{\"catId\": \"" + rsetC.getString("CATID") + "\"," +
                                "\"catName\": \"" + rsetC.getString("CATNAME") + "\"," +
                                "\"lig\": \"" + rsetC.getString("lig") + "\"," +
                                "\"leaf\": \"false\"," +
                                "\"model\": \"Category\"}";
                        if ( size - count != 1 ){
                            tpl += ",\n";
                        }else{
                            tpl += "\n";
                        }
                        count ++;
                    }
                }catch (SQLException e) 
                {   
                }
                break;
            case 2:
                //league json file
                try{
                    ResultSet rs = stsql.executeQuery(selectQuery);
                    while ( rs.next() ){
                        size = Integer.parseInt(rs.getString("s"));
                    }
                }catch (SQLException e){}
                try{
                    tpl = "";
                    ResultSet rsetL = stsql.executeQuery(sql);
                    count = 0;
                    while (rsetL.next()){
                        tpl +=  "{\"leagueId\":" + " \"" + rsetL.getString("LEAGUEID") + "\"," +
                                "\"leagueName\":" + " \"" + rsetL.getString("LEAGUENAME") + "\"," +
                                "\"couName\":" + " \"" + rsetL.getString("COUNTRYNAME") + "\"," +
                                "\"match\":" + " \"" + rsetL.getString("match") + "\"}";
                        if ( size - count != 1 ){
                            tpl += ",\n";
                        }else{
                            tpl += "\n";
                        }
                        count ++;
                    }
                }catch (SQLException e) 
                {   
                }
                break;
            case 3:
                //match json file
                try{
                    ResultSet rs = stsql.executeQuery(selectQuery);
                    while ( rs.next() ){
                        size = Integer.parseInt(rs.getString("s"));
                    }
                }catch (SQLException e){}
                try{
                    tpl = "";
                    ResultSet rsetM = stsql.executeQuery(sql);
                    count = 0;
                    while (rsetM.next()){
                        tpl +=  "{\"matchId\": \"" + rsetM.getString("matchId") + "\"," +
                                "\"matchName\": \"" + rsetM.getString("matchName") + "\"," +
                                "\"matchDate\": \"" + formatDate(rsetM.getString("matchDate"),"date") + "\"," +
                                "\"matchTime\": \"" + formatDate(rsetM.getString("matchDate"),"time") + "\"," +
                                "\"gt\": \"" + rsetM.getString("gt") + "\"}";
                        if ( size - count != 1 ){
                            tpl += ",\n";
                        }else{
                            tpl += "\n";
                        }
                        count ++;
                    }
                }catch (SQLException e) 
                {   
                }
                
                break;
            case 4:
                //gametype json file
                try{
                    ResultSet rs = stsql.executeQuery(selectQuery);
                    while ( rs.next() ){
                        size = Integer.parseInt(rs.getString("s"));
                    }
                }catch (SQLException e){}
                try{
                    tpl = "";
                    ResultSet rsetG = stsql.executeQuery(sql);
                    count = 0;
                    while (rsetG.next()){
                        tpl +=  "{\"gtId\": \"" + rsetG.getString("gtId") + "\"," +
                                "\"gtName\": \"" + rsetG.getString("gtName") + "\"," +
                                "\"matchId\": \"" + rsetG.getString("matchId") +"\"}";
                        if ( size - count != 1 ){
                            tpl += ",\n";
                        }else{
                            tpl += "\n";
                        }
                        count ++;
                    }
                }catch (SQLException e) 
                {   
                }
                break;
            case 5:
                //league bet file
                try{
                    ResultSet rs = stsql.executeQuery(selectQuery);
                    while ( rs.next() ){
                        size = Integer.parseInt(rs.getString("s"));
                    }
                }catch (SQLException e){}
                try{
                    tpl = "";
                    ResultSet rsetB = stsql.executeQuery(sql);
                    count = 0;
                    while (rsetB.next()){
                        tpl +=  "{\"gtName\": \"" + rsetB.getString("gtName") + "\"," +
                                "\"gtId\": \""+ rsetB.getString("gtId") + "\"," +
                                "\"matchId\": \""+ rsetB.getString("matchId") + "\"," +
                                "\"matchName\": \""+ rsetB.getString("matchName") + "\"," +
                                "\"betName1\": \""+ checknullzero(rsetB.getString("betName1")) + "\"," +
                                "\"betRate1\": \""+ checknullzero(rsetB.getString("betRate1")) + "\"," +
                                "\"betName2\": \""+ checknullzero(rsetB.getString("betName2")) + "\"," +
                                "\"betRate2\": \""+ checknullzero(rsetB.getString("betRate2")) + "\"," +
                                "\"betName3\": \""+ checknullzero(rsetB.getString("betName3")) + "\"," +
                                "\"betRate3\": \""+ checknullzero(rsetB.getString("betRate3")) + "\"}";
                        if ( size - count != 1 ){
                            tpl += ",\n";
                        }else{
                            tpl += "\n";
                        }
                        count ++;
                    }
                }catch (SQLException e) 
                {   
                }
                break;
        }
    	return tpl;
    }
    
    
%>
<% 
    try 
    {
        Context initCtx = new InitialContext();
        Context envCtx = (Context) initCtx.lookup("java:comp/env");
        DataSource ds = (DataSource) envCtx.lookup("jdbc/nicobet");
        Connection conn = ds.getConnection();
        try
        {
            Statement stmtsql = conn.createStatement ();
            Integer model = Integer.parseInt(checknullzero(request.getParameter("model")));
            Integer id = Integer.parseInt(checknullzero(request.getParameter("id")));
            Integer mid = Integer.parseInt(checknullzero(request.getParameter("mid")));
            String sql = getQuery(model,id, mid);
            ResultSet rsetsql = stmtsql.executeQuery(sql) ;
            out.print("{\n\"items\": [\n");
            out.print(getJSONFormat(model, stmtsql, sql));
            out.print("\n] }");
            //out.print(sql);
            rsetsql.close();
            stmtsql.close();
        }
        catch (SQLException e) 
        { 
            out.println(e.toString());
        }
        conn.close();
    }
    catch (NamingException e)
    {
        out.println(e.toString());
    }
    catch (SQLException e)
    {  
        out.println(e.toString());
    }
%>