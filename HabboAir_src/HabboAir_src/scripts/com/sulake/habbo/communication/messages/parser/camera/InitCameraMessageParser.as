package com.sulake.habbo.communication.messages.parser.camera
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   import com.sulake.core.communication.messages.IMessageParser;
   
   [SecureSWF(rename="true")]
   public class InitCameraMessageParser implements IMessageParser
   {
      private var _creditPrice:int = 0;
      
      private var _ducketPrice:int = 0;
      
      private var _publishDucketPrice:int = 0;
      
      public function InitCameraMessageParser()
      {
         super();
      }
      
      public function getCreditPrice() : int
      {
         return _creditPrice;
      }
      
      public function getDucketPrice() : int
      {
         return _ducketPrice;
      }
      
      public function getPublishDucketPrice() : int
      {
         return _publishDucketPrice;
      }
      
      public function flush() : Boolean
      {
         _creditPrice = 0;
         _ducketPrice = 0;
         _publishDucketPrice = 0;
         return true;
      }
      
      public function parse(param1:IMessageDataWrapper) : Boolean
      {
         _creditPrice = param1.readInteger();
         _ducketPrice = param1.readInteger();
         if(param1.bytesAvailable > 0)
         {
            _publishDucketPrice = param1.readInteger();
         }
         return true;
      }
   }
}

