package com.sulake.habbo.ui.widget.messages
{
   public class RoomWidgetPollMessage extends RoomWidgetMessage
   {
      public static const START:String = "RWPM_START";
      
      public static const REJECT:String = "RWPM_REJECT";
      
      public static const ANSWER:String = "RWPM_ANSWER";
      
      private var _id:int = -1;
      
      private var _questionId:int = 0;
      
      private var _answers:Array = null;
      
      public function RoomWidgetPollMessage(param1:String, param2:int)
      {
         _id = param2;
         super(param1);
      }
      
      public function get id() : int
      {
         return _id;
      }
      
      public function get questionId() : int
      {
         return _questionId;
      }
      
      public function set questionId(param1:int) : void
      {
         _questionId = param1;
      }
      
      public function get answers() : Array
      {
         return _answers;
      }
      
      public function set answers(param1:Array) : void
      {
         _answers = param1;
      }
   }
}

