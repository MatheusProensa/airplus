package com.sulake.habbo.communication.messages.parser.room.furniture
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   import com.sulake.core.communication.messages.IMessageParser;
   import com.sulake.habbo.communication.messages.parser.room.engine.AreaHideMessageData;
   
   [SecureSWF(rename="true")]
   public class AreaHideMessageParser implements IMessageParser
   {
      private var _areaHideMessageData:AreaHideMessageData;
      
      public function AreaHideMessageParser()
      {
         super();
      }
      
      public function flush() : Boolean
      {
         _areaHideMessageData = null;
         return true;
      }
      
      public function parse(param1:IMessageDataWrapper) : Boolean
      {
         if(param1 == null)
         {
            return false;
         }
         _areaHideMessageData = new AreaHideMessageData(param1);
         return true;
      }
      
      public function get areaHideMessageData() : AreaHideMessageData
      {
         return _areaHideMessageData;
      }
   }
}

