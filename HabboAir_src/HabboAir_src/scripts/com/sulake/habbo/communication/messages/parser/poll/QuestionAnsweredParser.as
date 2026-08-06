package com.sulake.habbo.communication.messages.parser.poll
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   import com.sulake.core.communication.messages.IMessageParser;
   import com.sulake.core.utils.Map;
   
   [SecureSWF(rename="true")]
   public class QuestionAnsweredParser implements IMessageParser
   {
      private var _userId:int;
      
      private var _value:String;
      
      private var _answerCounts:Map;
      
      public function QuestionAnsweredParser()
      {
         super();
      }
      
      public function get userId() : int
      {
         return _userId;
      }
      
      public function get value() : String
      {
         return _value;
      }
      
      public function get answerCounts() : Map
      {
         return _answerCounts;
      }
      
      public function flush() : Boolean
      {
         _userId = -1;
         _value = "";
         _answerCounts = null;
         return false;
      }
      
      public function parse(param1:IMessageDataWrapper) : Boolean
      {
         var _loc3_:int = 0;
         var _loc4_:String = null;
         var _loc2_:int = 0;
         _userId = param1.readInteger();
         _value = param1.readString();
         _answerCounts = new Map();
         var _loc5_:int = param1.readInteger();
         _loc3_ = 0;
         while(_loc3_ < _loc5_)
         {
            _loc4_ = param1.readString();
            _loc2_ = param1.readInteger();
            _answerCounts.add(_loc4_,_loc2_);
            _loc3_++;
         }
         return true;
      }
   }
}

