package com.sulake.habbo.communication.messages.incoming.avatar
{
   import com.sulake.core.communication.messages.IMessageEvent;
   import com.sulake.core.communication.messages.MessageEvent;
   import com.sulake.habbo.communication.messages.parser.avatar.CheckUserNameResultMessageParser;
   
   [SecureSWF(rename="true")]
   public class CheckUserNameResultMessageEvent extends MessageEvent implements IMessageEvent
   {
      public static var UnknownVarFromChangeUserNameResultMessageEvent_Int_1:int = 0;
      
      public static var UnknownVarFromChangeUserNameResultMessageEvent_Int_2:int = 1;
      
      public static var UnknownVarFromChangeUserNameResultMessageEvent_Int_3:int = 2;
      
      public static var UnknownVarFromChangeUserNameResultMessageEvent_Int_4:int = 3;
      
      public static var UnknownVarFromChangeUserNameResultMessageEvent_Int_5:int = 4;
      
      public static var UnknownVarFromChangeUserNameResultMessageEvent_Int_6:int = 5;
      
      public function CheckUserNameResultMessageEvent(param1:Function)
      {
         super(param1,CheckUserNameResultMessageParser);
      }
      
      public function getParser() : CheckUserNameResultMessageParser
      {
         return _parser as CheckUserNameResultMessageParser;
      }
   }
}

