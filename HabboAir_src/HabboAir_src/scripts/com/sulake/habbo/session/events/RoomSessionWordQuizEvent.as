package com.sulake.habbo.session.events
{
   import com.sulake.core.utils.Map;
   import com.sulake.habbo.session.IRoomSession;
   import flash.utils.Dictionary;
   
   public class RoomSessionWordQuizEvent extends RoomSessionEvent
   {
      public static const UnknownConstFromRoomSessionWordQuizEvent_String_1:String = "RWPUW_NEW_QUESTION";
      
      public static const FINISHED:String = "RWPUW_QUESION_FINSIHED";
      
      public static const UnknownConstFromRoomSessionWordQuizEvent_String_2:String = "RWPUW_QUESTION_ANSWERED";
      
      private var _id:int = -1;
      
      private var _pollType:String = null;
      
      private var _pollId:int = -1;
      
      private var _questionId:int = -1;
      
      private var _duration:int = -1;
      
      private var _question:Dictionary = null;
      
      private var _userId:int = -1;
      
      private var _value:String;
      
      private var _answerCounts:Map;
      
      public function RoomSessionWordQuizEvent(param1:String, param2:IRoomSession, param3:int = -1)
      {
         _id = param3;
         super(param1,param2);
      }
      
      public function get id() : int
      {
         return _id;
      }
      
      public function get pollType() : String
      {
         return _pollType;
      }
      
      public function set pollType(param1:String) : void
      {
         _pollType = param1;
      }
      
      public function get pollId() : int
      {
         return _pollId;
      }
      
      public function set pollId(param1:int) : void
      {
         _pollId = param1;
      }
      
      public function get questionId() : int
      {
         return _questionId;
      }
      
      public function set questionId(param1:int) : void
      {
         _questionId = param1;
      }
      
      public function get duration() : int
      {
         return _duration;
      }
      
      public function set duration(param1:int) : void
      {
         _duration = param1;
      }
      
      public function get question() : Dictionary
      {
         return _question;
      }
      
      public function set question(param1:Dictionary) : void
      {
         _question = param1;
      }
      
      public function get userId() : int
      {
         return _userId;
      }
      
      public function set userId(param1:int) : void
      {
         _userId = param1;
      }
      
      public function get value() : String
      {
         return _value;
      }
      
      public function set value(param1:String) : void
      {
         _value = param1;
      }
      
      public function get answerCounts() : Map
      {
         return _answerCounts;
      }
      
      public function set answerCounts(param1:Map) : void
      {
         _answerCounts = param1;
      }
   }
}

