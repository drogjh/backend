package com.blocain.bitms.payment.btc.daemon;

import com.blocain.bitms.payment.btc.core.common.Constants;
import com.blocain.bitms.payment.btc.core.common.Errors;

import lombok.Data;
import lombok.EqualsAndHashCode;
import lombok.ToString;

/**This exception is thrown to indicate an unrecoverable error in the client side of the 
 * 'callback-via-shell-command' notification API provided by <i>bitcoind</i>. Unless specifically
 * caught, this exception will result in the termination of the offending monitor/worker thread. */
@Data
@ToString(callSuper = true)
@EqualsAndHashCode(callSuper = false)
public class NotificationHandlerException extends RuntimeException
{
    private static final long serialVersionUID = 1L;
    
    private int               code;
    
    public NotificationHandlerException(Errors error)
    {
        this(error, Constants.STRING_EMPTY);
    }
    
    public NotificationHandlerException(Errors error, String additionalMsg)
    {
        super(error.getDescription() + additionalMsg);
        code = error.getCode();
    }
    
    public NotificationHandlerException(Errors error, Exception cause)
    {
        super(error.getDescription(), cause);
        code = error.getCode();
    }
}