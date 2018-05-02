package com.blocain.bitms.payment.btc.core.domain.enums;

import com.blocain.bitms.payment.btc.core.common.Errors;
import com.fasterxml.jackson.annotation.JsonCreator;
import com.fasterxml.jackson.annotation.JsonIgnoreProperties;
import com.fasterxml.jackson.annotation.JsonInclude;
import com.fasterxml.jackson.annotation.JsonInclude.Include;
import com.fasterxml.jackson.annotation.JsonValue;

import lombok.AllArgsConstructor;
import lombok.ToString;

@ToString
@AllArgsConstructor
@JsonInclude(Include.NON_NULL)
@JsonIgnoreProperties(ignoreUnknown = true)
public enum ChainTypes
{
    MAINNET("main"),
    /** **/
    TESTNET("test"),
    /** **/
    REGTEST("regtest");
    private final String name;
    
    @JsonValue
    public String getName()
    {
        return name;
    }
    
    @JsonCreator
    public static ChainTypes forName(String name)
    {
        if (name != null)
        {
            for (ChainTypes chainType : ChainTypes.values())
            {
                if (name.equals(chainType.getName())) { return chainType; }
            }
        }
        throw new IllegalArgumentException(Errors.ARGS_BTCD_CHAINTYPE_UNSUPPORTED.getDescription());
    }
}