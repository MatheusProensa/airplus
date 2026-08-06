package com.sulake.habbo.communication.messages.parser.camera
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   import com.sulake.core.communication.messages.IMessageParser;
   
   [SecureSWF(rename="true")]
   public class CameraPublishStatusMessageParser implements IMessageParser
   {
      private var _isOk:Boolean = false;
      
      private var _secondsToWait:int = 0;
      
      private var _extraDataId:String;
      
      public function CameraPublishStatusMessageParser()
      {
         super();
      }
      
      public function isOk() : Boolean
      {
         return _isOk;
      }
      
      public function getSecondsToWait() : int
      {
         return _secondsToWait;
      }
      
      public function getExtraDataId() : String
      {
         return _extraDataId;
      }
      
      public function flush() : Boolean
      {
         _isOk = false;
         _secondsToWait = 0;
         _extraDataId = null;
         return true;
      }
      
      public function parse(param1:IMessageDataWrapper) : Boolean
      {
         _isOk = param1.readBoolean();
         _secondsToWait = param1.readInteger();
         if(_isOk && param1.bytesAvailable)
         {
            _extraDataId = param1.readString();
         }
         return true;
      }
   }
}

