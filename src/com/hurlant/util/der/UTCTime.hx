/**
 * UTCTime
 * 
 * An ASN1 type for UTCTime, represented as a Date
 * Copyright (c) 2007 Henri Torgemane
 * 
 * See LICENSE.txt for full license information.
 */
package com.hurlant.util.der;


import com.hurlant.util.ByteArray;

class UTCTime implements IAsn1Type
{
    private var type : Int;
    private var len : Int;
    public var date : Date;
    
    public function new(type : Int, len : Int)
    {
        this.type = type;
        this.len = len;
    }
    
    public function getLength() : Int
    {
        return len;
    }
    
    public function getType() : Int
    {
        return type;
    }
    
    public function setUTCTime(str : String) : Void{
        
        var year : Int = parseInt(str.substr(0, 2));
        if (year < 50) {
            year += 2000;
        }
        else {
            year += 1900;
        }
        var month : Int = parseInt(str.substr(2, 2));
        var day : Int = parseInt(str.substr(4, 2));
        var hour : Int = parseInt(str.substr(6, 2));
        var minute : Int = parseInt(str.substr(8, 2));
        // XXX this could be off by up to a day. parse the rest. someday.
        date = new Date(year, month - 1, day, hour, minute);
    }
    
    
    public function toString() : String{
        return DER.indent + "UTCTime[" + type + "][" + len + "][" + date + "]";
    }
    
    public function toDER() : ByteArray{
        return null;
    }
}
