<%-- 
    Document   : index
    Created on : Feb 27, 2012, 3:37:31 PM
    Author     : fatih
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8">
    <link href="app/lib/images/favicon.ico" rel="shortcut icon" type="image/x-icon">
    <title>Nicosia Betting</title>
    <!-- Resources -->
        <link rel="stylesheet" href="app/lib/css/css.css" type="text/css">
	<script type="text/javascript" src="app/lib/sencha/sencha-touch.js"></script>
	<script type="text/javascript" src="conf/globals.js"></script>
        <script type="text/javascript" src="app/controller/functions.js"></script>
	<script type="text/javascript" src="index.js"></script>
	<!-- Models -->
	<script type="text/javascript" src="app/model/Member.js"></script>
	<script type="text/javascript" src="app/model/Category.js"></script>
	<script type="text/javascript" src="app/model/League.js"></script>
	<script type="text/javascript" src="app/model/Match.js"></script>
        <script type="text/javascript" src="app/model/Bet.js"></script>
	<script type="text/javascript" src="app/model/PastBets.js"></script>
	<script type="text/javascript" src="app/model/Transaction.js"></script>
	<script type="text/javascript" src="app/model/Coupon.js"></script>
	<!-- Controllers -->
	<script type="text/javascript" src="app/controller/LoginFormController.js"></script>
	<script type="text/javascript" src="app/controller/Toolbars.js"></script>
	<script type="text/javascript" src="app/controller/Buttons.js"></script>
	<script type="text/javascript" src="app/controller/storeUser.js"></script>
        <script type="text/javascript" src="app/controller/storeCategory.js"></script>
        <script type="text/javascript" src="app/controller/storeCoupon.js"></script>
	<script type="text/javascript" src="app/tpl/tplMemberInfo.js"></script>
	<script type="text/javascript" src="app/tpl/tplMemberBet.js"></script>
	<script type="text/javascript" src="app/tpl/tplMemberTransactions.js"></script>
        <script type="text/javascript" src="app/tpl/tplCategory.js"></script>
        <script type="text/javascript" src="app/tpl/tplLeague.js"></script>
        <script type="text/javascript" src="app/tpl/tplMatch.js"></script>
        <script type="text/javascript" src="app/tpl/tplBet.js"></script>
        <script type="text/javascript" src="app/tpl/tplCoupon.js"></script>
	<!-- Views -->
        <script type="text/javascript" src="app/view/panel/panelLoggedIn.js"></script>
        <script type="text/javascript" src="app/view/panel/panelCategory.js"></script>
        <script type="text/javascript" src="app/view/panel/panelCoupon.js"></script>
        <script type="text/javascript" src="app/view/viewLoginForm.js"></script>
	<script type="text/javascript" src="app/view/panel/panelMemberInfo.js"></script>
	<script type="text/javascript" src="app/view/panel/panelMemberBets.js"></script>
	<script type="text/javascript" src="app/view/panel/panelMemberTransaction.js"></script>
	<script type="text/javascript" src="app/view/viewHome.js"></script>
        <script type="text/javascript" src="app/view/viewMember.js"></script>
        <script type="text/javascript" src="app/view/viewBetList.js"></script>
        <script type="text/javascript" src="app/view/viewCoupon.js"></script>
</head>
<body></body>
</html>