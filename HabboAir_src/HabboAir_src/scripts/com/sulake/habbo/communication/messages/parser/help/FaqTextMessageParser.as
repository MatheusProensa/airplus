package com.sulake.habbo.communication.messages.parser.help
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   import com.sulake.core.communication.messages.IMessageParser;
   
   [SecureSWF(rename="true")]
   public class FaqTextMessageParser implements IMessageParser
   {
      private var _questionId:int;
      
      private var _answerText:String;
      
      public function FaqTextMessageParser()
      {
         super();
      }
      
      public function get questionId() : int
      {
         return _questionId;
      }
      
      public function get answerText() : String
      {
         return _answerText;
      }
      
      public function flush() : Boolean
      {
         _questionId = -1;
         _answerText = null;
         return true;
      }
      
      public function parse(param1:IMessageDataWrapper) : Boolean
      {
         _questionId = param1.readInteger();
         _answerText = param1.readString();
         return true;
      }
   }
}

