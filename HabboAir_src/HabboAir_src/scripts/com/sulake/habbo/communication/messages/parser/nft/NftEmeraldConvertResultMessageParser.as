package com.sulake.habbo.communication.messages.parser.nft
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   import com.sulake.core.communication.messages.IMessageParser;
   
   [SecureSWF(rename="true")]
   public class NftEmeraldConvertResultMessageParser implements IMessageParser
   {
      public static const UnknownVarFromNftStorePurchaseMessageEventParser_Int_1:int = 0;
      
      public static const UnknownConstFromNftEmeraldConvertResultMessageParser_Int_1:int = 1;
      
      public static const UnknownConstFromNftEmeraldConvertResultMessageParser_Int_2:int = 2;
      
      public static const UnknownConstFromNftEmeraldConvertResultMessageParser_Int_3:int = 3;
      
      public static const UnknownConstFromNftEmeraldConvertResultMessageParser_Int_4:int = 4;
      
      public static const UnknownConstFromNftEmeraldConvertResultMessageParser_Int_5:int = 5;
      
      private var _stuffId:int;
      
      private var _result:int;
      
      public function NftEmeraldConvertResultMessageParser()
      {
         super();
      }
      
      public function flush() : Boolean
      {
         _stuffId = 0;
         _result = 0;
         return true;
      }
      
      public function parse(param1:IMessageDataWrapper) : Boolean
      {
         _stuffId = param1.readInteger();
         _result = param1.readShort();
         return true;
      }
      
      public function get stuffId() : int
      {
         return _stuffId;
      }
      
      public function get result() : int
      {
         return _result;
      }
   }
}

