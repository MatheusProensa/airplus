package com.sulake.habbo.communication.messages.parser.catalog
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   import com.sulake.core.communication.messages.IMessageParser;
   
   [SecureSWF(rename="true")]
   public class LtdRaffleResultMessageEventParser implements IMessageParser
   {
      public static const UnknownConstFromLtdRaffleResultMessageEventParser_Int_1:int = 0;
      
      public static const UnknownConstFromLtdRaffleResultMessageEventParser_Int_2:int = 1;
      
      public static const UnknownConstFromLtdRaffleResultMessageEventParser_Int_3:int = 2;
      
      public static const UnknownConstFromLtdRaffleResultMessageEventParser_Int_4:int = 3;
      
      private var _className:String;
      
      private var _resultCode:int;
      
      public function LtdRaffleResultMessageEventParser()
      {
         super();
      }
      
      public function flush() : Boolean
      {
         _className = null;
         _resultCode = 0;
         return true;
      }
      
      public function parse(param1:IMessageDataWrapper) : Boolean
      {
         _className = param1.readString();
         _resultCode = param1.readByte();
         return true;
      }
      
      public function get className() : String
      {
         return _className;
      }
      
      public function get resultCode() : int
      {
         return _resultCode;
      }
      
      public function get hasWon() : Boolean
      {
         return _resultCode == 0;
      }
   }
}

