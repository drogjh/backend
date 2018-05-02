package com.blocain.bitms.payment.btc.client;

import java.util.Properties;

import org.apache.http.impl.client.CloseableHttpClient;

import com.blocain.bitms.payment.btc.core.client.BtcdClient;
import com.blocain.bitms.payment.btc.core.util.ResourceUtils;

/**A list of examples demonstrating the use of <i>bitcoind</i>'s control RPCs (via the JSON-RPC 
 * API).*/
public class ControlApi
{
    public static void main(String[] args) throws Exception
    {
        CloseableHttpClient httpProvider = ResourceUtils.getHttpProvider();
        Properties nodeConfig = ResourceUtils.getNodeConfig();
        BtcdClient client = new VerboseBtcdClientImpl(httpProvider, nodeConfig);
        client.getInfo();
        client.stop();
    }
}