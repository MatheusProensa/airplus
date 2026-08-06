package com.sulake.core.communication.wireformat
{
   import com.hurlant.util.UnknownHurlantUtil1;
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   import flash.utils.ByteArray;
   
   [SecureSWF(rename="true")]
   internal final class EvaMessageDataWrapper implements IMessageDataWrapper
   {
      private var _iD:int;
      
      private var UnknownVarFromEvaMessageDataWrapper_ByteArray_1:ByteArray;
      
      public function EvaMessageDataWrapper(param1:int, param2:ByteArray)
      {
         super();
         _iD = param1;
         UnknownVarFromEvaMessageDataWrapper_ByteArray_1 = param2;
      }
      
      public function getID() : int
      {
         return _iD;
      }
      
      public function readString() : String
      {
         return UnknownVarFromEvaMessageDataWrapper_ByteArray_1.readUTF();
      }
      
      public function readInteger() : int
      {
         return UnknownVarFromEvaMessageDataWrapper_ByteArray_1.readInt();
      }
      
      public function readLong() : Number
      {
         var _loc2_:uint = UnknownVarFromEvaMessageDataWrapper_ByteArray_1.readUnsignedInt();
         var _loc3_:uint = UnknownVarFromEvaMessageDataWrapper_ByteArray_1.readUnsignedInt();
         var _loc1_:* = !!(_loc2_ & 2147483648);
         if(_loc1_)
         {
            _loc2_ = uint(~_loc2_ & 0x7FFFFFFF);
            _loc3_ = uint(~_loc3_ + 1);
            if(_loc3_ == 0)
            {
               _loc2_ += 1;
            }
         }
         var _loc4_:Number = _loc2_ * 4294967296 + _loc3_;
         if(_loc1_)
         {
            _loc4_ = -_loc4_;
         }
         return _loc4_;
      }
      
      public function readBoolean() : Boolean
      {
         return UnknownVarFromEvaMessageDataWrapper_ByteArray_1.readBoolean();
      }
      
      public function readShort() : int
      {
         return UnknownVarFromEvaMessageDataWrapper_ByteArray_1.readShort();
      }
      
      public function readByte() : int
      {
         return UnknownVarFromEvaMessageDataWrapper_ByteArray_1.readByte();
      }
      
      public function readFloat() : Number
      {
         return UnknownVarFromEvaMessageDataWrapper_ByteArray_1.readFloat();
      }
      
      public function readDouble() : Number
      {
         return UnknownVarFromEvaMessageDataWrapper_ByteArray_1.readDouble();
      }
      
      public function get bytesAvailable() : uint
      {
         return UnknownVarFromEvaMessageDataWrapper_ByteArray_1.bytesAvailable;
      }
      
      public function toString() : String
      {
         return "id=" + _iD + ", pos=" + UnknownVarFromEvaMessageDataWrapper_ByteArray_1.position + ", data=" + UnknownHurlantUtil1.fromArray(UnknownVarFromEvaMessageDataWrapper_ByteArray_1,true);
      }
   }
}

