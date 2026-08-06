package com.sulake.habbo.communication.messages.parser.room.session
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   import com.sulake.core.communication.messages.IMessageParser;
   
   [SecureSWF(rename="true")]
   public class CantConnectMessageParser implements IMessageParser
   {
      public static const UnknownConstFromCantConnectMessageParser_Int_1:int = 1;
      
      public static const UnknownConstFromCantConnectMessageParser_Int_2:int = 2;
      
      public static const UnknownConstFromCantConnectMessageParser_Int_3:int = 3;
      
      public static const UnknownConstFromCantConnectMessageParser_Int_4:int = 4;
      
      public static const UnknownConstFromCantConnectMessageParser_Int_5:int = 5;
      
      private var _reason:int = 0;
      
      private var _parameter:String = "";
      
      public function CantConnectMessageParser()
      {
         super();
      }
      
      public function flush() : Boolean
      {
         _reason = 0;
         _parameter = "";
         return true;
      }
      
      public function parse(param1:IMessageDataWrapper) : Boolean
      {
         _reason = param1.readInteger();
         if(_reason == 3)
         {
            _parameter = param1.readString();
         }
         else
         {
            _parameter = "";
         }
         return true;
      }
      
      public function get reason() : int
      {
         return _reason;
      }
      
      public function get parameter() : String
      {
         return _parameter;
      }
   }
}

