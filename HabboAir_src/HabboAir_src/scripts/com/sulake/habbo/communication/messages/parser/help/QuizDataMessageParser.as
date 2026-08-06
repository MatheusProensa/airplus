package com.sulake.habbo.communication.messages.parser.help
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   import com.sulake.core.communication.messages.IMessageParser;
   
   [SecureSWF(rename="true")]
   public class QuizDataMessageParser implements IMessageParser
   {
      private var _quizCode:String;
      
      private var _questionIds:Array;
      
      public function QuizDataMessageParser()
      {
         super();
      }
      
      public function flush() : Boolean
      {
         _quizCode = null;
         _questionIds = null;
         return true;
      }
      
      public function parse(param1:IMessageDataWrapper) : Boolean
      {
         var _loc3_:int = 0;
         _quizCode = param1.readString();
         _questionIds = [];
         var _loc2_:int = param1.readInteger();
         _loc3_ = 0;
         while(_loc3_ < _loc2_)
         {
            _questionIds.push(param1.readInteger());
            _loc3_++;
         }
         return true;
      }
      
      public function get quizCode() : String
      {
         return _quizCode;
      }
      
      public function get questionIds() : Array
      {
         return _questionIds;
      }
   }
}

