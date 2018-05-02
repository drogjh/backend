package com.blocain.bitms.payment.btc.daemon.notification.worker;

import java.net.Socket;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import com.blocain.bitms.payment.btc.core.BitcoindException;
import com.blocain.bitms.payment.btc.core.CommunicationException;
import com.blocain.bitms.payment.btc.core.client.BtcdClient;
import com.blocain.bitms.payment.btc.core.domain.Transaction;

public class WalletNotificationWorker extends NotificationWorker
{
    private static final Logger LOG = LoggerFactory.getLogger(WalletNotificationWorker.class);
    
    public WalletNotificationWorker(Socket socket, BtcdClient client)
    {
        super(socket, client);
    }
    
    @Override
    protected Object getRelatedEntity(String txId)
    {
        Transaction transaction = new Transaction();
        transaction.setTxId(txId);
        if (getClient() != null)
        {
            try
            {
                LOG.debug("-- getRelatedEntity(..): fetching related transaction data from 'bitcoind' " + "(via JSON-RPC API)");
                transaction = getClient().getTransaction(txId);
            }
            catch (BitcoindException | CommunicationException e)
            {
                LOG.error("<< getRelatedEntity(..): failed to receive transaction data from 'bitcoind' " + "(txId: '{}'), message was: '{}'", txId, e.getMessage());
            }
        }
        return transaction;
    }
}