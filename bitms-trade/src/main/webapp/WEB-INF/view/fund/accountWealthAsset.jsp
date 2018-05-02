<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="/global/header.jsp" %>
<%@ include file="/global/setup_ajax.jsp"%>
<html>
<body>
<div class="container">
    <%--头部--%>
    <%@ include file="/global/topNavBar.jsp"%>
    <%--代码开始--%>
    <div class="row">
        <%@ include file="/global/topPublicNav.jsp" %>
        <div class="col-sm-12 column">
            <%--开始代码位置--%>
            <ul class="nav nav-tabs bitms-tabs" style="background-color:transparent;margin-right:0px;margin-top:-15px;">
                <li onclick="jumpUrl('${ctx}/spot/historyEntrust')">
                    <a data-toggle="tab"><%--历史委托--%><fmt:message key="spot.query.historyEntrust" /></a>
                </li>
                <%--<li class="active">
                    <a href="#" data-toggle="tab">>&lt;%&ndash;出借记录&ndash;%&gt;<fmt:message key="fund.tab.weathflow" /></a>
                </li>--%>
                <li onclick="jumpUrl('${ctx}/fund/accountDebitAsset')">
                    <a href="#" data-toggle="tab"><%--借贷流水--%><fmt:message key="fund.tab.debitflow" /></a>
                </li>
                <li onclick="jumpUrl('${ctx}/fund/financialCurrents')">
                    <a href="#" data-toggle="tab"><%--财务流水--%><fmt:message key="fund.tab.financeflow" /></a>
                </li>
                <%--<li onclick="jumpUrl('${ctx}/fund/currents')">
                    <a href="#" data-toggle="tab">&lt;%&ndash;交易流水&ndash;%&gt;<fmt:message key="fund.tab.Dealflow" /></a>
                </li>--%>
            </ul>
            <form class="clearfix" data-widget="validator" name="currentsForm" id="currentsForm">
                <div class="panel clearfix">
                    <div class="col-sm-12 px0">
                        <div class="form-group col-sm-1 col-xs-12 px0 text-center" style="display: none;">
                            <span><%--交易对--%><fmt:message key="spot.currencyTrade.transPair" /></span>
                        </div>
                        <div class="form-group col-lg-2 col-sm-3 col-xs-12" style="display: none;">
                            <select id="relatedStockinfoId" name="relatedStockinfoId" class="form-control">
                            </select>
                        </div>
                        <div class="form-group col-sm-1 col-xs-12 px0 text-center">
                            <span><%--起始时间--%><fmt:message key="fund.currents.startingTime" /></span>
                        </div>
                        <div class="form-group col-lg-2 col-sm-3 col-xs-12">
                            <input name="timeStart" id="timeStart" class="form-control timeOpen" />
                        </div>
                        <div class="form-group col-sm-1 col-xs-12 px0 text-center">
                            <span><%--结束时间--%><fmt:message key="fund.currents.terminalTime" /></span>
                        </div>
                        <div class="form-group col-lg-2 col-sm-3 col-xs-12">
                            <input name="timeEnd" id="timeEnd" class="form-control" />
                        </div>
                        <div class="form-group col-sm-3 col-xs-12">
                            <button type="button" class="btn btn-primary" id="searchBtn"><%--查询--%><fmt:message key="search" /></button>
                        </div>
                    </div>
                </div>
                <div class="panel clearfix">
                    <div class="table-responsive">
                        <table class="table table-hover">
                            <thead>
                            <tr>
                                <th><%--时间--%><fmt:message key="time" /></th>
                                <%--交易专区--%> <%--<th><fmt:message key="fund.accountDebitAsset.tradingZone" /></th>--%>
                                <th><%--资产分类--%><fmt:message key="fund.accountDebitAsset.assetsType" /></th>
                                <th><%--本息合计--%><fmt:message key="fund.accountWealthAsset.total" /></th>
                                <th><%--有效计息金额--%><fmt:message key="fund.accountWealthAsset.effectiveAmount" /></th>
                                <th><%--基金日利率--%><fmt:message key="fund.accountWealthAsset.dayRate" /></th>
                                <th><%--当日收益--%><fmt:message key="fund.accountWealthAsset.dayInterest" /></th>
                            </tr>
                            </thead>
                            <tbody id="list_emement">
                            </tbody>
                        </table>
                        <div class="mt10 m010">
                            <%-- 通用分页 --%>
                            <div id="curr_pagination" class="paginationContainer"></div>
                        </div>
                    </div>
                </div>
            </form>
        </div>
    </div>
</div>
<script id="list_tpl" type="text/html">
    {{each rows}}
    <tr class="test">
        <td>{{$formatDate $value.updateDate}}</td>
        <%--<td>{{$value.tradingZone}}</td>--%>
        <td>{{$value.stockCode}}</td>
        <td>{{$fix8Date $value.wealthAmt}}</td>
        <td>{{$fix8Date $value.effectiveWealthAmt}}</td>
        <td>{{$percentDate $value.wealthDayRate}}%</td>
        <td>{{$fix8Date $value.dayInterest}}</td>
    </tr>
    {{/each}}
</script>
<script>
    seajs.use([ 'pagination', 'template', 'moment','my97DatePicker' ], function(Pagination, Template, moment) {
        template.helper('$formatDate', function(millsec) {
            return moment(millsec).format("YYYY-MM-DD HH:mm");
        });
        template.helper('$fix8Date', function (flag) {
            if(flag == '' || flag == null){
                return '0';
            }
            return parseFloat(flag).toFixed(8);
        });
        template.helper('$percentDate', function (flag) {
            if(flag == '' || flag == null){
                return '0';
            }
            return (100*parseFloat(flag)).toFixed(2);
        });
        var timestamp=new Date().getTime();
        //$('#timeStart').val(moment(timestamp).format('YYYY-MM-DD'));
        //$('#timeEnd').val(moment(timestamp).format('YYYY-MM-DD'));
        $('#timeStart').on('click', function(){
            WdatePicker(
                {
                    minDate:"2017-01-01",
                    maxDate:""+moment(timestamp).format("YYYY-MM-DD"),
                    lang:'en'
                }
            );
        });
        $('#timeEnd').on('click', function(){
            WdatePicker(
                {
                    minDate:"2017-01-01",
                    maxDate:""+moment(timestamp).format("YYYY-MM-DD"),
                    lang:'en'
                }
            );
        });

        renderPage = new Pagination({
            beforeAjax:function(){
                $('#searchBtn').attr("disabled", true);
                $('.reg-pop').show();
            },
            url : "${ctx}/fund/accountWealthAsset/getAccountWealthAssetData",
            elem : "#curr_pagination",
            form : $("#currentsForm"),
            rows : 10,
            method : "post",
            handleData : function(json) {
                var html = Template.render("list_tpl", json);
                $("#list_emement").html(html);
                $('#searchBtn').attr("disabled", false);
                $('.reg-pop').hide();
            }
        });
    });

    $("#searchBtn").click(function() {
        renderPage.render(true);
    });

    $(function(){
        $.ajax({
            url : '${ctx}/common/stockinfo/canBorrow',
            type : "get",
            cache : false,
            async : false,// false=同步调用，锁定其它JS操作
            dataType : "json",
            error : function(XMLHttpRequest, textStatus, errorThrown) {
                alert('服务器连接失败，请稍候重试！');
            },
            success : function(data, textStatus) {
                console.log(data);
                for (var i = 0; i < data.length; i++) {
                    $("#relatedStockinfoId").append(
                        "<option value='"+data[i].id+"'>"
                        + data[i].stockName + "</option>");
                }
                $("#relatedStockinfoId").val('<%=FundConsts.WALLET_BTC2USD_TYPE%>'); }
        });
    });

</script>
</body>
</html>