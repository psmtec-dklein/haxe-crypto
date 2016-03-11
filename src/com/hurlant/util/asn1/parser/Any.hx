package com.hurlant.util.asn1.parser;

import com.hurlant.util.asn1.parser.ASN1Type;
import com.hurlant.util.asn1.parser.AnyType;

/**
 * Class for any
 */
@:final class ClassForAny
{
    import com.hurlant.util.asn1.type.ASN1Type;
    import com.hurlant.util.asn1.type.AnyType;
    
    public function any() : ASN1Type{
        return new AnyType();
    }

    public function new()
    {
    }
}
