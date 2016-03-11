/**
 * IVMode
 * 
 * An abstract class for confidentialy modes that rely on an initialization vector.
 * Copyright (c) 2007 Henri Torgemane
 * 
 * See LICENSE.txt for full license information.
 */
package com.hurlant.crypto.symmetric;

import com.hurlant.crypto.symmetric.PKCS5;
import nme.errors.Error;

import com.hurlant.crypto.prng.Random;
import com.hurlant.util.Memory;

import com.hurlant.util.ByteArray;

/**
	 * An "abtract" class to avoid redundant code in subclasses
	 */
class IVMode
{
    public var IV(get, set) : ByteArray;

    private var key : ISymmetricKey;
    private var padding : IPad;
    // random generator used to generate IVs
    private var prng : Random;
    // optional static IV. used for testing only.
    private var iv : ByteArray;
    // generated IV is stored here.
    private var lastIV : ByteArray;
    private var blockSize : Int;
    
    
    public function new(key : ISymmetricKey, padding : IPad = null)
    {
        this.key = key;
        blockSize = key.getBlockSize();
        if (padding == null) {
            padding = new PKCS5(blockSize);
        }
        else {
            padding.setBlockSize(blockSize);
        }
        this.padding = padding;
        
        prng = new Random();
        iv = null;
        lastIV = new ByteArray();
    }
    
    public function getBlockSize() : Int{
        return key.getBlockSize();
    }
    public function dispose() : Void{
        var i : Int;
        if (iv != null) {
            for (i in 0...iv.length){
                iv[i] = prng.nextByte();
            }
            iv.length = 0;
            iv = null;
        }
        if (lastIV != null) {
            for (i in 0...iv.length){
                lastIV[i] = prng.nextByte();
            }
            lastIV.length = 0;
            lastIV = null;
        }
        key.dispose();
        key = null;
        padding = null;
        prng.dispose();
        prng = null;
        Memory.gc();
    }
    /**
		 * Optional function to force the IV value.
		 * Normally, an IV gets generated randomly at every encrypt() call.
		 * Also, use this to set the IV before calling decrypt()
		 * (if not set before decrypt(), the IV is read from the beginning of the stream.)
		 */
    private function set_IV(value : ByteArray) : ByteArray{
        iv = value;
        lastIV.length = 0;
        lastIV.writeBytes(iv);
        return value;
    }
    private function get_IV() : ByteArray{
        return lastIV;
    }
    
    private function getIV4e() : ByteArray{
        var vec : ByteArray = new ByteArray();
        if (iv != null) {
            vec.writeBytes(iv);
        }
        else {
            prng.nextBytes(vec, blockSize);
        }
        lastIV.length = 0;
        lastIV.writeBytes(vec);
        return vec;
    }
    private function getIV4d() : ByteArray{
        var vec : ByteArray = new ByteArray();
        if (iv != null) {
            vec.writeBytes(iv);
        }
        else {
            throw new Error("an IV must be set before calling decrypt()");
        }
        return vec;
    }
}
