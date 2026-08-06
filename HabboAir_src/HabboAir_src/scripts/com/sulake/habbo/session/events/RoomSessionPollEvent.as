package com.sulake.habbo.session.events
{
   import com.sulake.habbo.session.IRoomSession;
   
   public class RoomSessionPollEvent extends RoomSessionEvent
   {
      public static const OFFER:String = "RSPE_POLL_OFFER";
      
      public static const ERROR:String = "RSPE_POLL_ERROR";
      
      public static const CONTENT:String = "RSPE_POLL_CONTENT";
      
      private var _id:int = -1;
      
      private var _headline:String;
      
      private var _summary:String;
      
      private var _numQuestions:int = 0;
      
      private var _startMessage:String = "";
      
      private var _endMessage:String = "";
      
      private var _questionArray:Array = null;
      
      private var _npsPoll:Boolean = false;
      
      public function RoomSessionPollEvent(param1:String, param2:IRoomSession, param3:int)
      {
         _id = param3;
         super(param1,param2);
      }
      
      public function get id() : int
      {
         return _id;
      }
      
      public function get headline() : String
      {
         return _headline;
      }
      
      public function set headline(param1:String) : void
      {
         _headline = param1;
      }
      
      public function get summary() : String
      {
         return _summary;
      }
      
      public function set summary(param1:String) : void
      {
         _summary = param1;
      }
      
      public function get numQuestions() : int
      {
         return _numQuestions;
      }
      
      public function set numQuestions(param1:int) : void
      {
         _numQuestions = param1;
      }
      
      public function get startMessage() : String
      {
         return _startMessage;
      }
      
      public function set startMessage(param1:String) : void
      {
         _startMessage = param1;
      }
      
      public function get endMessage() : String
      {
         return _endMessage;
      }
      
      public function set endMessage(param1:String) : void
      {
         _endMessage = param1;
      }
      
      public function get questionArray() : Array
      {
         return _questionArray;
      }
      
      public function set questionArray(param1:Array) : void
      {
         _questionArray = param1;
      }
      
      public function get npsPoll() : Boolean
      {
         return _npsPoll;
      }
      
      public function set npsPoll(param1:Boolean) : void
      {
         _npsPoll = param1;
      }
   }
}

