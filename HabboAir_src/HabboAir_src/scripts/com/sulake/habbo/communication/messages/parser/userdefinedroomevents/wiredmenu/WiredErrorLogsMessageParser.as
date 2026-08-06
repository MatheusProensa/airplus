package com.sulake.habbo.communication.messages.parser.userdefinedroomevents.wiredmenu
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   import com.sulake.core.communication.messages.IMessageParser;
   import com.sulake.habbo.communication.messages.incoming.userdefinedroomevents.wiredmenu.WiredErrorData;
   
   public class WiredErrorLogsMessageParser implements IMessageParser
   {
      private var _errors:Vector.<WiredErrorData> = null;
      
      public function WiredErrorLogsMessageParser()
      {
         super();
      }
      
      public function flush() : Boolean
      {
         _errors = null;
         return true;
      }
      
      public function parse(param1:IMessageDataWrapper) : Boolean
      {
         var _loc3_:int = 0;
         _errors = new Vector.<WiredErrorData>();
         var _loc2_:int = param1.readInteger();
         _loc3_ = 0;
         while(_loc3_ < _loc2_)
         {
            _errors.push(new WiredErrorData(param1));
            _loc3_ += 1;
         }
         return true;
      }
      
      public function get errors() : Vector.<WiredErrorData>
      {
         return _errors;
      }
   }
}

