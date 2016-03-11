/**
 * CFBMode
 * 
 * An ActionScript 3 implementation of the CFB confidentiality mode
 * Copyright (c) 2007 Henri Torgemane
 * 
 * See LICENSE.txt for full license information.
 */
package com.hurlant.crypto.symmetric;

import com.hurlant.crypto.symmetric.IMode;
import com.hurlant.crypto.symmetric.IPad;
import com.hurlant.crypto.symmetric.ISymmetricKey;
import com.hurlant.crypto.symmetric.IVMode;

import com.hurlant.util.ByteArray;

/**
	 * This is the "full" CFB.
	 * CFB1 and CFB8 are hiding somewhere else.
	 * 
	 * Note: The constructor accepts an optional padding argument, but ignores it otherwise.
	 */
class CFBMode extends IVMode implements IMode
{
    
    public function new(key : ISymmetricKey, padding : IPad = null)
    {
        super(key, null);
    }
    
    public function encrypt(src : ByteArray) : Void
    {
        var l : Int = src.length;
        var vector : ByteArray = getIV4e();
        var i : Int = 0;
        while (i < src.length){
            key.encrypt(vector);
            var chunk : Int = ((i + blockSize < l)) ? blockSize : l - i;
            for (j in 0...chunk){
                src[i + j] ^= vector[j];
            }
            vector.position = 0;
            vector.writeBytes(src, i, chunk);
            i += blockSize;
        }
    }
    
    public function decrypt(src : ByteArray) : Void
    {
        var l : Int = src.length;
        var vector : ByteArray = getIV4d();
        var tmp : ByteArray = new ByteArray();
        var i : Int = 0;
        while (i < src.length){
            key.encrypt(vector);
            var chunk : Int = ((i + blockSize < l)) ? blockSize : l - i;
            tmp.position = 0;
            tmp.writeBytes(src, i, chunk);
            for (j in 0...chunk){
                src[i + j] ^= vector[j];
            }
            vector.position = 0;
            vector.writeBytes(tmp);
            i += blockSize;
        }
    }
    
    public function toString() : String{
        return Std.string(key) + "-cfb";
    }
}
