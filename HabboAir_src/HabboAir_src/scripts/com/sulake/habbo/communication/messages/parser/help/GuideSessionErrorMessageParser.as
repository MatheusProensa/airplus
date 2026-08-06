package com.sulake.habbo.communication.messages.parser.help
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   import com.sulake.core.communication.messages.IMessageParser;
   
   [SecureSWF(rename="true")]
   public class GuideSessionErrorMessageParser implements IMessageParser
   {
      public static const UnknownConstFromGuideSessionErrorMessageParser_Int_1:int = 0;
      
      public static const UnknownConstFromGuideSessionErrorMessageParser_Int_2:int = 1;
      
      public static const UnknownConstFromGuideSessionErrorMessageParser_Int_3:int = 2;
      
      public static const UnknownConstFromGuideSessionErrorMessageParser_Int_4:int = 3;
      
      public static const UnknownConstFromGuideSessionErrorMessageParser_Int_5:int = 4;
      
      private var _errorCode:int;
      
      public function GuideSessionErrorMessageParser()
      {
         super();
      }
      
      public function flush() : Boolean
      {
         return true;
      }
      
      public function parse(param1:IMessageDataWrapper) : Boolean
      {
         _errorCode = param1.readInteger();
         return true;
      }
      
      public function get errorCode() : int
      {
         return _errorCode;
      }
   }
}

