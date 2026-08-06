package com.sulake.habbo.communication.messages.parser.help
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   import com.sulake.core.communication.messages.IMessageParser;
   
   [SecureSWF(rename="true")]
   public class GuideSessionAttachedMessageParser implements IMessageParser
   {
      private var _asGuide:Boolean;
      
      private var _helpRequestType:int;
      
      private var _helpRequestDescription:String;
      
      private var _roleSpecificWaitTime:int;
      
      public function GuideSessionAttachedMessageParser()
      {
         super();
      }
      
      public function flush() : Boolean
      {
         return true;
      }
      
      public function parse(param1:IMessageDataWrapper) : Boolean
      {
         _asGuide = param1.readBoolean();
         _helpRequestType = param1.readInteger();
         _helpRequestDescription = param1.readString();
         _roleSpecificWaitTime = param1.readInteger();
         return true;
      }
      
      public function get asGuide() : Boolean
      {
         return _asGuide;
      }
      
      public function get helpRequestType() : int
      {
         return _helpRequestType;
      }
      
      public function get helpRequestDescription() : String
      {
         return _helpRequestDescription;
      }
      
      public function get roleSpecificWaitTime() : int
      {
         return _roleSpecificWaitTime;
      }
   }
}

