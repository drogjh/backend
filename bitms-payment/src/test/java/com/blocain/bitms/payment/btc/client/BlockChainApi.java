package com.blocain.bitms.payment.btc.client;

import java.util.Properties;

import org.apache.http.impl.client.CloseableHttpClient;

import com.blocain.bitms.payment.btc.core.client.BtcdClient;
import com.blocain.bitms.payment.btc.core.util.ResourceUtils;

/**A list of examples demonstrating the use of <i>bitcoind</i>'s block chain RPCs (via the JSON-RPC 
 * API).*/
public class BlockChainApi
{
    public static void main(String[] args) throws Exception
    {
        CloseableHttpClient httpProvider = ResourceUtils.getHttpProvider();
        Properties nodeConfig = ResourceUtils.getNodeConfig();
        BtcdClient client = new VerboseBtcdClientImpl(httpProvider, nodeConfig);
        client.getBestBlockHash();
        client.getBlock("00000000000000e8cf3d4fab91c642f5d5bb13339613aa915a42a7f1c91ab5ba");
        client.getBlock("00000000000000e8cf3d4fab91c642f5d5bb13339613aa915a42a7f1c91ab5ba", true);
        client.getBlockCount();
        client.getBlockHash(345168);
        client.getDifficulty();
        client.getMemPoolInfo();
    }
}