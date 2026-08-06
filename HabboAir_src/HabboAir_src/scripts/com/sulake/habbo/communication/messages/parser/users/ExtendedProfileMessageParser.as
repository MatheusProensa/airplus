package com.sulake.habbo.communication.messages.parser.users
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   import com.sulake.core.communication.messages.IMessageParser;
   import com.sulake.habbo.communication.messages.incoming.users.ExtendedProfileData;
   
   [SecureSWF(rename="true")]
   public class ExtendedProfileMessageParser implements IMessageParser
   {
      private var _data:ExtendedProfileData;
      
      public function ExtendedProfileMessageParser()
      {
         super();
      }
      
      public function flush() : Boolean
      {
         _data = null;
         return true;
      }
      
      public function parse(param1:IMessageDataWrapper) : Boolean
      {
         _data = new ExtendedProfileData(param1);
         return true;
      }
      
      public function get data() : ExtendedProfileData
      {
         return _data;
      }
   }
}

