package com.sulake.habbo.communication.messages.parser.poll
{
   [SecureSWF(rename="true")]
   public class PollChoice
   {
      private var _value:String;
      
      private var _choiceText:String;
      
      private var _choiceType:int;
      
      public function PollChoice(param1:String, param2:String, param3:int)
      {
         super();
         _value = param1;
         _choiceText = param2;
         _choiceType = param3;
      }
      
      public function get value() : String
      {
         return _value;
      }
      
      public function set value(param1:String) : void
      {
         _value = param1;
      }
      
      public function get choiceText() : String
      {
         return _choiceText;
      }
      
      public function set choiceText(param1:String) : void
      {
         _choiceText = param1;
      }
      
      public function get choiceType() : int
      {
         return _choiceType;
      }
      
      public function set choiceType(param1:int) : void
      {
         _choiceType = param1;
      }
   }
}

