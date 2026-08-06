package com.sulake.habbo.communication.messages.parser.help
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   import com.sulake.core.communication.messages.IMessageParser;
   
   [SecureSWF(rename="true")]
   public class QuizResultsMessageParser implements IMessageParser
   {
      private var _quizCode:String;
      
      private var _questionIdsForWrongAnswers:Array;
      
      public function QuizResultsMessageParser()
      {
         super();
      }
      
      public function flush() : Boolean
      {
         _quizCode = null;
         _questionIdsForWrongAnswers = null;
         return true;
      }
      
      public function parse(param1:IMessageDataWrapper) : Boolean
      {
         var _loc2_:int = 0;
         _quizCode = param1.readString();
         _questionIdsForWrongAnswers = [];
         var _loc3_:int = param1.readInteger();
         _loc2_ = 0;
         while(_loc2_ < _loc3_)
         {
            _questionIdsForWrongAnswers.push(param1.readInteger());
            _loc2_++;
         }
         return true;
      }
      
      public function get quizCode() : String
      {
         return _quizCode;
      }
      
      public function get questionIdsForWrongAnswers() : Array
      {
         return _questionIdsForWrongAnswers;
      }
   }
}

