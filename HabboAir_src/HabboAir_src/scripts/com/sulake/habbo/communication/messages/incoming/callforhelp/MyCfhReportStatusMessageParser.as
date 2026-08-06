package com.sulake.habbo.communication.messages.incoming.callforhelp
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   import com.sulake.core.communication.messages.IMessageParser;
   
   [SecureSWF(rename="true")]
   public class MyCfhReportStatusMessageParser implements IMessageParser
   {
      private var _messages:Vector.<CfhReportMessage>;
      
      public function MyCfhReportStatusMessageParser()
      {
         super();
      }
      
      public function flush() : Boolean
      {
         _messages = null;
         return true;
      }
      
      public function parse(param1:IMessageDataWrapper) : Boolean
      {
         var _loc3_:int = 0;
         _messages = new Vector.<CfhReportMessage>();
         var _loc2_:int = param1.readInteger();
         _loc3_ = 0;
         while(_loc3_ < _loc2_)
         {
            _messages.push(new CfhReportMessage(param1));
            _loc3_ += 1;
         }
         return true;
      }
      
      public function get messages() : Vector.<CfhReportMessage>
      {
         return _messages;
      }
   }
}

