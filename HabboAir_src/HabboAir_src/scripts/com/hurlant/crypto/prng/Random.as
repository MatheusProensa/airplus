package com.hurlant.crypto.prng
{
   import com.hurlant.util.UnknownHurlantUtil2;
   import flash.system.Capabilities;
   import flash.system.System;
   import flash.text.Font;
   import flash.utils.ByteArray;
   import flash.utils.getTimer;
   
   public class Random
   {
      private var state:IPRNG;
      
      private var ready:Boolean = false;
      
      private var UnknownVarFromRandom_ByteArray_1:ByteArray;
      
      private var UnknownVarFromRandom_Int_1:int;
      
      private var pptr:int;
      
      private var seeded:Boolean = false;
      
      public function Random(param1:Class = null)
      {
         var _loc2_:* = 0;
         super();
         if(param1 == null)
         {
            param1 = ARC4;
         }
         state = new param1() as IPRNG;
         UnknownVarFromRandom_Int_1 = state.getPoolSize();
         UnknownVarFromRandom_ByteArray_1 = new ByteArray();
         pptr = 0;
         while(pptr < UnknownVarFromRandom_Int_1)
         {
            _loc2_ = 65536 * Math.random();
            UnknownVarFromRandom_ByteArray_1[pptr++] = _loc2_ >>> 8;
            UnknownVarFromRandom_ByteArray_1[pptr++] = _loc2_ & 0xFF;
         }
         pptr = 0;
         seed();
      }
      
      public function seed(param1:int = 0) : void
      {
         if(param1 == 0)
         {
            param1 = int(new Date().getTime());
         }
         var _loc2_:* = pptr++;
         var _loc3_:* = UnknownVarFromRandom_ByteArray_1[_loc2_] ^ param1 & 0xFF;
         UnknownVarFromRandom_ByteArray_1[_loc2_] = _loc3_;
         UnknownVarFromRandom_ByteArray_1[pptr++] ^= param1 >> 8 & 0xFF;
         UnknownVarFromRandom_ByteArray_1[pptr++] ^= param1 >> 16 & 0xFF;
         UnknownVarFromRandom_ByteArray_1[pptr++] ^= param1 >> 24 & 0xFF;
         pptr %= UnknownVarFromRandom_Int_1;
         seeded = true;
      }
      
      public function autoSeed() : void
      {
         var _loc2_:ByteArray = new ByteArray();
         _loc2_.writeUnsignedInt(System.totalMemory);
         _loc2_.writeUTF(Capabilities.serverString);
         _loc2_.writeUnsignedInt(getTimer());
         _loc2_.writeUnsignedInt(new Date().getTime());
         var _loc1_:Array = Font.enumerateFonts(true);
         for each(var _loc3_ in _loc1_)
         {
            _loc2_.writeUTF(_loc3_.fontName);
            _loc2_.writeUTF(_loc3_.fontStyle);
            _loc2_.writeUTF(_loc3_.fontType);
         }
         _loc2_.position = 0;
         while(_loc2_.bytesAvailable >= 4)
         {
            seed(_loc2_.readUnsignedInt());
         }
      }
      
      public function nextBytes(param1:ByteArray, param2:int) : void
      {
         while(param2--)
         {
            param1.writeByte(nextByte());
         }
      }
      
      public function nextByte() : int
      {
         if(!ready)
         {
            if(!seeded)
            {
               autoSeed();
            }
            state.init(UnknownVarFromRandom_ByteArray_1);
            UnknownVarFromRandom_ByteArray_1.length = 0;
            pptr = 0;
            ready = true;
         }
         return state.next();
      }
      
      public function dispose() : void
      {
         var _loc1_:* = 0;
         _loc1_ = 0;
         while(_loc1_ < UnknownVarFromRandom_ByteArray_1.length)
         {
            UnknownVarFromRandom_ByteArray_1[_loc1_] = Math.random() * 256;
            _loc1_++;
         }
         UnknownVarFromRandom_ByteArray_1.length = 0;
         UnknownVarFromRandom_ByteArray_1 = null;
         state.dispose();
         state = null;
         UnknownVarFromRandom_Int_1 = 0;
         pptr = 0;
         UnknownHurlantUtil2.gc();
      }
      
      public function toString() : String
      {
         return "random-" + state.toString();
      }
   }
}

