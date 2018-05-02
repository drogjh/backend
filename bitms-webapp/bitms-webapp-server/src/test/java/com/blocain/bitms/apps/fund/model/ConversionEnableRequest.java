package com.blocain.bitms.apps.fund.model;

import javax.validation.constraints.NotNull;

import com.alibaba.fastjson.annotation.JSONField;
import com.blocain.bitms.apps.account.beans.AuthTokenRequest;
import com.blocain.bitms.apps.sdk.BitmsObject;
import com.blocain.bitms.apps.sdk.internal.mapping.ApiField;

/**
 * 互转可用查询model
 * Created by admin on 2018/3/21.
 */
public class ConversionEnableRequest extends BitmsObject
{
    @NotNull
    @JSONField(name = "auth_token")
    @ApiField("auth_token")
    protected String            authToken;

    public String getAuthToken()
    {
        return authToken;
    }

    public void setAuthToken(String authToken)
    {
        this.authToken = authToken;
    }
    /** 转出账户 */
    @NotNull(message = "转出账户不能为空")
    @ApiField("fromStockinfo")
    private String fromStockinfo;
    
    /** 转入账户 */
    @NotNull(message = "转入账户不能为空")
    @ApiField("toStockinfo")
    private String toStockinfo;
    
    public String getFromStockinfo()
    {
        return fromStockinfo;
    }
    
    public void setFromStockinfo(String fromStockinfo)
    {
        this.fromStockinfo = fromStockinfo;
    }
    
    public String getToStockinfo()
    {
        return toStockinfo;
    }
    
    public void setToStockinfo(String toStockinfo)
    {
        this.toStockinfo = toStockinfo;
    }
}
