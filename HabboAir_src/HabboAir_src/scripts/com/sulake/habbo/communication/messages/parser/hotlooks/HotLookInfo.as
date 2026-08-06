package com.sulake.habbo.communication.messages.parser.hotlooks
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   
   [SecureSWF(rename="true")]
   public class HotLookInfo
   {
      private var _gender:String;
      
      private var _figureString:String;
      
      public function HotLookInfo(param1:IMessageDataWrapper)
      {
         super();
         _gender = param1.readString();
         _figureString = param1.readString();
      }
      
      public function get gender() : String
      {
         return _gender;
      }
      
      public function get figureString() : String
      {
         return _figureString;
      }
   }
}

