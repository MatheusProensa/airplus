package com.sulake.habbo.communication.messages.parser.poll
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   import com.sulake.core.communication.messages.IMessageParser;
   
   [SecureSWF(rename="true")]
   public class PollContentsParser implements IMessageParser
   {
      private var _id:int = -1;
      
      private var _startMessage:String = "";
      
      private var _endMessage:String = "";
      
      private var _numQuestions:int = 0;
      
      private var _questionArray:Array = null;
      
      private var _npsPoll:Boolean = false;
      
      public function PollContentsParser()
      {
         super();
      }
      
      public function get id() : int
      {
         return _id;
      }
      
      public function get startMessage() : String
      {
         return _startMessage;
      }
      
      public function get endMessage() : String
      {
         return _endMessage;
      }
      
      public function get numQuestions() : int
      {
         return _numQuestions;
      }
      
      public function get questionArray() : Array
      {
         return _questionArray;
      }
      
      public function get npsPoll() : Boolean
      {
         return _npsPoll;
      }
      
      public function flush() : Boolean
      {
         _id = -1;
         _startMessage = "";
         _endMessage = "";
         _numQuestions = 0;
         _questionArray = null;
         return true;
      }
      
      public function parse(param1:IMessageDataWrapper) : Boolean
      {
         var _loc2_:int = 0;
         var _loc4_:PollQuestion = null;
         var _loc5_:int = 0;
         var _loc3_:int = 0;
         _id = param1.readInteger();
         _startMessage = param1.readString();
         _endMessage = param1.readString();
         _numQuestions = param1.readInteger();
         _questionArray = [];
         _loc2_ = 0;
         while(_loc2_ < _numQuestions)
         {
            _loc4_ = parseQuestion(param1);
            _loc5_ = param1.readInteger();
            _loc3_ = 0;
            while(_loc3_ < _loc5_)
            {
               _loc4_.children.push(parseQuestion(param1));
               _loc3_++;
            }
            _questionArray.push(_loc4_);
            _loc2_++;
         }
         _npsPoll = param1.readBoolean();
         return true;
      }
      
      private function parseQuestion(param1:IMessageDataWrapper) : PollQuestion
      {
         var _loc2_:int = 0;
         var _loc3_:PollQuestion = new PollQuestion();
         _loc3_.questionId = param1.readInteger();
         _loc3_.sortOrder = param1.readInteger();
         _loc3_.questionType = param1.readInteger();
         _loc3_.questionText = param1.readString();
         _loc3_.questionCategory = param1.readInteger();
         _loc3_.questionAnswerType = param1.readInteger();
         _loc3_.questionAnswerCount = param1.readInteger();
         if(_loc3_.questionType == 1 || _loc3_.questionType == 2)
         {
            _loc2_ = 0;
            while(_loc2_ < _loc3_.questionAnswerCount)
            {
               _loc3_.questionChoices.push(new PollChoice(param1.readString(),param1.readString(),param1.readInteger()));
               _loc2_++;
            }
         }
         return _loc3_;
      }
   }
}

