package com.sulake.habbo.communication.messages.incoming.navigator
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   
   [SecureSWF(rename="true")]
   public class PopularTagData
   {
      private var _tagName:String;
      
      private var _userCount:int;
      
      public function PopularTagData(param1:IMessageDataWrapper)
      {
         super();
         _tagName = param1.readString();
         _userCount = param1.readInteger();
      }
      
      public function get tagName() : String
      {
         return _tagName;
      }
      
      public function get userCount() : int
      {
         return _userCount;
      }
   }
}

