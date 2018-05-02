<%@ page import="com.blocain.bitms.quotation.consts.InQuotationConsts" %>
<%@ page import="com.blocain.bitms.trade.trade.enums.TradeEnums" %>
<%@ page import="com.blocain.bitms.tools.consts.BitmsConst" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="/global/header.jsp" %>
<%@ include file="/global/setup_ajax.jsp" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<html>
<body>
<div class="container">
    <%--头部--%>
    <%@ include file="/global/topNavBar.jsp" %>
    <%--代码开始--%>
    <div class="row">
        <form method="post" action="/spot/leveragedSpotTrade" id="jumpForm">
            <input type="hidden" id="jumpId" name="exchangePairMoney" value="${money.id}"/>
        </form>
        <div class="col-sm-12 column">
            <div class="panel pb5">
                <div class="row visible-xs-block">
                    <div class="col-xs-12 p10 pt0">
                        <img style="margin-right:3px;width:30px;height:30px;vertical-align: bottom;"
                             src="${imagesPath}/coinLogo/${money.tradeAmtUnit}.svg">
                        <span class="fs22" style="font-weight: bold">${money.stockName}</span>
                    </div>
                </div>
                <div class="row hidden-xs">
                    <div class="col-lg-12">
                        <div id="C2CKlineDiv" class="bitms-bg1 bitms-c2 col-lg-12 clearfix p5"
                             style="cursor: pointer;border-bottom: 1px solid #23333f">
                            <span class="pl10 glyphicon glyphicon-chevron-down">&nbsp;<%--行情图表--%><fmt:message
                                    key='spot.C2C.quotationChart'/></span>
                        </div>
                        <div id="C2CKline" class="clearfix col-lg-12 bitms-hide">
                            <ul id="kLineTopic" class="col-xs-12 nav nav-tabs bitms-tabs bitms-c2c-tabs mt10">
                                <li tips="1m" data="${money.topicKline1m}" class="active"><a data-toggle="tab">1m</a>
                                </li>
                                <li tips="5m" data="${money.topicKline5m}"><a data-toggle="tab">5m</a></li>
                                <li tips="15m" data="${money.topicKline15m}"><a data-toggle="tab">15m</a></li>
                                <li tips="30m" data="${money.topicKline30m}"><a data-toggle="tab">30m</a></li>
                                <li tips="60m" data="${money.topicKlineHour}"><a data-toggle="tab">1h</a></li>
                                <li tips="1d" data="${money.topicKlineDay}"><a data-toggle="tab">1d</a></li>
                                <%--<li tips="周线" data="${money.topicKlineWeek}"><a data-toggle="tab">周线</a></li>--%>
                                <%--<li tips="月线" data="${money.topicKlineMonth}"><a data-toggle="tab">月线</a></li>--%>
                            </ul>
                            <%--K线图--%>
                            <div id="bit_market" style="height: 250px;margin-top: 40px">

                                <div class="tranloader">
                                    <span></span><span></span><span></span><span></span><span></span></div>

                            </div>
                        </div>
                    </div>
                </div>
                <div class="row">
                    <div class="col-lg-9 px0">
                        <div class="col-lg-12 clearfix pr5 mt10 mb10 hidden-xs">
                            <div class="bitms-bg1 p5 pl10 clearfix">
                                <div class="col-sm-2 px0" style="line-height: 40px;border-right: 1px solid #22333f">
                                    <a id="drop4" href="#" class="dropdown-toggle bitms-c2" style="cursor: default"
                                       data-toggle="dropdown" role="button" aria-haspopup="true" aria-expanded="true">
                                        <img style="margin-right:3px;width: 30px;height: 30px;"
                                             src="${imagesPath}/coinLogo/${money.tradeAmtUnit}.svg">
                                        <span style="font-weight: bold">${money.stockName}</span>
                                        <%--<span class="dataTxt" style="padding: 0px 2px;border-radius: 2px;color: #1e222d;background-color: #87CEEB">&lt;%&ndash;杠杆&ndash;%&gt;<fmt:message key='spot.C2C.margin' /></span>--%>
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
                                    <div class="tranloader" style="top: 50px;">
                                        <span></span><span></span><span></span><span></span><span></span>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="col-lg-5 clearfix pr5 mb10">
                            <div class="col-sm-12 bitms-bg1 C2Ctable pt10 pb10 pr15" id="C2CbuySellLeveraged">
                                <div class="thead tr clearfix" style="margin-bottom: 5px;">
                                    <span class="col-sm-2 col-xs-4 bitms-c2" style="text-align: center"><%--买卖--%>
                                    <fmt:message key='spot.C2C.buySell'/></span>
                                    <span class="col-sm-3 col-xs-4 bitms-c2"><%--价格--%>(${money.capitalAmtSymbol})<fmt:message key='price'/></span>
                                    <span class="col-sm-3 col-xs-4 bitms-c2"><%--数量--%>(${money.tradeAmtSymbol})<fmt:message key='number'/></span>
                                    <span class="col-sm-4 hidden-xs bitms-c2"><%--累计--%>(${money.tradeAmtSymbol})<fmt:message key='spot.C2C.cumulative'/></span>
                                </div>
                                <div id="deep_sell">
                                    <div class="tranloader">
                                        <span></span><span></span><span></span><span></span><span></span>
                                    </div>
                                </div>
                                <hr id="deepHrLeveraged">
                                <div id="deep_buy">
                                    <div class="tranloader">
                                        <span></span><span></span><span></span><span></span><span></span>
                                    </div>
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
                            <div class="bitms-bg1 p10 pb0 clearfix">
                                <div class="col-sm-12 px0 mb10 dataTxt clearfix bitms-c2" style="font-weight:bold;border-bottom: 1px solid #22333f;padding-bottom: 10px!important;">
                                    <div class="col-xs-6 px0 pr5 clearfix">
                                        <span class="pull-left"><%--钱包账户余额--%><fmt:message key='spot.C2C.walletAccountBalance'/>：</span>
                                        <span class="text-success pull-right">BTC</span>
                                        <span class="text-success pull-right pr5"><fmt:formatNumber value="${walletAsset.amount}" pattern="#,##0.0000" /></span>
                                    </div>
                                    <div class="col-xs-6 px0 pl5 clearfix text-right">
                                        <a class="pull-left" style="border-bottom: 0.1px solid #87CEEB;color: #87CEEB;" href="${ctx}/fund/accountAsset"><%--账户划转--%><fmt:message key='spot.C2C.conversion'/></a>
                                        <a class="pull-left ml5" style="border-bottom: 0.1px solid #87CEEB;color: #87CEEB;" href="${ctx}/fund/withdraw"><%--提现--%><fmt:message key='spot.C2C.withdraw' /></a>
                                        <a class="pull-left ml5" style="border-bottom: 0.1px solid #87CEEB;color: #87CEEB;margin-right: 5px;" href="${ctx}/fund/charge"><%--充值--%><fmt:message key='spot.C2C.deposit' /></a>
                                        <div class="dataTxt px0" style="display: inline-block;margin-top: 2px;">
                                            <span id="autoBorrowText"><fmt:message key='${autoBorrow eq 1?"spot.C2C.open":"spot.C2C.close"}'/></span>
                                            <input type="checkbox" ${autoBorrow eq 1?'checked':''} id="autoBorrow"
                                                   class="chooseBtn"/>
                                            <label for="autoBorrow" class="choose-label"></label>
                                        </div>
                                    </div>
                                </div>
                                <div class="col-sm-12 dataTxt px0 mb10 clearfix bitms-c2" style="font-weight:bold;border-bottom: 1px solid #22333f;padding-bottom: 10px!important;" id="datatxtDiv1">
                                    <div class="col-xs-6 px0 pr5 text-left" style="display: inline-block">
                                        <span class="pull-left"><%--交易账户净值--%><fmt:message key='spot.C2C.contractAccountBalance'/>：</span>
                                        <span class="text-success pull-right">BTC</span>
                                        <span class="text-success pull-right pr5" id="btcNetValue"></span>
                                    </div>
                                    <div class="col-xs-6 px0 pl5 text-center" style="display: inline-block">
                                        <span class="pull-left" style="color:#87CEEB;"><%--预估强平--%><fmt:message key='spot.C2C.explosionPrice'/>：$<span id="explosionPrice"></span></span>
                                        <span class="pull-right" id="direction" style="background-color:#59743a;display: inline-block;padding: 0px 2px;border-radius: 2px;color: #151922;"></span>
                                        <%--<span class="pull-right" id="riskRate" style="margin-right:5px;background-color:#59743a;display: inline-block;padding: 0px 2px;border-radius: 2px;color: #151922;"></span>--%>
                                        <%--<span class="text-success pull-right pr5" id="explosionPrice"></span>--%>
                                    </div>
                                </div>
                                <form:form class="form-horizontal col-sm-6 px0 pr5 pl5 bitms-bg1" id="C2Cbuyform">
                                    <input name="exchangePairMoney" type="hidden" value="${exchangePairMoney}"
                                           class="form-control">
                                    <input name="exchangePairVCoin" type="hidden" value="${exchangePairVCoin}"
                                           class="form-control">
                                    <input name="entrustType" type="hidden"
                                           value="<%=TradeEnums.ENTRUST_X_ENTRUST_TYPE_LIMITPRICE.getCode()%>"
                                           class="form-control">
                                    <div class="form-group mb5">
                                        <div class="col-xs-12 dataTxt">
                                            <span><%--可用--%><fmt:message key='spot.C2C.available'/>（${money.capitalAmtUnit}）:</span>
                                            <span class="text-success pull-right">
                                            <span id="<c:choose><c:when test="${isVCoin}">usdxAmtBalance</c:when><c:otherwise>btcAmtBalance</c:otherwise></c:choose>"></span>
                                            <span>${money.capitalAmtUnit}</span>
                                        </span>
                                            <br>
                                            <span><%--冻结--%><fmt:message key='spot.C2C.freeze'/>（${money.capitalAmtUnit}）:</span>
                                            <span class="text-success pull-right">
                                            <span id="<c:choose><c:when test="${isVCoin}">usdxFrozen</c:when><c:otherwise>btcFrozen</c:otherwise></c:choose>"></span>
                                            <span>${money.capitalAmtUnit}</span>
                                        </span>
                                            <br>
                                            <span><%--负债--%><fmt:message key='spot.C2C.debit'/>（${money.capitalAmtUnit}）:</span>
                                            <span class="text-success pull-right">
                                            <span id="<c:choose><c:when test="${isVCoin}">usdxBorrow</c:when><c:otherwise>btcBorrow</c:otherwise></c:choose>"></span>
                                            <span>${money.capitalAmtUnit}</span>
                                        </span>
                                            <br>
                                            <span><%--可借--%><fmt:message key='spot.C2C.credit'/>（${money.capitalAmtUnit}）:<%--<span class="glyphicon glyphicon-question-sign pl5" title="&lt;%&ndash;利率&ndash;%&gt;<fmt:message key='spot.C2C.LendingRate' />：<fmt:formatNumber type="number" value="${money.legalBorrowDayRate*100}" pattern="0.00" maxFractionDigits="2"/>%/Day"></span>--%></span>
                                            <span class="text-success pull-right">
                                            <span id="usdxQuota"></span>
                                            <span>${money.capitalAmtUnit}</span>
                                        </span>
                                        </div>
                                    </div>
                                    <div class="form-group mb15">
                                        <div class="col-xs-12 ui-form-item">
                                            <input id="priceBuy" name="entrustPrice"
                                                   class="form-control form-controlC2C"
                                                   placeholder="<%--买入价格--%><fmt:message key='spot.C2C.buyingPrice' />"
                                                   data-display="Price" onkeydown="buyKeyDown();">
                                        </div>
                                    </div>
                                    <div class="form-group mb15">
                                        <div class="col-xs-12 ui-form-item">
                                            <input name="entrustAmt" id="buyEntrustAmt"
                                                   class="form-control form-controlC2C" placeholder=""
                                                   data-display="Amount" onkeydown="buyKeyDown();">
                                        </div>
                                    </div>
                                    <div class="form-group mb5">
                                        <div class="col-xs-12">
                                            <div id="buyButton"
                                                 class="btn btn-group-lg btn-block cf btn-primary form-controlC2C"><%--买入--%>
                                                <fmt:message key='spot.C2C.buy'/>&nbsp;${money.tradeAmtUnit}</div>
                                        </div>
                                    </div>
                                    <div class="form-group mb5 clearfix">
                                        <div class="col-xs-12 dataTxt">
                                            <div class="pull-left">
                                                <span><%--限价--%><fmt:message key='spot.C2C.maxPrice'/>：</span>
                                                <span class="text-success" id="buyHighestLimitPrice"></span>
                                            </div>
                                            <div class="pull-right">
                                                <span><%--费率--%><fmt:message key='spot.C2C.buyBtcFeeRate'/>：</span>
                                                <span class="text-success" id="buyBtcFeeRate"></span>
                                            </div>
                                        </div>
                                    </div>
                                </form:form>
                                <form:form class="form-horizontal col-sm-6 px0 pr5 pl5 bitms-bg1" id="C2Csellform">
                                    <input name="exchangePairMoney" type="hidden" value="${exchangePairMoney}"
                                           class="form-control">
                                    <input name="exchangePairVCoin" type="hidden" value="${exchangePairVCoin}"
                                           class="form-control">
                                    <input name="entrustType" type="hidden"
                                           value="<%=TradeEnums.ENTRUST_X_ENTRUST_TYPE_LIMITPRICE.getCode()%>"
                                           class="form-control">
                                    <div class="form-group mb5">
                                        <div class="col-xs-12 dataTxt">
                                            <span><%--可用--%><fmt:message key='spot.C2C.available'/>（${money.tradeAmtUnit}）:</span>
                                            <span class="text-danger pull-right">
                                            <span id="<c:choose><c:when test="${isVCoin}">btcAmtBalance</c:when><c:otherwise>usdxAmtBalance</c:otherwise></c:choose>"></span>
                                            <span>${money.tradeAmtUnit}</span>
                                        </span>
                                            <br>
                                            <span><%--冻结--%><fmt:message key='spot.C2C.freeze'/>（${money.tradeAmtUnit}）:</span>
                                            <span class="text-danger pull-right">
                                            <span id="<c:choose><c:when test="${isVCoin}">btcFrozen</c:when><c:otherwise>usdxFrozen</c:otherwise></c:choose>"></span>
                                            <span>${money.tradeAmtUnit}</span>
                                        </span>
                                            <br>
                                            <span><%--负债--%><fmt:message key='spot.C2C.debit'/>（${money.tradeAmtUnit}）:</span>
                                            <span class="text-danger pull-right">
                                            <span id="<c:choose><c:when test="${isVCoin}">btcBorrow</c:when><c:otherwise>usdxBorrow</c:otherwise></c:choose>"></span>
                                            <span>${money.tradeAmtUnit}</span>
                                        </span>
                                            <br>
                                            <span><%--可借--%><fmt:message key='spot.C2C.credit'/>（${money.tradeAmtUnit}）:<%--<span class="glyphicon glyphicon-question-sign pl5" title="&lt;%&ndash;利率&ndash;%&gt;<fmt:message key='spot.C2C.LendingRate' />：<fmt:formatNumber type="number" value="${money.digitBorrowDayRate*100}" pattern="0.00" maxFractionDigits="2"/>%/Day"></span>--%></span>
                                            <span class="text-danger pull-right">
                                            <span id="btcQuota"></span>
                                            <span>${money.tradeAmtUnit}</span>
                                        </span>
                                        </div>
                                    </div>
                                    <div class="form-group mb15">
                                        <div class="col-xs-12 ui-form-item">
                                            <input id="priceSell" name="entrustPrice"
                                                   class="form-control form-controlC2C"
                                                   placeholder="<%--卖出价格--%><fmt:message key='spot.C2C.sellingPrice' />"
                                                   data-display="Price" onkeydown="sellKeyDown();">
                                        </div>
                                    </div>
                                    <div class="form-group mb15">
                                        <div class="col-xs-12 ui-form-item">
                                            <input name="entrustAmt" id="sellEntrustAmt"
                                                   class="form-control form-controlC2C" placeholder=""
                                                   data-display="Amount" onkeydown="sellKeyDown();">
                                        </div>
                                    </div>
                                    <div class="form-group mb5">
                                        <div class="col-xs-12">
                                            <div id="sellButton"
                                                 class="btn btn-group-lg btn-block cf btn-danger form-controlC2C"><%--卖出--%>
                                                <fmt:message key='spot.C2C.sell'/>&nbsp;${money.tradeAmtUnit}</div>
                                        </div>
                                    </div>
                                    <div class="form-group mb5 clearfix">
                                        <div class="col-xs-12 dataTxt">
                                            <div class="pull-left">
                                                <span><%--限价--%><fmt:message key='spot.C2C.minPrice'/>：</span>
                                                <span class="text-danger" id="sellLowestLimitPrice"></span>
                                            </div>
                                            <div class="pull-right">
                                                <span><%--费率--%><fmt:message key='spot.C2C.buyBtcFeeRate'/>：</span>
                                                <span class="text-danger" id="sellBtcFeeRate"></span>
                                            </div>
                                        </div>
                                    </div>
                                </form:form>
                                <div class="col-sm-12 px0 mb5">
                                    <div class="clearfix dataTxt text-danger" style="border:1px solid #a94442;border-radius:2px;padding:2px;" role="alert">
                                        <span class="glyphicon glyphicon-warning-sign mr5 pl5"></span>
                                        <span><%--数字资产交易存在相当的风险，您应仔细考虑并完全清楚该风险。--%><fmt:message key='spot.C2C.tip'/></span>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="col-lg-3 clearfix pl5 mt10 mb10">
                        <div id="premiumPanel" class="col-sm-12 bitms-bg1 pb10 dataTxt" style="background-color: rgba(100,130,65,0.5);color: #bbb;padding:10px;border-radius:4px;">
                            <div class="clearfix pb5" style="border-bottom: 1px solid #22333f;font-weight: bold;">
                                <span class="col-xs-4 text-center px0"><%--溢价--%><fmt:message key='spot.C2C.premium'/></span>
                                <span class="col-xs-4 text-center px0"><%--溢价率--%><fmt:message key='spot.C2C.premiumRate'/></span>
                                <span class="col-xs-4 text-center px0"><%--调节方向--%><fmt:message key='spot.C2C.premiumDirection'/></span>
                            </div>
                            <div id="transPairDivLeveraged" class="C2Cscroll" style="height: auto">

                            </div>
                            <div class="mt5">
                                <p style="margin-bottom: 5px;"><%--溢价费按每天0时溢价为准进行调节：--%><fmt:message key='spot.C2C.premiumTxt1'/></p>
                                <p style="margin-bottom: 5px;"><%--当溢价<-3%时，空头向多头支付；当溢价[-3%~3%]时，无溢价费；当溢价>3%时，多头向空头支付；--%><fmt:message key='spot.C2C.premiumTxt2'/></p>
                                <p style="margin-bottom: 0;"><%--溢价费=USD持仓量*0.1%--%><fmt:message key='spot.C2C.premiumTxt3'/></p>
                            </div>
                        </div>
                        <div class="col-sm-12 bitms-bg1 pb10 pt10 C2Ctable mt10 hidden-xs">
                            <div class="thead tr clearfix pb5"
                                 style="border-bottom: 1px solid #22333f;font-weight: bold;">
                                <span class="col-xs-4 bitms-c2" style="text-align: center"><%--时间--%><fmt:message key='time'/></span>
                                <span class="col-xs-4 bitms-c2" style="padding-right: 10px"><%--价格--%>(${money.capitalAmtSymbol})<fmt:message key='price'/></span>
                                <span class="col-xs-4 bitms-c2" style="padding-right: 10px"><%--数量--%>(${money.tradeAmtSymbol})<fmt:message key='number'/></span>
                                <%--<span class="col-xs-3 bitms-c2">&lt;%&ndash;方向&ndash;%&gt;<fmt:message key='direction' /></span>--%>
                            </div>
                            <div id="tradingLeveraged" class="C2Cscroll">
                                <div class="tranloader">
                                    <span></span><span></span><span></span><span></span><span></span>
                                </div>
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
                                <a href="#panel-293475" id="index_1" data-toggle="tab"><%--当前未成交--%><fmt:message key='spot.C2C.noTransAtPresent'/>（<span id="doingCnt">0</span>）</a>
                            </li>
                            <li>
                                <a href="#panel-293475" id="index_2" data-toggle="tab"><%--历史委托--%><fmt:message key='spot.C2C.historyTrans'/></a>
                            </li>
                        </ul>
                        <div class="tab-content">
                            <div class="table-responsive tab-pane active text-center" id="panel-293475">
                                <table id="rowPage" class="table mb10">
                                    <thead>
                                    <tr>
                                        <th class="hidden-xs"><%--委托时间--%><fmt:message key='spot.C2C.entrustedTime'/></th>
                                        <th class="hidden-xs"><%--交易类型--%><fmt:message key='spot.C2C.transTypes'/></th>
                                        <th><%--委托方向--%><fmt:message key='spot.C2C.entrustDirection'/></th>
                                        <th><%--委托价格--%><fmt:message key='spot.C2C.entrustedPrice'/></th>
                                        <th><%--已成交--%><fmt:message key='spot.C2C.transactedNumber'/>/<%--委托--%><fmt:message key='spot.C2C.entrustedNumber'/></th>
                                        <th class="hidden-xs"><%--成交均价--%><fmt:message key='spot.C2C.averageTransPrice'/></th>
                                        <th class="hidden-xs"><%--委托来源--%><fmt:message key='spot.C2C.entrustedOrigin'/></th>
                                        <th class="hidden-xs"><%--状态--%><fmt:message key='state'/></th>
                                        <th><%--操作--%><fmt:message key='operation'/></th>
                                    </tr>
                                    </thead>
                                    <tbody id="entrustx_list_emement">

                                    </tbody>
                                </table>
                                <a class="text-success" id="jumpHistory" style="display: none"
                                   href="${ctx}/spot/historyEntrust"><%--查看更多--%><fmt:message key='spot.C2C.more'/>...</a>
                                <%--<div class="mt10 m010">
                                    <%-- 通用分页 --%>
                                <div id="entrustx_pagination" class="paginationContainer"></div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
</div>
<div class="modal fade" id="viewEntrustVCoinMoney" tabindex="-1" role="dialog">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span>
                </button>
                <h4 class="modal-title text-success"><%--成交记录--%><fmt:message key='spot.C2C.transactedRecord'/></h4>
            </div>
            <div class="modal-body table-responsive" id="viewEntrustVCoinMoneyBody">
                <table id="rowPage2" class="table">
                    <thead>
                    <tr>
                        <th><%--成交时间--%><fmt:message key='spot.C2C.transactedTime'/></th>
                        <th><%--成交方向--%><fmt:message key='spot.C2C.transactedDerict'/></th>
                        <th><%--成交数量--%><fmt:message key='future.entrust.transactionNumber'/></th>
                        <th><%--成交价格--%><fmt:message key='spot.C2C.transactedPrice'/></th>
                        <th><%--成交金额--%><fmt:message key='spot.C2C.transactedAmount'/></th>
                        <th><%--手续费--%><fmt:message key='fee'/></th>
                    </tr>
                    </thead>
                    <tbody id="realdealx_list_emement">

                    </tbody>
                </table>
                <div class="mt10 m010">
                    <%-- 通用分页 --%>
                    <div id="realdealx_pagination" class="paginationContainer"></div>
                </div>
            </div>
        </div>
    </div>
</div>
<div class="modal fade" id="borrowbRule" tabindex="-1" role="dialog">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span>
                </button>
                <h4 class="modal-title text-success"><%--借贷规则--%><fmt:message key='spot.C2C.debitTitle'/></h4>
            </div>
            <div class="modal-body table-responsive" id="borrowbRuleBody">
                <p><%--在您开启借贷功能之前请务必知晓以下内容：--%><fmt:message key='spot.C2C.debitTxt0'/></p>
                <p><%--1.借贷功能开启后，您的下单金额若超出可用部分，在额度范围内会自动向系统借入。--%><fmt:message key='spot.C2C.debitTxt1'/></p>
                <p><%--2.账户发生风险时，交易账户总资产/借款金额≤110%，将采取减仓、平仓等风控操作。--%><fmt:message key='spot.C2C.debitTxt2'/></p>
                <p><%--3.计息方式为每日新加坡时间零时进行一次负债计息；--%><fmt:message key='spot.C2C.debitTxt3'/></p>
                <p><%--4.委托中的订单产生的债务以及当日借出并当日归还的债务不计息；--%><fmt:message key='spot.C2C.debitTxt4'/></p>
                <div class="col-sm-12 text-center">
                    <div id="autoBorrowConfirm" class="btn btn-md btn-primary"><%--我同意并知晓以上事项--%><fmt:message
                            key='spot.C2C.debitSubimt'/></div>
                </div>
            </div>
        </div>
    </div>
</div>
</body>
<script src="${ctx}/scripts/gallery/echarts/echarts.js"></script>
<script src="${ctx}/scripts/src/spot/C2CKLine.js"></script>
<script id="trading_tpl" type="text/html">
    {{each msgContent}}
    <div class="tr clearfix">
        <span class="col-xs-4 bitms-c2 text-center" style="text-align: center">{{$formatDate $value.dealTime}}</span>
        <span class="col-xs-4 bitms-c2" style="padding-right: 10px">{{$value.dealPrice}}</span>
        <span class="col-xs-4 bitms-c2" style="padding-right: 10px">{{$value.dealAmt}}</span>
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
    <div class="transPair bitms-c2 clearfix pt5 pb5"
         {{$value.id==${money.id}?'':'onclick=jumpUrl("${ctx}/spot/pureSpotTrade?exchangePair='+$value.exchangePair+'")'}}
         style="border-bottom: 1px solid #22333f;cursor: pointer;">
        <span class="col-xs-4 px0 pl5 text-center highLight"
              {{$value.id==${money.id}?'style=border-left-color:#98ce3b;':'style=border-left-color:#acadaf;'}}>{{$value.stockName}}</span>
        <span class="col-xs-4 text-right {{$value.upDown=='DOWN'?'text-danger':'text-success'}}"
              style="padding-right: 10px">{{$value.platPrice}}</span>
        <span class="col-xs-4 text-right {{$RangeFlag2 $value.range}}" style="padding-right: 10px">{{$RangeFlag $value.range}}{{$Fix2Flag $value.range}}%</span>
    </div>
    {{/if}}
    {{/each}}
</script>

<script id="quotation_tpl" type="text/html">
    {{each msgContent}}
    <span class="col-sm-2 col-xs-4 px0 dataTxt">
        <span class="bitms-c2">{{$Fix4Flag $value.vcoinAmtSum24h}}${money.tradeAmtUnit}</span>
        <br>
        <span><%--24小时成交量--%><fmt:message key='spot.C2C.24amt'/>&nbsp;</span>
    </span>
    <span class="col-sm-2 col-xs-4 px0 dataTxt">
        <span class="{{$value.upDown=='DOWN'?'text-danger':'text-success'}}">${money.capitalAmtSymbol}{{$value.direct=='spotSell'?''+$value.platPrice+'↓':''+$value.platPrice+'↑'}}</span>
        <br>
        <span><%--最新成交价--%><fmt:message key='spot.C2C.platPrice'/>&nbsp;</span>
    </span>
    <span class="col-sm-2 col-xs-4 px0 dataTxt">
        <span class="{{$RangeFlag2 $value.range}}">{{$RangeFlag $value.range}}{{$Fix2Flag $value.range}}%</span>
        <br>
        <span><%--涨跌幅--%><fmt:message key='spot.C2C.range'/>&nbsp;</span>
    </span>
    <span class="col-sm-2 col-xs-4 px0 dataTxt">
        <span class="bitms-c2">${money.capitalAmtSymbol}{{$Fix2Flag $value.highestPrice}}</span>
        <br>
        <span><%--最高价--%><fmt:message key='spot.C2C.Highest'/>&nbsp;</span>
    </span>
    <span class="col-sm-2 col-xs-4 px0 dataTxt">
        <span class="bitms-c2">${money.capitalAmtSymbol}{{$Fix2Flag $value.lowestPrice}}</span>
        <br>
        <span><%--最低价--%><fmt:message key='spot.C2C.Lowest'/>&nbsp;</span>
    </span>
    <span class="col-sm-2 col-xs-4 px0 dataTxt">
        <span class="{{$value.upDownIdx=='DOWN'?'text-danger':'text-success'}}">${money.capitalAmtSymbol}{{$value.upDownIdx=='DOWN'?''+$value.idxAvgPrice+'↓':''+$value.idxAvgPrice+'↑'}}</span>
        <br>
        <span><%--风控基价--%><fmt:message key='spot.C2C.RiskPrice'/>&nbsp;</span>
    </span>
    {{/each}}
</script>

<script id="quotation2_tpl" type="text/html">
    {{each msgContent}}
        <div class="clearfix pt5 pb5" style="border-bottom:1px solid #22333f;">
            <span class="col-xs-4 text-center px0">{{$value.premium}}</span>
            <span class="col-xs-4 text-center px0">{{$Fix2Flag $value.premiumRate*100}}%</span>
            <span class="col-xs-4 text-center px0">{{$flagPremiumFee $value.premiumRate}}</span>
        </div>
    {{/each}}
</script>

<script id="deep_sell_tpl" type="text/html">
    {{each msgContent}}
    {{if $value.direct == 'spotSell' && showLevel == $value.deepLevel}}
    <div class="tr clearfix" style="position: relative;margin-bottom: 3px;" onclick="autoWriteBuy({{$value.entrustPrice}},{{$value.entrustAmtSum}})">
        <div style="position:absolute;top:0px;bottom:0px;right:0px;width:{{$percentFlag $value.entrustAmtSum*100/${money.entrustAccumDenom}}}%;border-radius:2px;background-color:rgba(169,68,66,0.3);"></div>
        <span class="col-sm-2 col-xs-4 text-danger" style="text-align: center"><fmt:message
                key='sell'/>{{$value.desc}}</span>
        <span class="col-sm-3 col-xs-4 bitms-c2" {{$value.entrustAccountType==1?'style=color:yellow':''}}
              {{$value.entrustAmt>500?'style=font-weight:bold':''}}>{{$value.entrustPrice}}</span>
        <span class="col-sm-3 col-xs-4 bitms-c2" {{$value.entrustAccountType==1?'style=color:yellow':''}}
              {{$value.entrustAmt>500?'style=font-weight:bold':''}}>{{$value.entrustAmt}}</span>
        <span class="col-sm-4 hidden-xs bitms-c2" {{$value.entrustAccountType==1?'style=color:yellow':''}}
              {{$value.entrustAmt>500?'style=font-weight:bold':''}}>{{$value.entrustAmtSum}}</span>
    </div>
    {{/if}}
    {{/each}}
</script>
<script id="deep_buy_tpl" type="text/html">
    {{each msgContent}}
    {{if $value.direct == 'spotBuy' && showLevel == $value.deepLevel}}
    <div class="tr clearfix" style="position:relative;margin-bottom: 3px;" onclick="autoWriteSell({{$value.entrustPrice}},{{$value.entrustAmtSum}})">
        <div style="position:absolute;top:0px;bottom:0px;right:0px;width:{{$percentFlag $value.entrustAmtSum*100/${money.entrustAccumDenom}}}%;border-radius:2px;background-color:rgba(100,130,65,0.3);"></div>
        <span class="col-sm-2 col-xs-4 text-success" style="text-align: center"><fmt:message key='buy'/>{{$value.desc}}</span>
        <span class="col-sm-3 col-xs-4 bitms-c2" {{$value.entrustAccountType==1?'style=color:yellow':''}}
              {{$value.entrustAmt>500?'style=font-weight:bold':''}}>{{$value.entrustPrice}}</span>
        <span class="col-sm-3 col-xs-4 bitms-c2" {{$value.entrustAccountType==1?'style=color:yellow':''}}
              {{$value.entrustAmt>500?'style=font-weight:bold':''}}>{{$value.entrustAmt}}</span>
        <span class="col-sm-4 hidden-xs bitms-c2" {{$value.entrustAccountType==1?'style=color:yellow':''}}
              {{$value.entrustAmt>500?'style=font-weight:bold':''}}>{{$value.entrustAmtSum}}</span>
    </div>
    {{/if}}
    {{/each}}
</script>

<script id="entrust_doing_list_tpl" type="text/html">
    {{each rows}}
    <tr class="test">
        <td class="hidden-xs">{{$formatDateTime $value.entrustTime}}</td>
        <td class="hidden-xs">{{$statusFlag $value.tradeType}}</td>
        <td>{{$statusFlag $value.entrustDirect}}</td>
        <%--td>{{$statusFlag $value.entrustType}}</td>--%>
        <td>{{$Fix8Flag $value.entrustPrice}}</td>
        <td>{{$Fix4Flag $value.dealAmt}}/{{$Fix4Flag $value.entrustAmt}}</td>
        <td class="hidden-xs">{{$avgFlag $value.entrustDirect,$value.dealAmt,$value.dealBalance,$value.dealFee}}</td>
        <td class="hidden-xs">{{$value.entrustSource}}</td>
        <td class="hidden-xs">{{$doingStatusFlag $value.status}}</td>
        <td>{{$cancalActionFlag $value.id}}</td>
    </tr>
    {{/each}}
</script>

<script id="entrust_done_list_tpl" type="text/html">
    {{each rows}}
    <tr class="test">
        <td class="hidden-xs">{{$formatDateTime $value.entrustTime}}</td>
        <td class="hidden-xs">{{$statusFlag $value.tradeType}}</td>
        <td>{{$statusFlag $value.entrustDirect}}</td>
        <%--<td>{{$statusFlag $value.entrustType}}</td>--%>
        <td>{{$Fix8Flag $value.entrustPrice}}</td>
        <td>{{$Fix4Flag $value.dealAmt}}/{{$Fix4Flag $value.entrustAmt}}</td>
        <td class="hidden-xs">{{$avgFlag $value.entrustDirect,$value.dealAmt,$value.dealBalance,$value.dealFee}}</td>
        <td class="hidden-xs">{{$value.entrustSource}}</td>
        <td class="hidden-xs">{{$statusFlag $value.status}}</td>
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
    var flag_deal = false;
    var flag_deep = false;
    var flag_rtquotation = false;
    var flag_allQuotation = false;
    var flag_kline = false;

    var deepTopic = "${money.topicEntrustDeepprice}";
    var dealTopic = "${money.topicRealdealTransaction}";
    var rtQuotationTopic = "${money.topicRtquotationPrice}";
    var allQuotationTopic = "allRtQuotation";
    var kline1mTopic = "${money.topicKline1m}";

    var ws = null;
    <%--websocket对象--%>
    var url = null;
    <%--访问地址--%>
    var lineName = "1m";
    <%--K线提示名--%>
    var level = 0;
    <%--深度--%>
    var myChart = null;
    var deepData = null;
    var validator;
    var renderEntrustxOnHistory;
    var renderEntrustxOnDoing;
    var tab_index = 1;
    var reader = {
        readAs: function (type, blob, cb) {
            var r = new FileReader();
            r.onloadend = function () {
                if (typeof(cb) === 'function') {
                    cb.call(r, r.result);
                }
            };
            try {
                r['readAs' + type](blob);
            } catch (e) {
            }
        }
    };
    seajs.use(['pagination', 'validator', 'template', 'moment', 'sockjs', 'reconnection'], function (Pagination, Validator, Template, moment) {

        <%--判断币对是否可交易--%>
        if (${money.canTrade == 'no'}) {
            $("body").append('<div class="alert alert-danger" role="alert" style="position:absolute;width:200px;top:300px;left:50%;margin-left:-100px;font-size:18px;background-color:#e7c3c3;background-image:none;">Suspend Trading</div>')
        }

        myChart = echarts.init(document.getElementById("bit_market"));
        validator = new Validator();

        template.helper('$formatDateTime', function (millsec) {
            return moment(millsec).format("YYYY-MM-DD HH:mm:ss.SSS");
        });
        template.helper('$formatDate', function (millsec) {
            return moment(millsec).format("HH:mm:ss");
        });
        template.helper('$Fix2Flag', function (flag) {
            return parseFloat((flag)).toFixed(2);
        });
        template.helper('$percentFlag', function (flag) {
            if (flag < 0) {
                flag = 0;
            }
            if (flag > 100) {
                flag = 100;
            }
            return parseFloat(flag).toFixed(2);
        });
        template.helper('$Fix4Flag', function (flag) {
            return parseFloat((flag)).toFixed(4);
        });
        template.helper('$Fix8Flag', function (flag) {
            return parseFloat((flag)).toFixed(8);
        });
        template.helper('$avgFlag', function (direact, dealAmt, dealBalance, fee) {
            if (direact == '<%=TradeEnums.ENTRUST_DEAL_DIRECT_SPOT_BUY.getCode()%>') {
                if (dealAmt > 0) {
                    <%--return  (parseFloat(dealBalance)/parseFloat(dealAmt-fee)).toFixed(2);--%>
                    return (parseFloat(dealBalance) / parseFloat(dealAmt)).toFixed(2);
                }
                else {
                    return "-";
                }
            }
            else if (direact == '<%=TradeEnums.ENTRUST_DEAL_DIRECT_SPOT_SELL.getCode()%>') {
                if (dealAmt > 0) {
                    return (parseFloat(dealBalance) / parseFloat(dealAmt)).toFixed(2);
                    <%--return  (parseFloat(dealBalance-fee)/parseFloat(dealAmt)).toFixed(2);--%>
                }
                else {
                    return "-";
                }
            }

        });
        template.helper('$statusFlag', function (flag) {
            return getDictValueByCode(flag);
        });
        template.helper('$doingStatusFlag', function (flag) {
            if(flag == 'init')flag = 'noDeal';
            return getDictValueByCode(flag);
        });
        template.helper('$cancalActionFlag', function (id) {
            return "<a class='text-success' onclick=\"doCancel('" + id + "')\"><%--撤单--%><fmt:message key='spot.C2C.cancel' /></a>";
        });
        template.helper('$viewActionFlag', function (id) {
            return "<a class='text-success' onclick=\"doView('" + id + "')\"><%--明细--%><fmt:message key='spot.C2C.view' /></a>";
        });
        template.helper('$RangeFlag', function (flag) {
            if (flag >= 0) {
                return "+";
            }
            else {
                return "";
            }
        });
        template.helper('$RangeFlag2', function (flag) {
            if (flag >= 0) {
                return "text-success";
            }
            else {
                return "text-danger";
            }
        });
        template.helper('$flagPremiumFee', function (flag) {
            if (flag < -0.01) {
                return "<span style='display:inline-block;padding:0px 2px;border-radius:2px;color:rgb(21, 25, 34);background-color:rgb(100, 130, 65);'>Long</span><span class='glyphicon glyphicon-arrow-left'></span><span style='display:inline-block;padding:0px 2px;border-radius:2px;color:rgb(21, 25, 34);background-color:rgb(169, 68, 66);'>Short</span>";
            }
            else if(flag >= -0.01 && flag <= 0.01){
                return "<span class='glyphicon glyphicon-ban-circle'></span>";
            }
            else{
                return "<span style='display:inline-block;padding:0px 2px;border-radius:2px;color:rgb(21, 25, 34);background-color:rgb(100, 130, 65);'>Long</span><span class='glyphicon glyphicon-arrow-right'></span><span style='display:inline-block;padding:0px 2px;border-radius:2px;color:rgb(21, 25, 34);background-color:rgb(169, 68, 66);'>Short</span>";
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
        } else {
            ws = new SockJS(url);
        }

        ws.onmessage = function (event) {
            var blob = event.data;
            reader.readAs('Text', blob.slice(0, blob.size, 'text/plain;charset=UTF-8'), function (result) {
                var message = JSON.parse(result);
                var msgType = message.msgType;
                if (msgType == '<%=InQuotationConsts.MESSAGE_TYPE_REALDEAL%>') {
                    <%--deal--%>
                    renderDeal(message);
                    flag_deal = true;
                }
                else if (msgType == '<%=InQuotationConsts.MESSAGE_TYPE_DEEPPRICE%>') {
                    <%--deep--%>
                    renderDeep(message);
                    flag_deep = true;
                }
                else if (msgType == '<%=InQuotationConsts.MESSAGE_TYPE_RTQUOTATION%>') {
                    <%--quotation--%>
                    renderQuotation(message);
                    flag_rtquotation = true;
                }
                <%--
                else if (msgType == '<%=InQuotationConsts.MESSAGE_TYPE_ALLRTQUOTATION%>') {
                    //wsAllRtQuotation
                    renderAllRtQuotation(message);
                    flag_allQuotation = true;
                }
                --%>
                else if (msgType == '<%=InQuotationConsts.MESSAGE_TYPE_KLINE%>'){
                    <%--kline--%>
                    renderKline(message);
                    flag_kline = true;
                }
            });

        };

        //轮询行情是否为空
        window.setInterval(function () {

            if (! flag_rtquotation) {
                ws.send("{\"topic\":\"" + rtQuotationTopic + "\"}");
            }
            if (! flag_deal) {
                ws.send("{\"topic\":\"" + dealTopic + "\"}");
            }
            if (! flag_deep) {
                ws.send("{\"topic\":\"" + deepTopic + "\"}");
            }
            <%--
            if (! flag_allQuotation) {
                ws.send("{\"topic\":\"" + allQuotationTopic + "\"}");
            }
            --%>
            if (! flag_kline) {
                ws.send("{\"topic\":\"" + kline1mTopic + "\"}");
            }
        }, 3000);

        <%--
        function renderAllRtQuotation(message) {
            var html = Template.render("transPair_tpl", message);
            $("#transPairDivLeveraged").html(html);
        }
        --%>

        function renderDeal(message) {
            var html = Template.render("trading_tpl", message);
            $("#tradingLeveraged").html(html);
            timerFunc();
        }

        function renderQuotation(message) {
            var html = Template.render("quotation_tpl", message);
            $("#quotation").html(html);

            var html2 = Template.render("quotation2_tpl", message);
            $("#transPairDivLeveraged").html(html2);

            <%--最高买价、最低卖价--%>
            if (message.msgContent[0].buyHighestLimitPrice != null) {
                $("#buyHighestLimitPrice").text(parseFloat(message.msgContent[0].buyHighestLimitPrice).toFixed(2));
            }
            if (message.msgContent[0].sellLowestLimitPrice != null) {
                $("#sellLowestLimitPrice").text(parseFloat(message.msgContent[0].sellLowestLimitPrice).toFixed(2));
            }
        }

        function renderDeep(message) {
            message.showLevel = level;
            deepData = message;
            var deep_sell = Template.render("deep_sell_tpl", deepData);
            var deep_buy = Template.render("deep_buy_tpl", deepData);
            $("#deep_sell").html(deep_sell);
            $("#deep_buy").html(deep_buy);
        }

        <%--绑定K线时段--%>
        $("#kLineTopic li").click(function () {
            if (ws != null) {
                lineName = $(this).attr("tips");
                var topic = $(this).attr("data");
                ws.send("{\"topic\":\"" + topic + "\"}");
            }
        });

        <%--绑定深度时段--%>
        $("#deepLevel li").click(function () {
            level = $(this).attr("data");
            if (deepData != null) {
                deepData.showLevel = level;
                var deep_sell = Template.render("deep_sell_tpl", deepData);
                var deep_buy = Template.render("deep_buy_tpl", deepData);
                $("#deep_sell").html(deep_sell);
                $("#deep_buy").html(deep_buy);
            }
        });

        myChart.setOption({
            tooltip: {
                trigger: 'axis', axisPointer: {
                    animation: false, type: 'cross',
                    lineStyle: {color: '#376df4', width: 2, opacity: 1}
                }
            },
            xAxis: {type: 'category', data: [], axisLine: {lineStyle: {color: '#8392A5'}}, show: false},
            yAxis: {scale: true, axisLine: {lineStyle: {color: '#8392A5'}, show: false}, splitLine: {show: false}},
            grid: {left: '-5%', bottom: '5%', top: '5%', right: '0%', containLabel: true},
            dataZoom: {type: 'inside', start: 90, end: 100, moveOnMouseMove: false, zoomOnMouseWheel: false},
            animation: false,
            textStyle: {color: '#999'}
        });

        window.onresize = function () {
            myChart.resize();
        };

        <%--k线图收缩显示--%>
        $('#C2CKlineDiv').on("click", function () {
            $('#C2CKline').fadeToggle();
            myChart.resize();
        });

        <%--买入--%>
        $("#buyButton").on("click", function () {
            var minbuyprice = (1 / (Math.pow(10, ${money.buyPricePrecision}))).toFixed(${money.buyPricePrecision});
            var minbuyamt = (1 / (Math.pow(10, ${money.buyAmountPrecision}))).toFixed(${money.buyAmountPrecision});
            validator.destroy();
            validator = new Validator({
                element: '#C2Cbuyform',
                autoSubmit: false, <%--当验证通过后不自动提交--%>
                onFormValidated: function (error, results, element) {
                    if (!error) {
                        $.ajax({
                            url: '${ctx}/spot/matchTrade/doMatchBuy',
                            type: 'post',
                            data: element.serialize(),
                            beforeSend: function () {
                                $("#buyButton").attr("disabled", true);
                            },
                            success: function (data, textStatus, jqXHR) {
                                $('#C2Cbuyform').find('input[name="csrf"]').val(jqXHR.getResponseHeader("csrf"));
                                data = JSON.parse(data);
                                if (data.code == bitms.success) {
                                    remind(remindType.success, data.message, 100);
                                    $("#C2Cbuyform input").not(':button, :submit, :reset, :hidden').each(function () {
                                        $(this).val('');
                                    });
                                } else {
                                    if (data.object != null) {
                                        if (data.object.length == 1) {
                                            remind(remindType.error, data.message.replace('{0}', parseFloat((data.object[0])).toFixed(${money.sellPricePrecision})), 1000);
                                        }
                                        else if (data.object.length == 2) {
                                            var msg = data.message.replace('{0}', parseFloat((data.object[0])).toFixed(${money.sellPricePrecision}));
                                            msg = msg.replace('{1}', parseFloat((data.object[1])).toFixed(${money.sellPricePrecision}));
                                            remind(remindType.error, msg, 1000);
                                        }
                                        else {
                                            remind(remindType.error, data.message, 1000);
                                        }
                                    } else {
                                        remind(remindType.error, data.message, 1000);
                                    }
                                    $("#C2Cbuyform input").not(':button, :submit, :reset, :hidden').each(function () {
                                        $(this).val('');
                                    });
                                }
                                $('#index_' + tab_index).click();
                                timerFunc();
                                window.setTimeout(function(){timerFunc();},5000);
                            },
                            complete: function () {
                                $("#buyButton").attr("disabled", false);
                            }
                        });
                    }
                }
            }).addItem({
                element: '#C2Cbuyform [name=entrustPrice]',
                required: true,
                rule: 'number min{min:' + minbuyprice + '} max{max:999999} numberOfDigits{maxLength:${money.buyPricePrecision}}'
            }).addItem({
                element: '#C2Cbuyform [name=entrustAmt]',
                required: true,
                rule: 'number min{min:' + minbuyamt + '} max{max:999999} numberOfDigits{maxLength:${money.buyAmountPrecision}}'
            }).addItem({
                element: '#C2Cbuyform [name=entrustType]',
                required: true
            });
            $("#C2Cbuyform").submit();
        });
        <%--卖出--%>
        $("#sellButton").on("click", function () {
            var minsellprice = (1 / (Math.pow(10, ${money.sellPricePrecision}))).toFixed(${money.sellPricePrecision});
            var minsellamt = (1 / (Math.pow(10, ${money.sellAmountPrecision}))).toFixed(${money.sellAmountPrecision});
            validator.destroy();
            validator = new Validator({
                element: '#C2Csellform',
                autoSubmit: false, <%--当验证通过后不自动提交--%>
                onFormValidated: function (error, results, element) {
                    if (!error) {
                        $.ajax({
                            url: '${ctx}/spot/matchTrade/doMatchSell',
                            type: 'post',
                            data: element.serialize(),
                            beforeSend: function () {
                                $("#sellButton").attr("disabled", true);
                            },
                            success: function (data, textStatus, jqXHR) {
                                $('#C2Csellform').find('input[name="csrf"]').val(jqXHR.getResponseHeader("csrf"));
                                data = JSON.parse(data);
                                if (data.code == bitms.success) {
                                    remind(remindType.success, data.message, 100);
                                    $("#C2Csellform input").not(':button, :submit, :reset, :hidden').each(function () {
                                        $(this).val('');
                                    });
                                } else {
                                    {
                                        if (data.object != null) {
                                            if (data.object.length == 1) {
                                                remind(remindType.error, data.message.replace('{0}', parseFloat((data.object[0])).toFixed(${money.sellPricePrecision})), 1000);
                                            }
                                            else if (data.object.length == 2) {
                                                var msg = data.message.replace('{0}', parseFloat((data.object[0])).toFixed(${money.sellPricePrecision}));
                                                msg = msg.replace('{1}', parseFloat((data.object[1])).toFixed(${money.sellPricePrecision}));
                                                remind(remindType.error, msg, 1000);
                                            }
                                            else {
                                                remind(remindType.error, data.message, 1000);
                                            }
                                        } else {
                                            remind(remindType.error, data.message, 1000);
                                        }
                                    }
                                    $("#C2Csellform input").not(':button, :submit, :reset, :hidden').each(function () {
                                        $(this).val('');
                                    });
                                }
                                $('#index_' + tab_index).click();
                                timerFunc();
                                window.setTimeout(function(){timerFunc();},5000);
                            },
                            complete: function () {
                                $("#sellButton").attr("disabled", false);
                            }
                        });
                    }
                }
            }).addItem({
                element: '#C2Csellform [name=entrustPrice]',
                required: true,
                rule: 'number min{min:' + minsellprice + '} max{max:999999} numberOfDigits{maxLength:${money.sellPricePrecision}}'
            }).addItem({
                element: '#C2Csellform [name=entrustAmt]',
                required: true,
                rule: 'number min{min:' + minsellamt + '} max{max:999999} numberOfDigits{maxLength:${money.sellAmountPrecision}}'
            }).addItem({
                element: '#C2Csellform [name=entrustType]',
                required: true
            });
            $("#C2Csellform").submit();
        });

        $("#index_1").click(function () {
            tab_index = 1;
            renderEntrustxOnDoing = new Pagination({
                url: "${ctx}/spot/matchTrade/entrustxOnDoing",
                data: {
                    exchangePairMoney:${exchangePairMoney},
                    exchangePairVCoin:${exchangePairVCoin},
                    entrustType: '<%=TradeEnums.ENTRUST_X_ENTRUST_TYPE_LIMITPRICE.getCode()%>'
                },
                rows: 100,
                method: "get",
                handleData: function (json) {
                    $("#doingCnt").text(json.total);
                    var html = Template.render("entrust_doing_list_tpl", json);
                    $("#entrustx_list_emement").html(html);
                    $("#jumpHistory").hide();
                }
            });
        });
        $("#index_2").click(function () {
            tab_index = 2;
            renderEntrustxOnHistory = new Pagination({
                url: "${ctx}/spot/matchTrade/entrustxOnHistory",
                data: {
                    noPage: 'yes',
                    exchangePairMoney:${exchangePairMoney},
                    exchangePairVCoin:${exchangePairVCoin},
                    entrustType: '<%=TradeEnums.ENTRUST_X_ENTRUST_TYPE_LIMITPRICE.getCode()%>'
                },
                rows: 3,
                method: "get",
                handleData: function (json) {
                    var html = Template.render("entrust_done_list_tpl", json);
                    $("#entrustx_list_emement").html(html);
                    $("#jumpHistory").show();
                }
            });
        });

        $("#autoBorrow").click(function () {
            if ($("#autoBorrow").get(0).checked) {
                $('#borrowbRule').modal('show');
                $("#autoBorrow").get(0).checked = false;
            }
            else {
                autoBorrow();
            }

        });
        $("#autoBorrowConfirm").click(function () {
            $("#autoBorrow").get(0).checked = true;
            autoBorrow();
        });

        <%--定时器实时获取数据--%>
        getData();
        renderEntrustxOnDoing = new Pagination({
            url: "${ctx}/spot/matchTrade/entrustxOnDoing",
            data: {
                exchangePairMoney:${exchangePairMoney},
                exchangePairVCoin:${exchangePairVCoin},
                entrustType: '<%=TradeEnums.ENTRUST_X_ENTRUST_TYPE_LIMITPRICE.getCode()%>'
            },
            rows: 100,
            method: "get",
            handleData: function (json) {
                $("#doingCnt").text(json.total);
                var html = Template.render("entrust_doing_list_tpl", json);
                $("#entrustx_list_emement").html(html);
            }
        });
        <%--var t1 = window.setInterval(timerFunc, 1000);--%>
    });

    <%--借贷开关按钮--%>
    function autoBorrow() {
        $.ajax({
            cache: true,
            type: 'POST',
            url: "${ctx}/account/setting/changeBorrowSwitch",
            data: {autoDebit: ($("#autoBorrow").get(0).checked ? 1 : 0)},
            async: false,
            success: function (data, textStatus, jqXHR) {
                $('#csrf-form').find('input[name="csrf"]').val(jqXHR.getResponseHeader("csrf"));
                setCsrfToken("csrf-form");
                data = JSON.parse(data);
                if (data.code == bitms.success) {
                    $("#autoBorrowText").text($("#autoBorrow").get(0).checked ? '<fmt:message key='spot.C2C.open'/>' : '<fmt:message key='spot.C2C.close'/>');
                    remind(remindType.success, data.message, 300);
                    <%--重新获取最大可买可卖--%>
                    getData();
                } else {
                    $("#autoBorrow").get(0).checked = ($("#autoBorrow").get(0).checked ? false : true);
                    if (data.object != null) {
                        remind(remindType.error, "Operation failed bcause of existing debts!", 1000);
                    }
                    else {
                        remind(remindType.error, data.message, 1000);
                    }
                }
                $('#borrowbRule').modal('hide');
            }
        });
    }

    <%--中止我发起的委托操作--%>
    function doCancel(id) {
        $.ajax({
            cache: true,
            type: 'POST',
            url: "${ctx}/spot/matchTrade/doMatchCancel",
            data: {entrustId: id, exchangePairMoney:${exchangePairMoney}, exchangePairVCoin:${exchangePairVCoin}},
            async: false,
            beforeSend: function () {
                $(this).attr("disabled", true);
            },
            success: function (data, textStatus, jqXHR) {
                $('#csrf-form').find('input[name="csrf"]').val(jqXHR.getResponseHeader("csrf"));
                setCsrfToken("csrf-form");
                data = JSON.parse(data);
                if (data.code == bitms.success) {
                    remind(remindType.success, data.message, 300);
                } else {
                    remind(remindType.error, data.message, 300);
                }
                $("#index_1").click();
                timerFunc();
                window.setTimeout(function(){timerFunc();},5000);
            },
            complete: function () {
                $(this).attr("disabled", false);
            }
        });
    }

    <%--查看成交情况--%>
    function doView(id) {
        var renderRecivePage;
        seajs.use(['pagination', 'template', 'moment'], function (Pagination, Template, moment) {
            renderRecivePage = new Pagination({
                url: "${ctx}/spot/matchTrade/realDealByEntrustVCoinMoneyId",
                elem: "#realdealx_pagination",
                data: {id: id, exchangePairMoney:${exchangePairMoney}, exchangePairVCoin:${exchangePairVCoin}},
                rows: 10,
                method: "get",
                handleData: function (json) {
                    var html = Template.render("realdealx_list_tpl", json);
                    $("#realdealx_list_emement").html(html);
                }
            });

            template.helper('$formatDateTime', function (millsec) {
                return moment(millsec).format("YYYY-MM-DD HH:mm:ss.SSS");
            });
            template.helper('$formatDate', function (millsec) {
                return moment(millsec).format("HH:mm:ss");
            });
            template.helper('$Fix2Flag', function (flag) {
                return parseFloat((flag)).toFixed(2);
            });
            template.helper('$Fix4Flag', function (flag) {
                return parseFloat((flag)).toFixed(4);
            });
            template.helper('$status2Flag', function (flag) {
                return getDictValueByCode(flag);
            });
            template.helper('$feeFlag', function (entrustDirect, buyFee, sellFee, buyFeeType, sellFeeType) {
                if (entrustDirect == '<%=TradeEnums.ENTRUST_DEAL_DIRECT_SPOT_BUY.getCode()%>') {
                    <%--成交方买入委托方是卖出方--%>
                    return parseFloat((buyFee)).toFixed(8);
                }
                if (entrustDirect == '<%=TradeEnums.ENTRUST_DEAL_DIRECT_SPOT_SELL.getCode()%>') {
                    <%--成交方卖出委托方是买入方--%>
                    return parseFloat((sellFee)).toFixed(8);
                }
                return '--';
            });
        });

        $('#viewEntrustVCoinMoney').modal('toggle');
    }

    function timerFunc() {
        if (tab_index == 1) {
            renderEntrustxOnDoing.render();
        }
        $('.reg-pop').remove();
        getData();
    }

    function getData() {
        $.ajax({
            url: '${ctx}/spot/leveragedSpotTrade/getAccountFundAsset',
            data: {exchangePairMoney:${exchangePairMoney}, exchangePairVCoin:${exchangePairVCoin}},
            type: 'get',
            success: function (data, textStatus, jqXHR) {
                data = JSON.parse(data);
                $("#btcNetValue").text(parseFloat(data.object.btcNetValue).toFixed(4));
                $("#explosionPrice").text(parseFloat(data.object.explosionPrice).toFixed(2));
                $("#btcAmtBalance").text(parseFloat(data.object.btcAmount - data.object.btcFrozen).toFixed(4));
                $("#usdxAmtBalance").text(parseFloat(data.object.usdxAmount - data.object.usdxFrozen).toFixed(2));
                $("#btcFrozen").text(parseFloat(data.object.btcFrozen).toFixed(4));
                $("#usdxFrozen").text(parseFloat(data.object.usdxFrozen).toFixed(2));
                $("#btcBorrow").text(toFiexFloat(data.object.btcBorrow, 4));
                $("#usdxBorrow").text(toFiexFloat(data.object.usdxBorrow, 2));
                $("#sellEntrustAmt").attr("placeholder", "<%--最大可卖--%><fmt:message key='spot.C2C.sellingQuantity' /> " + parseFloat(data.object.btcSellMaxCnt).toFixed(4));
                $("#buyEntrustAmt").attr("placeholder", "<%--最大可买--%><fmt:message key='spot.C2C.buyingQuantity' /> " + parseFloat(data.object.btcBuyMaxCnt).toFixed(4));

                $("#btcQuota").text(parseFloat(data.object.btcMaxBorrow - (data.object.btcAmount - data.object.btcFrozen)).toFixed(4));
                var value = parseFloat(data.object.btcBuyMaxCntBalance - (data.object.usdxAmount - data.object.usdxFrozen)).toFixed(2);
                $("#usdxQuota").text(value > 0 ? value : '0.00');

                $("#sellBtcFeeRate").text(parseFloat(data.object.sellBtcFeeRate).toFixed(2) + '%');
                $("#buyBtcFeeRate").text(parseFloat(data.object.buyBtcFeeRate).toFixed(2) + '%');

                <%--方向--%>
                if (data.object.direction == 'None') {
                    $("#direction").text("<%--无仓--%><fmt:message key='spot.C2C.none' />[$0.00]");
                    $("#direction").css('background-color', '#777777');
                }
                else if (data.object.direction == 'Short') {
                    $("#direction").text("<%--空头--%><fmt:message key='spot.C2C.short' />[$"+(data.object.usdxAmount-data.object.usdxBorrow).toFixed(2)+"]");
                    $("#direction").css('background-color', '#a94442');
                }
                else if (data.object.direction == 'Long') {
                    $("#direction").text("<%--多头--%><fmt:message key='spot.C2C.long' />["+(data.object.usdxBorrow-data.object.usdxAmount).toFixed(2)+"]");
                    $("#direction").css('background-color', '#648241');
                }

                <%--风险率--%>
                if (parseFloat(data.object.riskRate).toFixed(2) == 0) {
                    $("#riskRate").text("<%--安全--%><fmt:message key='spot.C2C.security' />");
                    $("#riskRate").css('background-color', '#648241');
                }
                else if (0 < parseFloat(data.object.riskRate).toFixed(2) && parseFloat(data.object.riskRate).toFixed(2) <= 0.2) {
                    $("#riskRate").text("<%--低险--%><fmt:message key='spot.C2C.lowRisk' />");
                    $("#riskRate").css('background-color', '#777777');
                }
                else if (0.2 < parseFloat(data.object.riskRate).toFixed(2) && parseFloat(data.object.riskRate).toFixed(2) <= 0.5) {
                    $("#riskRate").text("<%--预警--%><fmt:message key='spot.C2C.warning' />");
                    $("#riskRate").css('background-color', '#FFA500');
                }
                else {
                    $("#riskRate").text("<%--危险--%><fmt:message key='spot.C2C.danger' />");
                    $("#riskRate").css('background-color', '#a94442');
                }

            }
        });
    }

    function getCntOfEntrusting() {
        $.ajax({
            url: '${ctx}/spot/matchTrade/entrustxOnDoing',
            data: {
                exchangePairMoney:${exchangePairMoney},
                exchangePairVCoin:${exchangePairVCoin},
                entrustType: '<%=TradeEnums.ENTRUST_X_ENTRUST_TYPE_LIMITPRICE.getCode()%>'
            },
            type: 'get',
            success: function (data, textStatus, jqXHR) {
                data = JSON.parse(data);
                $("#doingCnt").text(data.total);
            }
        });
    }

    <%--回车键绑定登录按钮--%>
    function buyKeyDown() {
        var theEvent = window.event || arguments.callee.caller.arguments[0];
        var code = theEvent.keyCode;
        if (code == 13) {
            theEvent.returnValue = false;
            theEvent.cancel = true;
            $('#buyButton').click();
        }
    }

    function sellKeyDown() {
        var theEvent = window.event || arguments.callee.caller.arguments[0];
        var code = theEvent.keyCode;
        if (code == 13) {
            theEvent.returnValue = false;
            theEvent.cancel = true;
            $('#sellButton').click();
        }
    }

    <%--自动填充--%>
    function autoWriteBuy(price, amt) {
        $("#priceBuy").val(price.toFixed(${money.buyPricePrecision}));
        $("#buyEntrustAmt").val(amt.toFixed(${money.buyAmountPrecision}));
    }

    function autoWriteSell(price, amt) {
        $("#priceSell").val(price.toFixed(${money.sellPricePrecision}));
        $("#sellEntrustAmt").val(amt.toFixed(${money.sellAmountPrecision}));
    }
</script>
</html>