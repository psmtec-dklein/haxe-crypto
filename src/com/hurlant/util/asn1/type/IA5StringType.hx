package com.hurlant.util.asn1.type;

import com.hurlant.util.asn1.type.StringType;

import flash.net.RegisterClassAlias;

class IA5StringType extends StringType
{
    
    
    public function new(size1 : Int = Int.MAX_VALUE, size2 : Int = 0)
    {
        super(ASN1Type.IA5_STRING, size1, size2);
    }
    private static var init = {
        registerClassAlias("com.hurlant.util.asn1.IA5StringType", IA5StringType);
    }

}
