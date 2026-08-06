package com.sulake.habbo.communication.messages.parser.userdefinedroomevents.wiredmenu
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   import com.sulake.core.communication.messages.IMessageParser;
   
   public class WiredMenuErrorMessageParser implements IMessageParser
   {
      public static var UnknownVarFromWiredMenuErrorMessageParser_Int_1:int = 0;
      
      public static var UnknownVarFromWiredMenuErrorMessageParser_Int_2:int = 1;
      
      public static var UnknownVarFromWiredMenuErrorMessageParser_Int_3:int = 2;
      
      private var _errorCode:int;
      
      public function WiredMenuErrorMessageParser()
      {
         super();
      }
      
      public function flush() : Boolean
      {
         _errorCode = 0;
         return true;
      }
      
      public function parse(param1:IMessageDataWrapper) : Boolean
      {
         _errorCode = param1.readShort();
         return true;
      }
      
      public function get errorCode() : int
      {
         return _errorCode;
      }
   }
}

