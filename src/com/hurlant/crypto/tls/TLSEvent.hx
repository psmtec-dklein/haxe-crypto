/**
 * TLSEvent
 * 
 * This is used by TLSEngine to let the application layer know
 * when we're ready for sending, or have received application data
 * Copyright (c) 2007 Henri Torgemane
 * 
 * See LICENSE.txt for full license information.
 */
package com.hurlant.crypto.tls;


import flash.events.Event;
import com.hurlant.util.ByteArray;

class TLSEvent extends Event
{
    
    public static inline var DATA : String = "data";
    public static inline var READY : String = "ready";
    public static inline var PROMPT_ACCEPT_CERT : String = "promptAcceptCert";
    
    public var data : ByteArray;
    
    public function new(type : String, data : ByteArray = null)
    {
        this.data = data;
        super(type, false, false);
    }
}
