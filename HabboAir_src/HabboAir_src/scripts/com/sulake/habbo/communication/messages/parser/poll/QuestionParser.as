package com.sulake.habbo.communication.messages.parser.poll
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   import com.sulake.core.communication.messages.IMessageParser;
   import flash.utils.Dictionary;
   
   [SecureSWF(rename="true")]
   public class QuestionParser implements IMessageParser
   {
      private var _pollType:String = null;
      
      private var _pollId:int = -1;
      
      private var _questionId:int = -1;
      
      private var _duration:int = -1;
      
      private var _question:Dictionary = null;
      
      public function QuestionParser()
      {
         super();
      }
      
      public function get pollType() : String
      {
         return _pollType;
      }
      
      public function get pollId() : int
      {
         return _pollId;
      }
      
      public function get questionId() : int
      {
         return _questionId;
      }
      
      public function get duration() : int
      {
         return _duration;
      }
      
      public function get question() : Dictionary
      {
         return _question;
      }
      
      public function flush() : Boolean
      {
         _pollType = null;
         _pollId = -1;
         _questionId = -1;
         _duration = -1;
         _question = null;
         return true;
      }
      
      public function parse(param1:IMessageDataWrapper) : Boolean
      {
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         _pollType = param1.readString();
         _pollId = param1.readInteger();
         _questionId = param1.readInteger();
         _duration = param1.readInteger();
         _question = new Dictionary();
         _question["id"] = param1.readInteger();
         _question["number"] = param1.readInteger();
         _question["type"] = param1.readInteger();
         _question["content"] = param1.readString();
         if(_question["type"] == 1 || _question["type"] == 2)
         {
            _question["selection_min"] = param1.readInteger();
            _loc2_ = param1.readInteger();
            var _loc4_:Array = [];
            var _loc5_:Array = [];
            _question["selections"] = _loc4_;
            _question["selection_values"] = _loc5_;
            _question["selection_count"] = _loc2_;
            _question["selection_max"] = _loc2_;
            _loc3_ = 0;
            while(_loc3_ < _loc2_)
            {
               _loc5_.push(param1.readString());
               _loc4_.push(param1.readString());
               _loc3_++;
            }
         }
         return true;
      }
   }
}

