function addPanel(panel,item){
	 panel.render(document.body);
	 panel.add(item);
	 panel.doLayout();
}

function removePanel(panel,item){
	 panel.render(document.body);
	 panel.remove(item);
	 panel.doLayout();
}

function removeDocked(panel,item){
	 panel.render(document.body);
	 panel.removeDocked(item);
	 panel.doLayout();
}

function createCoupon(matchId, matchName, betName, betRate, flag){
    if ( document.getElementById('viewCoupon') == null ){      
        addPanel(navPanel,viewCoupon);
    }else{
        storeCoupon.add({
           matchId : matchId,
           matchName: matchName,
           betName: betName,
           betRate: betRate
        });
        navPanel.tabBar.getComponent(3).setBadge(storeCoupon.getCount());
        couponBack.show();
    } 
}

function sendCouponList(couponList){
    alert('hey There');
}

function generatePanel(id, model, parent, mid, count){
    var newPanel,
        newUrl = getStoreUrl(model, id, mid),
        newTpl = getPanelTpl(model, id, mid),
        sorter = getSorter(model, id, mid),
        group = getGroup(model, id, mid),
        newTitle = parent, // + ' (' + count + ')',
        pId = viewBetList.getActiveItem().getId(),
        newId = 'panel' + id + '.' + pId,
        backFlag = true;
    console.log(pId + " -> GeneratePanel newId -> " + newId);
    
    var newStore = new Ext.data.Store({
        model: model,
        sorters: sorter,
        getGroupString : function(record) {
            var gString =record.get(group); 
            return gString;
        },
        proxy: {
            type: 'ajax',
            url : newUrl,
            reader: {
                type: 'json',
                root: 'items'
            }
        },
        autoLoad: true
    });
    panelCls.push(document.getElementById('toolbarBetList').className);
    console.log("Toolbar class -> " + panelCls);
    
    if ( document.getElementById(newId) == null ) {
        newPanel = new Ext.List({    
            cls: newId,
            id : newId,
            store: newStore,
            itemTpl: newTpl,
            overItemCls:'x-list-item',
            itemSelector:'button#betButton',
            grouped : true,
            loadingMask: false,
            indexBar: getIndexBar(model),
            loadingText: "Bilgiler yükleniyor...",
            scroll: 'vertical'
        });
        viewBetList.render(document.body);
        viewBetList.insert(viewBetList.items.indexOf(viewBetList.getActiveItem().getId()),newPanel);
        viewBetList.setActiveItem(newPanel, {type: 'slide', direction: 'left'} );
        viewBetList.doLayout();
        if ( model == "League" ){
            toolbarBetList.addCls(parent.replace(" ",""));
        }
        
    }else{
        viewBetList.render(document.body);
        viewBetList.setActiveItem(newId, {type: 'slide', direction: 'left'});
        viewBetList.doLayout();
        
    }
    console.log(titleStack.push(newTitle));
    console.log("Title stact is " + titleStack);
    console.log(backStack.push(pId));
    console.log("Back stack is " + backStack);
    if ( viewBetList.getActiveItem().getId() != "panelCategory" || backStack.length != 0){
        btnBack.setHandler(function(){
           viewBetList.setActiveItem(backStack[backStack.length-1], {type: 'slide', direction: 'right'}); 
           toolbarBetList.setTitle(titleStack[titleStack.length-2]);
           console.log("Parent is -> " + parent );
           toolbarBetList.removeCls(parent.replace(" ",""));
           console.log("New title is " + titleStack[titleStack.length-2]);
           console.log(titleStack.splice());
           console.log("Active panel is " + backStack);
           console.log("Backstack spliced to " + backStack.splice(0));
           if ( panelCls.length <= 0 ){
               document.getElementById("toolbarBetList").className = "x-toolbar x-toolbar-glass x-docked x-docked-top";
           }else{
               document.getElementById("toolbarBetList").className = panelCls[panelCls.length-1];
           }
           console.log("Toolbar class is now -> " + document.getElementById("toolbarBetList").className);
          console.log("Panelclass spliced to " + panelCls.splice(0));
           if ( viewBetList.getActiveItem().getId() == "panelCategory" ){
               backFlag = false;
               toolbarBetList.setTitle("Bahis Listesi");
           }else{
               backFlag = true;
           }
           console.log(backFlag);
           showHideBtnBack(backFlag);
        });
        btnBack.show();
        if ( model == 'League' )
            toolbarBetList.addCls(parent.replace(" ",""));
        toolbarBetList.setTitle(newTitle);
    }
}

function showHideBtnBack(backFlag){
    if( backFlag ){
            btnBack.show();
            console.log("Panel category button show");
        }else{
            btnBack.hide();
            console.log("Panel category button hide");
        }
}

function getIndexBar(model){
    var returnIndex = "";
    if ( model != null || id != null ){
        switch (model){
            case "League":
                returnIndex = true;
            break;
            case "Match":
                returnIndex = false;
            break;
            case "Bet":
                returnIndex = false;
            break;
        }
    }else{
        returnIndex = false;
    }
    return returnIndex;
}

function getSorter( model, id, mid ){
    var returnSorter = "";
    if ( model != null || id != null ){
        switch (model){
            case "League":
                returnSorter = 'couName';
            break;
            case "Match":
                returnSorter = 'matchDate';
            break;
            case "Bet":
                returnSorter = 'gtName';
            break;
        }
    }else{
        returnSorter = 'gtName';
    }
    return returnSorter;
}


function getGroup( model, id, mid ){
    var returnGroup = "";
    if ( model != null || id != null ){
        switch (model){
            case "League":
                returnGroup = 'couName';
            break;
            case "Match":
                returnGroup = 'matchDate';
            break;
            case "Bet":
                returnGroup = 'gtName';
            break;
        }
    }else{
        returnGroup = 'http://' + serverURL + '/select.jsp?model=1';
    }
    return returnGroup;
}

function getStoreUrl( model, id, mid ){
    var returnUrl = "";
    if ( model != null || id != null ){
        switch (model){
            case "League":
                returnUrl = 'http://' + serverURL + '/select.jsp?model=2&id=' + id + '&mid=' + mid;
            break;
            case "Match":
                returnUrl = 'http://' + serverURL + '/select.jsp?model=3&id=' + id + '&mid=' + mid;
            break;
            case "Bet":
                returnUrl = 'http://' + serverURL + '/select.jsp?model=5&id=' + id + '&mid=' + mid;
            break;
        }
    }else{
        returnUrl = 'http://' + serverURL + '/select.jsp?model=1';
    }
    return returnUrl;
}

function getPanelTpl(model, id){
    var returnTpl = "";
    if ( model != null || id != null ){
        switch (model){
            case "League":
                returnTpl = tplLeague;
            break;
            case "Match":
                returnTpl = tplMatch;
            break;
            case "Bet":
                returnTpl = tplBet;
            break;
        }
    }else{
        returnTpl = new Ext.XTemplate(
                            '<tpl for=".">',
                                    '<button id="betButton" onClick="generatePanel(\'{catId}\',\'League\', \'{catName}\')">\n',
                                       '<div class="title">{catName}</div><div class="metadata">({lig})</div>',
                                    '</button>',
                                    '<br style="clear: both;" />',
                            '</tpl>'
                            );
    }
    return returnTpl;
}
