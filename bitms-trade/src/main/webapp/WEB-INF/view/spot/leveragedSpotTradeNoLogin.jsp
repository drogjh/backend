<%@ page import="com.blocain.bitms.quotation.consts.InQuotationConsts" %>
<%@ page import="com.blocain.bitms.trade.trade.enums.TradeEnums" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="/global/header.jsp" %>
<%@ include file="/global/setup_ajax.jsp"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ page import="com.blocain.bitms.security.OnLineUserUtils" %>
<%@ page import="com.blocain.bitms.tools.consts.BitmsConst" %>
<script src="${ctx}/scripts/gallery/echarts/echarts.js"></script>
<%-- 此段必须要引入 t为小时级别的时间戳 --%>
<link type="text/css" href="//g.alicdn.com/sd/ncpc/nc.css?t=1502956831425" rel="stylesheet"/>
<script type="text/javascript" src="//g.alicdn.com/sd/ncpc/nc.js?t=1502956831425"></script>
<%-- 引入结束 --%>
<%-- 此段必须要引入 --%>
<div id="_umfp" style="display:inline;width:1px;height:1px;overflow:hidden"></div>
<%-- 引入结束 --%>
<html>
<body>
<div class="pageLoader"><div class="rp-inner loader-inner ball-clip-rotate-multiple"><div></div><div></div></div></div>
<div class="container">
    <%--头部--%>
    <%@ include file="/global/nologTopNav.jsp" %>
    <%--代码开始--%>
    <div class="row">
        <form method="post" action="/spot/leveragedSpotTrade" id="jumpForm">
            <input type="hidden" id="jumpId" name="exchangePairMoney" value="${money.id}" />
        </form>
        <div class="col-sm-12 column">
            <div class="panel pb5">
                <div class="row hidden-xs">
                    <div class="col-lg-12">
                        <div id="C2CKlineDiv" class="bitms-bg1 bitms-c2 col-lg-12 clearfix p5" style="cursor: pointer;border-bottom: 1px solid #23333f">
                            <span class="pl10 glyphicon glyphicon-chevron-down">&nbsp;<%--行情图表--%><fmt:message key='spot.C2C.quotationChart' /></span>
                        </div>
                        <div id="C2CKline" class="clearfix col-lg-12 bitms-hide">
                            <ul id="kLineTopic" class="col-xs-12 nav nav-tabs bitms-tabs bitms-c2c-tabs mt10">
                                <li tips="1m" data="${money.topicKline1m}" class="active"><a data-toggle="tab">1m</a></li>
                                <li tips="5m" data="${money.topicKline5m}"><a data-toggle="tab">5m</a></li>
                                <li tips="15m" data="${money.topicKline15m}"><a data-toggle="tab">15m</a></li>
                                <li tips="30m" data="${money.topicKline30m}"><a data-toggle="tab">30m</a></li>
                                <li tips="60m" data="${money.topicKlineHour}"><a data-toggle="tab">1h</a></li>
                                <li tips="1d" data="${money.topicKlineDay}"><a data-toggle="tab">1d</a></li>
                                <%--<li tips="周线" data="${money.topicKlineWeek}"><a data-toggle="tab">周线</a></li>--%>
                                <%--<li tips="月线" data="${money.topicKlineMonth}"><a data-toggle="tab">月线</a></li>--%>
                            </ul>
                            <!--K线图-->
                            <div id="bit_market"></div>
                        </div>
                    </div>
                </div>
                <div class="row">
                    <div class="col-lg-9 px0">
                        <div class="col-lg-12 clearfix pr5 mt10 mb10 hidden-xs">
                            <div class="bitms-bg1 p5 pl10 clearfix">
                                <div class="col-sm-2 px0" style="line-height: 40px;border-right: 1px solid #22333f">
                                    <a id="drop4" href="#" class="dropdown-toggle bitms-c2" style="cursor: default" data-toggle="dropdown" role="button" aria-haspopup="true" aria-expanded="true">
                                        <span>${money.stockName}</span>
                                        <span class="dataTxt" style="padding: 0px 2px;border-radius: 2px;color: #1e222d;background-color: #87CEEB"><%--现货--%><fmt:message key='spot.C2C.margin' /></span>
                                        <%--<span class="caret"></span>--%>
                                    </a>
                                    <%--<ul class="dropdown-menu bitms-c2" aria-labelledby="drop4" style="border: 4px solid #23333f;padding: 4px;">
                                        <c:if test="${!empty stockInfoList}">
                                            <c:forEach items="${stockInfoList}" var="obj">
                                                <li style="padding: 5px;">
                                                    <a class="text-center" onclick="jumpUrl(this)" remark="${obj.remark}" id="${obj.id}">
                                                        <span style="text-align:left">${obj.stockName}</span>
                                                        <span class="dataTxt" style="padding: 0px 2px;border-radius: 2px;color: #1e222d;background-color: #59743a">&lt;%&ndash;现货&ndash;%&gt;<fmt:message key='spot.C2C.spot' /></span>
                                                    </a>
                                                </li>
                                            </c:forEach>
                                        </c:if>
                                    </ul>--%>
                                </div>
                                <div id="quotation" class="col-sm-10 clearfix px0 pr5 pl5 text-right">

                                </div>
                            </div>
                        </div>
                        <div class="col-lg-5 clearfix pr5 mb10">
                            <div class="col-sm-12 bitms-bg1 C2Ctable pt10 pb10 pr30" id="C2CbuySell">
                                <div class="thead tr clearfix" style="margin-bottom: 5px;">
                                    <span class="col-sm-2 col-xs-4 bitms-c2" style="text-align: center"><%--买卖--%><fmt:message key='spot.C2C.buySell' /></span>
                                    <span class="col-sm-3 col-xs-4 bitms-c2"><%--价格--%>(${money.capitalAmtSymbol})<fmt:message key='price' /></span>
                                    <span class="col-sm-3 col-xs-4 bitms-c2"><%--数量--%>(${money.tradeAmtSymbol})<fmt:message key='number' /></span>
                                    <span class="col-sm-4 hidden-xs bitms-c2"><%--累计--%>(${money.tradeAmtSymbol})<fmt:message key='spot.C2C.cumulative' /></span>
                                </div>
                                <div id="deep_sell">

                                </div>
                                <hr style="margin-top: 8px;margin-bottom: 8px;">
                                <div id="deep_buy">

                                </div>
                                <%--<div class="clearfix mt10 mb10 ml20 dataTxt">
                                    <ul id="deepLevel" class="nav nav-tabs bitms-tabs bitms-depth-tabs" style="display: inline-block">
                                        <span class="bitms-c2 pull-left">&lt;%&ndash;深度&ndash;%&gt;<fmt:message key='spot.C2C.depth' />:</span>
                                        <li data="0" class="active"><a data-toggle="tab">0</a></li>
                                        <li data="1"><a data-toggle="tab">1</a></li>
                                        <li data="2"><a data-toggle="tab">2</a></li>
                                        <li data="3"><a data-toggle="tab">3</a></li>
                                        <li data="4"><a data-toggle="tab">4</a></li>
                                        <li data="5"><a data-toggle="tab">5</a></li>
                                    </ul>
                                    <i style="line-height: 20px" class="ml5 glyphicon glyphicon-signal text-success pull-right"></i>
                                </div>--%>
                            </div>
                        </div>
                        <div class="col-lg-7 clearfix pl5 pr5 mb10">
                            <div style="z-index:1;position: absolute;width: 98.5%;height: 100%;background: rgba(112,128,144,0.25);"></div>
                            <div class="btn cf btn-info" data-toggle="modal" data-target="#login-con" style="border:none;position: absolute;top: 40%;left: 50%;margin-left: -61px;z-index: 2;"><%--请先登录后操作--%><fmt:message key='spot.C2C.noLoginTxt' /></div>
                            <%--<div class="bitms-bg1 p10 mb10 hidden-xs clearfix dataTxt">
                                <div class="col-sm-6 px0 pr5 clearfix">
                                    <span class="pull-left bitms-c2">&lt;%&ndash;钱包账户&ndash;%&gt;<fmt:message key='spot.C2C.walletAccount' />：</span>
                                    <a class="pull-right" style="border-bottom: 0.1px solid #87CEEB;color: #87CEEB;" href="${ctx}/fund/withdraw">&lt;%&ndash;提现&ndash;%&gt;<fmt:message key='spot.C2C.withdraw' /></a>
                                    <a class="pull-right" style="border-bottom: 0.1px solid #87CEEB;color: #87CEEB;margin-right: 5px;" href="${ctx}/fund/charge">&lt;%&ndash;充值&ndash;%&gt;<fmt:message key='spot.C2C.deposit' /></a>
                                    <span class="pull-right text-success pr5">${walletAsset.stockCode }</span>
                                    <span class="pull-right text-success pr5"><fmt:formatNumber type="number" value="${walletAsset.amount }" pattern="0.0000" maxFractionDigits="4"/>  </span>
                                </div>
                                <div class="col-sm-6 px0 pl5 clearfix">
                                    <span class="pull-left bitms-c2">&lt;%&ndash;出借账户&ndash;%&gt;<fmt:message key='spot.C2C.lendAccount' />：</span>
                                    <a class="pull-right" style="border-bottom: 0.1px solid #888;color: #888;" href="${ctx}/fund/accountWealthAsset">&lt;%&ndash;收益记录&ndash;%&gt;<fmt:message key='spot.C2C.interest' /></a>
                                    <span class="pull-right text-danger pr5">${wealthAsset.stockCode }</span>
                                    <span class="pull-right text-danger pr5"><fmt:formatNumber type="number" value="${wealthAsset.wealthAmt }" pattern="0.0000" maxFractionDigits="4"/></span>
                                </div>
                            </div>--%>
                            <div class="bitms-bg1 p10 pb0 clearfix">
                                <div class="col-sm-12 bitms-c2 px0 mb10 dataTxt clearfix" style="border-bottom: 1px solid #22333f;padding-bottom: 10px!important;">
                                    <div class="col-xs-6 px0 pr5 clearfix">
                                        <span class="pull-left"><%--交易账户--%><fmt:message key='spot.C2C.contractAccount' /></span>
                                        <a class="pull-right" style="border-bottom: 0.1px solid #87CEEB;color: #87CEEB;" href="${ctx}/fund/accountAsset"><%--账户划转--%><fmt:message key='spot.C2C.conversion' /></a>
                                    </div>
                                    <div class="col-xs-6 px0 pr5 clearfix text-right">
                                        <div class="dataTxt px0" style="display: inline-block;margin-top: 2px;">
                                            <span id="autoBorrowText"><fmt:message key='${autoBorrow eq 1?"spot.C2C.open":"spot.C2C.close"}' /></span>
                                            <input type="checkbox" ${autoBorrow eq 1?'checked':''}  id="autoBorrow" class="chooseBtn" />
                                            <label for="autoBorrow" class="choose-label"></label>
                                        </div>
                                    </div>
                                </div>
                                <div class="col-sm-12 dataTxt px0 mb10 clearfix" style="border-bottom: 1px solid #22333f;padding-bottom: 10px!important;" id="datatxtDiv1">
                                    <div class="col-xs-6 px0 pr5 text-left" style="display: inline-block">
                                        <span class="pull-left"><%--折合净值--%><fmt:message key='spot.C2C.netAsset' />:</span>
                                        <span class="text-success pull-right">BTC</span>
                                        <span class="text-success pull-right pr5" id="btcNetValue"></span>
                                    </div>
                                    <div class="col-xs-6 px0 pl5 text-center" style="display: inline-block">
                                        <span class="pull-left"><%--预估强平--%><fmt:message key='spot.C2C.explosionPrice' />:</span>
                                        <span class="bitms-c2 pull-right" id="riskRate" style="background-color:#59743a;display: inline-block;padding: 0px 2px;border-radius: 2px;color: #151922;"><%--安全--%><fmt:message key='spot.C2C.security' /></span>
                                        <span class="text-success pull-right pr5" id="explosionPrice"></span>
                                        <%--<span class="bitms-c2" id="direction" style="background-color:#59743a;display: inline-block;padding: 0px 2px;border-radius: 2px;color: #151922;">空头</span>--%>
                                    </div>
                                </div>
                                <form:form class="form-horizontal col-sm-6 px0 pr5 pl5 bitms-bg1" id="C2Cbuyform">
                                    <input name="exchangePairMoney" type="hidden" value="${exchangePairMoney}" class="form-control">
                                    <input name="exchangePairVCoin" type="hidden" value="${exchangePairVCoin}" class="form-control">
                                    <input name="entrustType" type="hidden" value="<%=TradeEnums.ENTRUST_X_ENTRUST_TYPE_LIMITPRICE.getCode()%>" class="form-control">
                                    <div class="form-group mb5">
                                        <div class="col-xs-12 dataTxt">
                                            <span><%--可用--%><fmt:message key='spot.C2C.available' />（${money.capitalAmtUnit}）:</span>
                                            <span class="text-success pull-right">
                                            <span id="<c:choose><c:when test="${isVCoin}">usdxAmtBalance</c:when><c:otherwise>btcAmtBalance</c:otherwise></c:choose>"></span>
                                            <span>${money.capitalAmtUnit}</span>
                                        </span>
                                            <br>
                                            <span><%--冻结--%><fmt:message key='spot.C2C.freeze' />（${money.capitalAmtUnit}）:</span>
                                            <span class="text-success pull-right">
                                            <span id="<c:choose><c:when test="${isVCoin}">usdxFrozen</c:when><c:otherwise>btcFrozen</c:otherwise></c:choose>"></span>
                                            <span>${money.capitalAmtUnit}</span>
                                        </span>
                                            <br>
                                            <span><%--负债--%><fmt:message key='spot.C2C.debit' />（${money.capitalAmtUnit}）:</span>
                                            <span class="text-success pull-right">
                                            <span id="<c:choose><c:when test="${isVCoin}">usdxBorrow</c:when><c:otherwise>btcBorrow</c:otherwise></c:choose>"></span>
                                            <span>${money.capitalAmtUnit}</span>
                                        </span>
                                        </div>
                                    </div>
                                    <div class="form-group mb15">
                                        <div class="col-xs-12 ui-form-item">
                                            <input id="priceBuy" name="entrustPrice" class="form-control form-controlC2C" placeholder="<%--买入价格--%><fmt:message key='spot.C2C.buyingPrice' />" data-display="Price" onkeydown="buyKeyDown();">
                                        </div>
                                    </div>
                                    <div class="form-group mb15">
                                        <div class="col-xs-12 ui-form-item">
                                            <input name="entrustAmt" id="buyEntrustAmt" class="form-control form-controlC2C" placeholder="" data-display="Amount" onkeydown="buyKeyDown();">
                                        </div>
                                    </div>
                                    <div class="form-group mb5">
                                        <div class="col-xs-12">
                                            <div id="buyButton" class="btn btn-group-lg btn-block cf btn-primary form-controlC2C"><%--买入--%><fmt:message key='spot.C2C.buy' />&nbsp;${money.tradeAmtUnit}</div>
                                        </div>
                                    </div>
                                    <div class="form-group mb5 clearfix">
                                        <div class="col-xs-12 dataTxt">
                                            <div class="pull-left">
                                                <span><%--限价--%><fmt:message key='spot.C2C.maxPrice' />：</span>
                                                <span class="text-success" id="buyHighestLimitPrice"></span>
                                            </div>
                                            <div class="pull-right">
                                                <span><%--费率--%><fmt:message key='spot.C2C.buyBtcFeeRate' />：</span>
                                                <span class="text-success" id="buyBtcFeeRate"></span>
                                            </div>
                                        </div>
                                    </div>
                                </form:form>
                                <form:form class="form-horizontal col-sm-6 px0 pr5 pl5 bitms-bg1" id="C2Csellform">
                                    <input name="exchangePairMoney" type="hidden" value="${exchangePairMoney}" class="form-control">
                                    <input name="exchangePairVCoin" type="hidden" value="${exchangePairVCoin}" class="form-control">
                                    <input name="entrustType" type="hidden" value="<%=TradeEnums.ENTRUST_X_ENTRUST_TYPE_LIMITPRICE.getCode()%>" class="form-control">
                                    <div class="form-group mb5">
                                        <div class="col-xs-12 dataTxt">
                                            <span><%--可用--%><fmt:message key='spot.C2C.available' />（${money.tradeAmtUnit}）:</span>
                                            <span class="text-danger pull-right">
                                            <span id="<c:choose><c:when test="${isVCoin}">btcAmtBalance</c:when><c:otherwise>usdxAmtBalance</c:otherwise></c:choose>"></span>
                                            <span>${money.tradeAmtUnit}</span>
                                        </span>
                                            <br>
                                            <span><%--冻结--%><fmt:message key='spot.C2C.freeze' />（${money.tradeAmtUnit}）:</span>
                                            <span class="text-danger pull-right" >
                                            <span id="<c:choose><c:when test="${isVCoin}">btcFrozen</c:when><c:otherwise>usdxFrozen</c:otherwise></c:choose>"></span>
                                            <span>${money.tradeAmtUnit}</span>
                                        </span>
                                            <br>
                                            <span><%--负债--%><fmt:message key='spot.C2C.debit' />（${money.tradeAmtUnit}）:</span>
                                            <span class="text-danger pull-right">
                                            <span id="<c:choose><c:when test="${isVCoin}">btcBorrow</c:when><c:otherwise>usdxBorrow</c:otherwise></c:choose>"></span>
                                            <span>${money.tradeAmtUnit}</span>
                                        </span>
                                        </div>
                                    </div>
                                    <div class="form-group mb15">
                                        <div class="col-xs-12 ui-form-item">
                                            <input id="priceSell" name="entrustPrice" class="form-control form-controlC2C" placeholder="<%--卖出价格--%><fmt:message key='spot.C2C.sellingPrice' />" data-display="Price" onkeydown="sellKeyDown();">
                                        </div>
                                    </div>
                                    <div class="form-group mb15">
                                        <div class="col-xs-12 ui-form-item">
                                            <input name="entrustAmt" id="sellEntrustAmt" class="form-control form-controlC2C" placeholder="" data-display="Amount" onkeydown="sellKeyDown();">
                                        </div>
                                    </div>
                                    <div class="form-group mb5">
                                        <div class="col-xs-12">
                                            <div id="sellButton" class="btn btn-group-lg btn-block cf btn-danger form-controlC2C"><%--卖出--%><fmt:message key='spot.C2C.sell' />&nbsp;${money.tradeAmtUnit}</div>
                                        </div>
                                    </div>
                                    <div class="form-group mb5 clearfix">
                                        <div class="col-xs-12 dataTxt">
                                            <div class="pull-left">
                                                <span><%--限价--%><fmt:message key='spot.C2C.minPrice' />：</span>
                                                <span class="text-danger" id="sellLowestLimitPrice"></span>
                                            </div>
                                            <div class="pull-right">
                                                <span><%--费率--%><fmt:message key='spot.C2C.buyBtcFeeRate' />：</span>
                                                <span class="text-danger" id="sellBtcFeeRate"></span>
                                            </div>
                                        </div>
                                    </div>
                                </form:form>
                            </div>
                            <div class="bitms-bg1 p10 pt0 pb0 clearfix" style="padding: 2px;border: 1px solid;border-radius: 2px;">
                                <div class="dataTxt pl5" style="display: inline-block">
                                    <span><%--根据账户权益及市场风控，您还可使用--%><fmt:message key='spot.C2C.quotaTxt1' /></span>
                                    <span class="text-success" style="font-weight: bold">
                                        <span id="usdxQuota"></span>
                                        <span>${money.capitalAmtUnit}</span>
                                        [<span><fmt:formatNumber type="number" value="${money.digitBorrowDayRate*100}" pattern="0.00" maxFractionDigits="2"/>%/Day</span>] <%--利率--%>
                                    </span>
                                    <span><%--或--%><fmt:message key='spot.C2C.and' /></span>
                                    <span class="text-danger" style="font-weight: bold">
                                        <span id="btcQuota"></span>
                                        <span>${money.tradeAmtUnit}</span>
                                        [<span><fmt:formatNumber type="number" value="${money.legalBorrowDayRate*100}" pattern="0.00" maxFractionDigits="2"/>%/Day</span>] <%--利率--%>
                                    </span>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="col-lg-3 clearfix pl5 mt10 mb10">
                        <div class="col-sm-12 bitms-bg1 pb10 dataTxt" <%--style="overflow-y: scroll"--%>>
                            <div class="bitms-c2 clearfix pb5 pt5" style="border-bottom: 1px solid #22333f;font-weight: bold;">
                                <span class="col-xs-4 px0 pl5 text-center"><%--交易对--%><fmt:message key='spot.currencyTrade.transPair' /></span>
                                <span class="col-xs-4 px0 text-right"><%--最新价--%><fmt:message key='spot.C2C.platPrice' /></span>
                                <span class="col-xs-4 px0 pr5 text-right"><%--涨跌幅--%><fmt:message key='spot.C2C.range' /></span>
                            </div>
                            <div id="transPairDiv">

                            </div>
                        </div>
                        <div class="col-sm-12 bitms-bg1 pb10 pt10 C2Ctable mt10 hidden-xs" id="C2Cscroll">
                            <div class="thead tr clearfix">
                                <span class="col-xs-4 bitms-c2" style="text-align: center"><%--时间--%><fmt:message key='time' /></span>
                                <span class="col-xs-4 bitms-c2"><%--价格--%>(${money.capitalAmtSymbol})<fmt:message key='price' /></span>
                                <span class="col-xs-4 bitms-c2"><%--数量--%>(${money.tradeAmtSymbol})<fmt:message key='number' /></span>
                                <%--<span class="col-xs-3 bitms-c2">&lt;%&ndash;方向&ndash;%&gt;<fmt:message key='direction' /></span>--%>
                            </div>
                            <div id="trading">

                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <div class="panel pt0">
                <div class="row">
                    <div class="col-lg-12">
                        <ul class="nav nav-tabs bitms-tabs clearfix">
                            <li class="active">
                                <a href="#panel-293475" id="index_1" data-toggle="tab"><%--当前未成交--%><fmt:message key='spot.C2C.noTransAtPresent' />（<span id="doingCnt">0</span>）</a>
                            </li>
                            <li>
                                <a href="#panel-293475" id="index_2" data-toggle="tab"><%--历史委托--%><fmt:message key='spot.C2C.historyTrans' /></a>
                            </li>
                        </ul>
                        <div class="tab-content">
                            <div class="table-responsive tab-pane active text-center" id="panel-293475">
                                <table id="rowPage" class="table mb10">
                                    <thead>
                                    <tr>
                                        <th><%--委托时间--%><fmt:message key='spot.C2C.entrustedTime' /></th>
                                        <th><%--交易类型--%><fmt:message key='spot.C2C.transTypes' /></th>
                                        <th><%--委托方向--%><fmt:message key='spot.C2C.entrustDirection' /></th>
                                        <th><%--委托价格--%><fmt:message key='spot.C2C.entrustedPrice' />(${money.capitalAmtSymbol})</th>
                                        <th><%--已成交--%><fmt:message key='spot.C2C.transactedNumber' />/<%--委托--%><fmt:message key='spot.C2C.entrustedNumber' />(${money.tradeAmtSymbol})</th>
                                        <th><%--成交均价--%><fmt:message key='spot.C2C.averageTransPrice' />(${money.capitalAmtSymbol})</th>
                                        <th><%--委托来源--%><fmt:message key='spot.C2C.entrustedOrigin' /></th>
                                        <th><%--状态--%><fmt:message key='state' /></th>
                                        <th><%--操作--%><fmt:message key='operation' /></th>
                                    </tr>
                                    </thead>
                                    <tbody id="entrustx_list_emement">

                                    </tbody>
                                </table>
                                <a class="text-success" id="jumpHistory" style="display: none" href="${ctx}/spot/historyEntrust"><%--查看更多--%><fmt:message key='spot.C2C.more' />...</a>
                                <%--<div class="mt10 m010">
                                    <%-- 通用分页 --%>
                                    <div id="entrustx_pagination" class="paginationContainer"></div>
                                </div>--%>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
</body>
<script src="${ctx}/scripts/src/spot/C2CKLine.js"></script>
<script id="trading_tpl" type="text/html">
    {{each msgContent}}
    <div class="tr clearfix">
        <span class="col-xs-4 bitms-c2 text-center" style="text-align: center">{{$formatDate $value.dealTime}}</span>
        <span class="col-xs-4 bitms-c2">{{$value.dealPrice}}</span>
        <span class="col-xs-4 bitms-c2">{{$value.dealAmt}}</span>
        <%--<span class="col-xs-3 bitms-c2 text-center">
            <span class="{{$value.direct=='spotSell'?'text-danger':'text-success'}}">
                {{$value.direct=='spotSell'?'Sell':'Buy'}}
            </span>
        </span>--%>
    </div>
    {{/each}}
</script>

<script id="transPair_tpl" type="text/html">
    {{each msgContent}}
    {{if $value.stockType == 'leveragedSpot'}}
    <div class="transPair bitms-c2 clearfix pt5 pb5" {{$value.id==${money.id}?'':'onclick=jumpUrl("${ctx}/spot/pureSpotTrade?exchangePair='+$value.exchangePair+'")'}} style="border-bottom: 1px solid #22333f;cursor: pointer;">
        <span class="col-xs-4 px0 pl5 text-center highLight" {{$value.id==${money.id}?'style=border-left-color:#98ce3b;':'style=border-left-color:#acadaf;'}}>{{$value.stockName}}</span>
        <span class="col-xs-4 px0 text-right {{$value.upDown=='DOWN'?'text-danger':'text-success'}}">{{$value.platPrice}}</span>
        <span class="col-xs-4 px0 pr5 text-right {{$RangeFlag2 $value.range}}">{{$RangeFlag $value.range}}{{$Fix2Flag $value.range}}%</span>
    </div>
    {{/if}}
    {{/each}}
</script>

<script id="quotation_tpl" type="text/html">
    {{each msgContent}}
    <span class="col-sm-2 col-xs-4 px0 dataTxt">
        <span class="bitms-c2">{{$Fix4Flag $value.vcoinAmtSum24h}}${money.tradeAmtUnit}</span>
        <br>
        <span><%--24小时成交量--%><fmt:message key='spot.C2C.24amt' />&nbsp;</span>
    </span>
    <span class="col-sm-2 col-xs-4 px0 dataTxt">
        <span class="{{$value.upDown=='DOWN'?'text-danger':'text-success'}}">${money.capitalAmtSymbol}{{$value.direct=='spotSell'?''+$value.platPrice+'↓':''+$value.platPrice+'↑'}}</span>
        <br>
        <span><%--最新成交价--%><fmt:message key='spot.C2C.platPrice' />&nbsp;</span>
    </span>
    <span class="col-sm-2 col-xs-4 px0 dataTxt">
        <span class="{{$RangeFlag2 $value.range}}">{{$RangeFlag $value.range}}{{$Fix2Flag $value.range}}%</span>
        <br>
        <span><%--涨跌幅--%><fmt:message key='spot.C2C.range' />&nbsp;</span>
    </span>
    <span class="col-sm-2 col-xs-4 px0 dataTxt">
        <span class="bitms-c2">${money.capitalAmtSymbol}{{$Fix2Flag $value.highestPrice}}</span>
        <br>
        <span><%--最高价--%><fmt:message key='spot.C2C.Highest' />&nbsp;</span>
    </span>
    <span class="col-sm-2 col-xs-4 px0 dataTxt">
        <span class="bitms-c2">${money.capitalAmtSymbol}{{$Fix2Flag $value.lowestPrice}}</span>
        <br>
        <span><%--最低价--%><fmt:message key='spot.C2C.Lowest' />&nbsp;</span>
    </span>
    <span class="col-sm-2 col-xs-4 px0 dataTxt">
        <span class="{{$value.upDownIdx=='DOWN'?'text-danger':'text-success'}}">${money.capitalAmtSymbol}{{$value.upDownIdx=='DOWN'?''+$value.idxAvgPrice+'↓':''+$value.idxAvgPrice+'↑'}}</span>
        <br>
        <span><%--风控基价--%><fmt:message key='spot.C2C.RiskPrice' />&nbsp;</span>
    </span>
    {{/each}}
</script>

<script id="deep_sell_tpl" type="text/html">
    {{each msgContent}}
    {{if $value.direct == 'spotSell' && showLevel == $value.deepLevel}}
    <div class="tr clearfix" style="position: relative;margin-bottom: 2px;" onclick="autoWriteBuy({{$value.entrustPrice}},{{$value.entrustAmtSum}})">
        <div style="position: absolute;top: 0px; bottom: 0px; right: 0px; width:{{$percentFlag $value.entrustAmtSum}}%; border-radius: 2px; background-color: rgba(169,68,66,0.3);"></div>
        <span class="col-xs-2 text-danger" style="text-align: center"><fmt:message key='sell' />{{$value.desc}}</span>
        <span class="col-xs-3 bitms-c2" {{$value.entrustAccountType==1?'style=color:yellow':''}} {{$value.entrustAmt>500?'style=font-weight:bold':''}}>{{$value.entrustPrice}}</span>
        <span class="col-xs-3 bitms-c2" {{$value.entrustAccountType==1?'style=color:yellow':''}} {{$value.entrustAmt>500?'style=font-weight:bold':''}}>{{$value.entrustAmt}}</span>
        <span class="col-xs-4 bitms-c2" {{$value.entrustAccountType==1?'style=color:yellow':''}} {{$value.entrustAmt>500?'style=font-weight:bold':''}}>{{$value.entrustAmtSum}}</span>
    </div>
    {{/if}}
    {{/each}}
</script>
<script id="deep_buy_tpl" type="text/html">
    {{each msgContent}}
    {{if $value.direct == 'spotBuy' && showLevel == $value.deepLevel}}
    <div class="tr clearfix" style="position: relative;margin-bottom: 2px;" onclick="autoWriteSell({{$value.entrustPrice}},{{$value.entrustAmtSum}})">
        <div style="position: absolute; top: 0px; bottom: 0px; right: 0px; width:{{$percentFlag $value.entrustAmtSum}}%; border-radius: 2px; background-color: rgba(100,130,65,0.3);"></div>
        <span class="col-xs-2 text-success" style="text-align: center"><fmt:message key='buy' />{{$value.desc}}</span>
        <span class="col-xs-3 bitms-c2" {{$value.entrustAccountType==1?'style=color:yellow':''}} {{$value.entrustAmt>500?'style=font-weight:bold':''}}>{{$value.entrustPrice}}</span>
        <span class="col-xs-3 bitms-c2" {{$value.entrustAccountType==1?'style=color:yellow':''}} {{$value.entrustAmt>500?'style=font-weight:bold':''}}>{{$value.entrustAmt}}</span>
        <span class="col-xs-4 bitms-c2" {{$value.entrustAccountType==1?'style=color:yellow':''}} {{$value.entrustAmt>500?'style=font-weight:bold':''}}>{{$value.entrustAmtSum}}</span>
    </div>
    {{/if}}
    {{/each}}
</script>

<script id="entrust_doing_list_tpl" type="text/html">
    {{each rows}}
    <tr class="test">
        <td>{{$formatDateTime $value.entrustTime}}</td>
        <td>{{$statusFlag $value.tradeType}}</td>
        <td>{{$statusFlag $value.entrustDirect}}</td>
        <%--td>{{$statusFlag $value.entrustType}}</td>--%>
        <td>{{$Fix8Flag $value.entrustPrice}}</td>
        <td>{{$Fix4Flag $value.dealAmt}}/{{$Fix4Flag $value.entrustAmt}}</td>
        <td>{{$avgFlag $value.entrustDirect,$value.dealAmt,$value.dealBalance,$value.dealFee}}</td>
        <td>{{$value.entrustSource}}</td>
        <td>{{$statusFlag $value.status}}</td>
        <td>{{$cancalActionFlag $value.id}}</td>
    </tr>
    {{/each}}
</script>

<script id="entrust_done_list_tpl" type="text/html">
    {{each rows}}
    <tr class="test">
        <td>{{$formatDateTime $value.entrustTime}}</td>
        <td>{{$statusFlag $value.tradeType}}</td>
        <td>{{$statusFlag $value.entrustDirect}}</td>
        <%--<td>{{$statusFlag $value.entrustType}}</td>--%>
        <td>{{$Fix8Flag $value.entrustPrice}}</td>
        <td>{{$Fix4Flag $value.dealAmt}}/{{$Fix4Flag $value.entrustAmt}}</td>
        <td>{{$avgFlag $value.entrustDirect,$value.dealAmt,$value.dealBalance,$value.dealFee}}</td>
        <td>{{$value.entrustSource}}</td>
        <td>{{$statusFlag $value.status}}</td>
        <td>{{$viewActionFlag $value.id}}</td>
    </tr>
    {{/each}}
</script>

<script id="realdealx_list_tpl" type="text/html">
    {{each rows}}
    <tr class="test">
        <td>{{$formatDateTime $value.dealTime}}</td>
        <td>{{$status2Flag $value.entrustDirect}}</td>
        <td>{{$Fix4Flag $value.dealAmt}}</td>
        <td>{{$Fix8Flag $value.dealPrice}}</td>
        <td>{{$Fix4Flag $value.dealBalance}}</td>
        <td>{{$feeFlag $value.entrustDirect,$value.buyFee,$value.sellFee,$value.buyFeeType,$value.sellFeeType}}{{$value.stockCode}}</td>
    </tr>
    {{/each}}
</script>

<script>
    var ws = null; //websocket对象
    var wsAllRtQuotation = null;
    var url = null; //访问地址
    var urlAllRtQuotation = null;
    var lineName = "1m";//K线提示名
    var level = 0;//深度
    var myChart = null;
    var deepData = null;
    var validator;
    var reader = {readAs: function(type,blob,cb){var r = new FileReader();r.onloadend = function(){if(typeof(cb) === 'function') {cb.call(r,r.result);}};try{r['readAs'+type](blob);}catch(e){}}};
    seajs.use(['pagination','validator','template', 'moment', 'sockjs','reconnection'], function (Pagination,Validator,Template, moment) {
        $('.pageLoader').hide();
        myChart = echarts.init(document.getElementById("bit_market"));
        validator = new Validator();

        template.helper('$formatDateTime', function (millsec) {
            return moment(millsec).format("YYYY-MM-DD HH:mm:ss.SSS");
        });
        template.helper('$formatDate', function (millsec) {
            return moment(millsec).format("HH:mm:ss");
        });
        template.helper('$Fix2Flag', function(flag) {
            return  parseFloat((flag)).toFixed(2);
        });
        template.helper('$percentFlag', function(flag) {
            if(flag < 0){
                flag = 0;
            }
            if(flag > 100){
                flag = 100;
            }
            return  parseFloat(flag).toFixed(2);
        });
        template.helper('$Fix4Flag', function(flag) {
            return  parseFloat((flag)).toFixed(4);
        });
        template.helper('$Fix8Flag', function(flag) {
            return  parseFloat((flag)).toFixed(8);
        });
        template.helper('$avgFlag', function(direact,dealAmt,dealBalance,fee) {
            if(direact == '<%=TradeEnums.ENTRUST_DEAL_DIRECT_SPOT_BUY.getCode()%>')
            {
                if(dealAmt>0)
                {
                    //return  (parseFloat(dealBalance)/parseFloat(dealAmt-fee)).toFixed(2);
                    return  (parseFloat(dealBalance)/parseFloat(dealAmt)).toFixed(8);
                }
                else
                {
                    return "-";
                }
            }
            else if(direact == '<%=TradeEnums.ENTRUST_DEAL_DIRECT_SPOT_SELL.getCode()%>')
            {
                if(dealAmt>0)
                {
                    return  (parseFloat(dealBalance)/parseFloat(dealAmt)).toFixed(8);
                    //return  (parseFloat(dealBalance-fee)/parseFloat(dealAmt)).toFixed(2);
                }
                else
                {
                    return "-";
                }
            }

        });
        template.helper('$statusFlag', function(flag) {
            return  getDictValueByCode(flag);
        });
        template.helper('$cancalActionFlag', function(id) {
            return  "<a class='text-success' onclick=\"doCancel('"+id+"')\"><%--撤单--%><fmt:message key='spot.C2C.cancel' /></a>";
        });
        template.helper('$viewActionFlag', function(id) {
            return  "<a class='text-success' onclick=\"doView('"+id+"')\"><%--明细--%><fmt:message key='spot.C2C.view' /></a>";
        });
        template.helper('$RangeFlag', function(flag) {
            if(flag >= 0){
                return "+";
            }
            else {
                return "";
            }
        });
        template.helper('$RangeFlag2', function(flag) {
            if(flag >= 0){
                return "text-success";
            }
            else {
                return "text-danger";
            }
        });
        <% if (BitmsConst.RUNNING_ENVIRONMONT.equals("production")){ %>
        if (window.location.protocol == 'http:') {
            url = 'ws://socket.bitms.com' + "${money.webSocketUrl}";
        } else {
            url = 'wss://socket.bitms.com' + "${money.webSocketUrl}";
        }
        <% }else{ %>
        if (window.location.protocol == 'http:') {
            url = 'ws://' + window.location.host + "${money.webSocketUrl}";
        } else {
            url = 'wss://' + window.location.host + "${money.webSocketUrl}";
        }
        <% } %>

        if ('WebSocket' in window) {
            ws = new ReconnectingWebSocket(url);
            wsAllRtQuotation = new ReconnectingWebSocket(urlAllRtQuotation);
        } else {
            ws = new SockJS(url);
            wsAllRtQuotation = new SockJS(urlAllRtQuotation);
        }

        ws.onmessage = function (event) {
            var blob = event.data;
            reader.readAs('Text',blob.slice(0,blob.size,'text/plain;charset=UTF-8'),function(result){
                var message = JSON.parse(result);
                var msgType = message.msgType;
                if (msgType == '<%=InQuotationConsts.MESSAGE_TYPE_REALDEAL%>') {// deal
                    renderDeal(message);
                }
                else if (msgType == '<%=InQuotationConsts.MESSAGE_TYPE_DEEPPRICE%>') {// deep
                    renderDeep(message);
                }
                else if(msgType == '<%=InQuotationConsts.MESSAGE_TYPE_RTQUOTATION%>'){ //quotation
                    renderQuotation(message);
                }
                else {// kline
                    renderKline(message);
                }
            });
        };

        wsAllRtQuotation.onmessage = function (event) {
            var blob = event.data;
            reader.readAs('Text',blob.slice(0,blob.size,'text/plain;charset=UTF-8'),function(result){
                var message = JSON.parse(result);
                renderAllRtQuotation(message);
            });
        };

        function renderAllRtQuotation(message) {
            var html = Template.render("transPair_tpl", message);
            $("#transPairDiv").html(html);
        }

        function renderDeal(message) {
            var html = Template.render("trading_tpl", message);
            $("#trading").html(html);
        }

        function renderQuotation(message) {
            var html = Template.render("quotation_tpl", message);
            $("#quotation").html(html);
        }

        function renderDeep(message) {
            message.showLevel = level;
            deepData = message;
            var deep_sell = Template.render("deep_sell_tpl", deepData);
            var deep_buy = Template.render("deep_buy_tpl", deepData);
            $("#deep_sell").html(deep_sell);
            $("#deep_buy").html(deep_buy);
        }

        //绑定K线时段
        $("#kLineTopic li").click(function () {
            if (ws != null) {
                lineName = $(this).attr("tips");
                var topic = $(this).attr("data");
                ws.send("{\"topic\":\"" + topic + "\"}");
            }
        });

        //绑定深度时段
        $("#deepLevel li").click(function () {
            level = $(this).attr("data");
            if(deepData != null){
                deepData.showLevel = level;
                var deep_sell = Template.render("deep_sell_tpl", deepData);
                var deep_buy = Template.render("deep_buy_tpl", deepData);
                $("#deep_sell").html(deep_sell);
                $("#deep_buy").html(deep_buy);
            }
        });

        myChart.setOption({
            tooltip: {trigger: 'axis', axisPointer: {animation: false, type: 'cross',
                lineStyle: {color: '#376df4', width: 2, opacity: 1}}},
            xAxis: {type: 'category', data: [], axisLine: {lineStyle: {color: '#8392A5'}}},
            yAxis: {scale: true, axisLine: {lineStyle: {color: '#8392A5'}}, splitLine: {show: false}},
            grid: {left: '0%',bottom: '5%',top: '5%',right: '2%',containLabel: true,show: true,borderColor: "#999"},
            dataZoom: {type: 'inside',start: 90, end: 100, minSpan: 3, maxSpan: 50},
            animation: false,
            textStyle: {color: '#999'}
        });

        window.onresize = function () {
            myChart.resize();
        };

        //k线图收缩显示
        $('#C2CKlineDiv').on("click", function() {
            $('#C2CKline').fadeToggle();
            myChart.resize();
        });
    });
</script>
</html>