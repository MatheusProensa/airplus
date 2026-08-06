package com.sulake.habbo.communication.messages.parser.camera
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   import com.sulake.core.communication.messages.IMessageParser;
   
   [SecureSWF(rename="true")]
   public class ThumbnailStatusMessageParser implements IMessageParser
   {
      private var _isOk:Boolean = true;
      
      private var _isRenderLimitHit:Boolean = false;
      
      public function ThumbnailStatusMessageParser()
      {
         super();
      }
      
      public function isOk() : Boolean
      {
         return _isOk;
      }
      
      public function isRenderLimitHit() : Boolean
      {
         return _isRenderLimitHit;
      }
      
      public function flush() : Boolean
      {
         _isOk = true;
         _isRenderLimitHit = false;
         return true;
      }
      
      public function parse(param1:IMessageDataWrapper) : Boolean
      {
         if(param1.bytesAvailable)
         {
            _isOk = param1.readBoolean();
            _isRenderLimitHit = param1.readBoolean();
         }
         return true;
      }
   }
}

